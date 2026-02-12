import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/purchase_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _purchaseService = PurchaseService();

  @override
  void initState() {
    super.initState();
    _purchaseService.premiumNotifier.addListener(_onPremiumChanged);
  }

  @override
  void dispose() {
    _purchaseService.premiumNotifier.removeListener(_onPremiumChanged);
    super.dispose();
  }

  void _onPremiumChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _onRestorePurchases() async {
    await _purchaseService.restorePurchases();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('구매 복원을 요청했습니다.'),
        backgroundColor: AppTheme.primaryPurple,
      ),
    );
  }

  void _showSubscriptionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.primaryDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _buildSubscriptionSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = _purchaseService.isPremium;

    return Container(
      decoration: AppTheme.mysticGradient,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                '설정',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentGold,
                ),
              ),
              const SizedBox(height: 30),

              // Premium banner
              if (isPremium) _buildPremiumActiveBanner() else _buildPremiumUpgradeBanner(),
              const SizedBox(height: 24),

              // Settings items
              _buildSettingsItem(
                Icons.notifications_rounded,
                '알림 설정',
                '매일 운세 알림 받기',
                trailing: Switch(
                  value: false,
                  onChanged: (v) {},
                  activeTrackColor: AppTheme.accentGold,
                ),
              ),
              _buildSettingsItem(
                Icons.restore_rounded,
                '구매 복원',
                '이전 구매를 복원합니다',
                onTap: _onRestorePurchases,
              ),
              _buildSettingsItem(
                Icons.language_rounded,
                '언어',
                '한국어',
              ),
              _buildSettingsItem(
                Icons.info_outline_rounded,
                '앱 버전',
                '1.0.0',
              ),
              _buildSettingsItem(
                Icons.privacy_tip_outlined,
                '개인정보 처리방침',
                '',
              ),
              _buildSettingsItem(
                Icons.description_outlined,
                '이용약관',
                '',
              ),
              _buildSettingsItem(
                Icons.mail_outline_rounded,
                '문의하기',
                'songtakjin@gmail.com',
              ),
              const SizedBox(height: 40),
              Text(
                '오늘의 타로 v1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(51),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumActiveBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accentGold.withAlpha(128)),
      ),
      child: const Column(
        children: [
          Icon(Icons.verified_rounded, color: AppTheme.accentGold, size: 40),
          SizedBox(height: 12),
          Text(
            '프리미엄 활성',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '광고 없음 · 무제한 타로 · 상세 해석',
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumUpgradeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C3483), Color(0xFF8E44AD)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accentGold.withAlpha(128)),
      ),
      child: Column(
        children: [
          const Icon(Icons.workspace_premium_rounded,
              color: AppTheme.accentGold, size: 40),
          const SizedBox(height: 12),
          const Text(
            '프리미엄으로 업그레이드',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '광고 제거 · 무제한 타로 · 상세 해석',
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _showSubscriptionSheet,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentGold,
              foregroundColor: AppTheme.primaryDark,
            ),
            child: const Text(
              '프리미엄 시작하기',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionSheet() {
    final products = _purchaseService.products;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Icon(Icons.workspace_premium_rounded,
              color: AppTheme.accentGold, size: 48),
          const SizedBox(height: 16),
          const Text(
            '프리미엄 구독',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '모든 프리미엄 기능을 이용하세요',
            style: TextStyle(fontSize: 14, color: Colors.white54),
          ),
          const SizedBox(height: 24),
          // 프리미엄 혜택 목록
          _buildBenefitRow(Icons.block_rounded, '모든 광고 제거'),
          _buildBenefitRow(Icons.all_inclusive_rounded, '무제한 타로 카드 뽑기'),
          _buildBenefitRow(Icons.auto_awesome, '상세 카드 해석'),
          const SizedBox(height: 24),
          if (products.isEmpty) ...[
            const Text(
              '구독 상품을 불러오는 중...\n(Google Play 연결이 필요합니다)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.white54),
            ),
            const SizedBox(height: 16),
          ],
          // 월간 구독 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _startPurchase(PurchaseService.premiumMonthlyId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentGold,
                foregroundColor: AppTheme.primaryDark,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '월간 구독 시작하기',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // 연간 구독 버튼
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                _startPurchase(PurchaseService.premiumYearlyId);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.accentGold,
                side: const BorderSide(color: AppTheme.accentGold),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '연간 구독 (2개월 무료!)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '구독은 언제든지 취소할 수 있습니다',
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBenefitRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.accentGold, size: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _startPurchase(String productId) async {
    try {
      await _purchaseService.buyPremium(productId: productId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('구매 처리 중 오류: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title,
    String subtitle, {
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white54, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white38,
                      ),
                    ),
                ],
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white24,
                ),
          ],
        ),
      ),
    );
  }
}
