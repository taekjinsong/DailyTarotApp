import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/fortune_data.dart';
import '../widgets/banner_ad_widget.dart';

class FortuneScreen extends StatefulWidget {
  const FortuneScreen({super.key});

  @override
  State<FortuneScreen> createState() => _FortuneScreenState();
}

class _FortuneScreenState extends State<FortuneScreen> {
  DateTime? _birthday;
  Map<String, String>? _fortune;

  void _selectBirthday() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthday ?? DateTime(1995, 1, 1),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.accentGold,
              surface: AppTheme.primaryDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _birthday = picked;
        _fortune = FortuneData.getDailyFortune(picked);
      });
    }
  }

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
                '오늘의 운세',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentGold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '생년월일을 입력하면 오늘의 운세를 알려드려요',
                style: TextStyle(fontSize: 14, color: Colors.white54),
              ),
              const SizedBox(height: 30),

              // Birthday selector
              GestureDetector(
                onTap: _selectBirthday,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(13),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.accentGold.withAlpha(77),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cake_rounded,
                          color: AppTheme.accentGold),
                      const SizedBox(width: 12),
                      Text(
                        _birthday != null
                            ? '${_birthday!.year}년 ${_birthday!.month}월 ${_birthday!.day}일'
                            : '생년월일을 선택하세요',
                        style: TextStyle(
                          fontSize: 16,
                          color: _birthday != null
                              ? Colors.white
                              : Colors.white54,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.edit_calendar_rounded,
                          color: Colors.white38, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              if (_fortune != null) ...[
                // Lucky info row
                Row(
                  children: [
                    Expanded(
                      child: _buildLuckyChip(
                        '행운의 색',
                        _fortune!['luckyColor']!,
                        Icons.palette_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildLuckyChip(
                        '행운의 수',
                        _fortune!['luckyNumber']!,
                        Icons.tag_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Fortune cards
                _buildFortuneCard(
                  '총운',
                  _fortune!['overall']!,
                  Icons.auto_awesome_rounded,
                  int.parse(_fortune!['overallScore']!),
                  const [Color(0xFF6C3483), Color(0xFF8E44AD)],
                ),
                const SizedBox(height: 14),
                _buildFortuneCard(
                  '애정운',
                  _fortune!['love']!,
                  Icons.favorite_rounded,
                  int.parse(_fortune!['loveScore']!),
                  const [Color(0xFFC0392B), Color(0xFFE74C3C)],
                ),
                const SizedBox(height: 14),
                _buildFortuneCard(
                  '금전운',
                  _fortune!['money']!,
                  Icons.monetization_on_rounded,
                  int.parse(_fortune!['moneyScore']!),
                  const [Color(0xFF27AE60), Color(0xFF2ECC71)],
                ),
                const SizedBox(height: 14),
                _buildFortuneCard(
                  '건강운',
                  _fortune!['health']!,
                  Icons.health_and_safety_rounded,
                  int.parse(_fortune!['healthScore']!),
                  const [Color(0xFF2980B9), Color(0xFF3498DB)],
                ),
                const SizedBox(height: 16),
                const BannerAdWidget(),
                const SizedBox(height: 20),
              ] else ...[
                const SizedBox(height: 60),
                Icon(
                  Icons.stars_rounded,
                  size: 80,
                  color: AppTheme.accentGold.withAlpha(77),
                ),
                const SizedBox(height: 20),
                const Text(
                  '생년월일을 선택하면\n오늘의 운세를 확인할 수 있어요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white38,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLuckyChip(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accentGold.withAlpha(51)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.accentGold, size: 22),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.white38)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentGold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFortuneCard(
    String title,
    String content,
    IconData icon,
    int score,
    List<Color> colors,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [colors[0].withAlpha(51), colors[1].withAlpha(26)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors[0].withAlpha(77)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: colors[1], size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colors[1],
                ),
              ),
              const Spacer(),
              // Score
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colors[0].withAlpha(77),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$score점',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: colors[1],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Score bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: score / 100,
              backgroundColor: Colors.white.withAlpha(26),
              valueColor: AlwaysStoppedAnimation<Color>(colors[1]),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
