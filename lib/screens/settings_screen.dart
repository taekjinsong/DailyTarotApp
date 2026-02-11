import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Container(
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('프리미엄 기능은 곧 출시됩니다!'),
                            backgroundColor: AppTheme.primaryPurple,
                          ),
                        );
                      },
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
              ),
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

  Widget _buildSettingsItem(
    IconData icon,
    String title,
    String subtitle, {
    Widget? trailing,
  }) {
    return Container(
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
    );
  }
}
