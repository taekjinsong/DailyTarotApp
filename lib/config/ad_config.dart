/// AdMob 광고 ID 설정
/// 실제 배포 시 테스트 ID를 실제 ID로 교체하세요.
///
/// AdMob 광고 단위 ID 발급 방법:
/// 1. admob.google.com 접속
/// 2. 앱 > 앱 추가 > Android 앱 등록
/// 3. 앱 ID 발급 (AndroidManifest.xml에도 동일하게 적용)
/// 4. 광고 단위 > 광고 단위 추가 > 배너/전면/보상형 각각 생성
/// 5. 아래 ID를 발급받은 실제 ID로 교체
class AdConfig {
  AdConfig._();

  // ========================================
  // TODO: 실제 배포 전에 아래 ID를 교체하세요!
  // 현재: Google 공식 테스트 광고 ID
  // ========================================

  /// AdMob 앱 ID (AndroidManifest.xml에도 동일하게 적용해야 함)
  /// 실제 ID 형식: ca-app-pub-3412266105383498~XXXXXXXXXX
  static const String appId = 'ca-app-pub-3940256099942544~3347511713';

  /// 배너 광고 단위 ID
  static const String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  /// 전면 광고 단위 ID
  static const String interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';

  /// 보상형 광고 단위 ID
  static const String rewardedAdUnitId = 'ca-app-pub-3940256099942544/5224354917';
}
