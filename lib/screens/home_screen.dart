import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onDrawCard;
  final VoidCallback onFortune;

  const HomeScreen({
    super.key,
    required this.onDrawCard,
    required this.onFortune,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.mysticGradient,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Title
              const Text(
                '✦ 오늘의 타로 ✦',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentGold,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getGreeting(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 40),

              // Tarot Card Draw Button
              _buildMainCard(
                context,
                icon: Icons.auto_awesome,
                title: '타로 카드 뽑기',
                subtitle: '오늘의 카드 한 장이\n당신의 하루를 안내합니다',
                gradient: const [Color(0xFF6C3483), Color(0xFF8E44AD)],
                onTap: onDrawCard,
              ),
              const SizedBox(height: 20),

              // Daily Fortune Button
              _buildMainCard(
                context,
                icon: Icons.stars_rounded,
                title: '오늘의 운세',
                subtitle: '총운 · 애정 · 금전 · 건강\n매일 새로운 운세를 확인하세요',
                gradient: const [Color(0xFF1E3A5F), Color(0xFF2E4A6F)],
                onTap: onFortune,
              ),
              const SizedBox(height: 40),

              // Daily tip
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(13),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.accentGold.withAlpha(51),
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.format_quote_rounded,
                      color: AppTheme.accentGold,
                      size: 28,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _getDailyQuote(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white60,
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.accentGold.withAlpha(64),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withAlpha(77),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: AppTheme.accentGold),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withAlpha(179),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withAlpha(128),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 6) return '고요한 새벽, 별이 당신을 인도합니다';
    if (hour < 12) return '좋은 아침이에요, 오늘도 빛나는 하루 되세요';
    if (hour < 18) return '활기찬 오후, 긍정의 에너지를 느껴보세요';
    return '평화로운 저녁, 내면의 소리에 귀 기울여보세요';
  }

  String _getDailyQuote() {
    final quotes = [
      '우주는 항상 당신에게 메시지를 보내고 있습니다.\n오늘, 그 메시지에 귀를 기울여보세요.',
      '모든 만남에는 이유가 있고,\n모든 경험에는 의미가 있습니다.',
      '당신의 직감은 영혼의 나침반입니다.\n그것을 믿으세요.',
      '오늘 하루도 당신은 충분히 빛나고 있습니다.',
      '마음을 열면 우주가 답을 보내줍니다.',
      '지금 이 순간, 당신은 정확히 있어야 할 곳에 있습니다.',
      '작은 변화가 큰 기적을 만들어냅니다.',
    ];
    final index = DateTime.now().day % quotes.length;
    return quotes[index];
  }
}
