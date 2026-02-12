import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/ad_config.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool _isPremium = false;
  int _drawCount = 0;

  bool get isPremium => _isPremium;

  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool('is_premium') ?? false;
    _drawCount = prefs.getInt('draw_count') ?? 0;
    if (!_isPremium) {
      _loadInterstitialAd();
      _loadRewardedAd();
    }
  }

  void setPremium(bool value) {
    _isPremium = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('is_premium', value);
    });
  }

  // --- 배너 광고 ---
  BannerAd? createBannerAd() {
    if (_isPremium) return null;
    return BannerAd(
      adUnitId: AdConfig.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  // --- 전면 광고 ---
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdConfig.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  Future<void> onCardDrawn() async {
    if (_isPremium) return;
    _drawCount++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('draw_count', _drawCount);
    if (_drawCount % 3 == 0) {
      showInterstitialAd();
    }
  }

  void showInterstitialAd() {
    if (_isPremium) return;
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  // --- 보상형 광고 ---
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdConfig.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
        },
      ),
    );
  }

  bool get isRewardedAdReady => _rewardedAd != null;

  void showRewardedAd({required Function() onRewarded}) {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _loadRewardedAd();
        },
      );
      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        onRewarded();
      });
      _rewardedAd = null;
    }
  }

  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }
}
