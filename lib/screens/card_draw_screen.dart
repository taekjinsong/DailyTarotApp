import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../data/tarot_data.dart';
import '../models/tarot_card.dart';
import '../widgets/tarot_card_widget.dart';
import '../widgets/banner_ad_widget.dart';
import '../services/ad_service.dart';

class CardDrawScreen extends StatefulWidget {
  const CardDrawScreen({super.key});

  @override
  State<CardDrawScreen> createState() => _CardDrawScreenState();
}

class _CardDrawScreenState extends State<CardDrawScreen>
    with SingleTickerProviderStateMixin {
  DrawnCard? _drawnCard;
  bool _isDrawing = false;
  bool _showResult = false;
  bool _showDetailedReading = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _drawCard() {
    if (_isDrawing) return;

    setState(() {
      _isDrawing = true;
      _showResult = false;
      _drawnCard = null;
    });

    _flipController.reset();

    // Simulate card shuffle delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final random = Random();
      final cardIndex = random.nextInt(TarotData.majorArcana.length);
      final isReversed = random.nextBool();

      setState(() {
        _drawnCard = DrawnCard(
          card: TarotData.majorArcana[cardIndex],
          isReversed: isReversed,
          drawnAt: DateTime.now(),
        );
        _isDrawing = false;
      });

      _flipController.forward().then((_) {
        setState(() => _showResult = true);
        _saveToHistory();
        AdService().onCardDrawn();
      });
    });
  }

  Future<void> _saveToHistory() async {
    if (_drawnCard == null) return;
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('tarot_history') ?? [];
    history.add(json.encode(_drawnCard!.toJson()));
    await prefs.setStringList('tarot_history', history);
  }

  void _resetDraw() {
    setState(() {
      _drawnCard = null;
      _showResult = false;
      _showDetailedReading = false;
    });
    _flipController.reset();
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
                '타로 카드 뽑기',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentGold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '마음을 가라앉히고 카드를 뽑아보세요',
                style: TextStyle(fontSize: 14, color: Colors.white54),
              ),
              const SizedBox(height: 40),

              // Card area
              AnimatedBuilder(
                animation: _flipAnimation,
                builder: (context, child) {
                  final angle = _flipAnimation.value * pi;
                  final showFront = _flipAnimation.value >= 0.5;

                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    child: showFront && _drawnCard != null
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateY(pi),
                            child: TarotCardWidget(
                              drawnCard: _drawnCard!,
                            ),
                          )
                        : _buildCardBack(),
                  );
                },
              ),
              const SizedBox(height: 30),

              // Draw button
              if (_drawnCard == null && !_isDrawing)
                ElevatedButton.icon(
                  onPressed: _drawCard,
                  icon: const Icon(Icons.auto_awesome, size: 20),
                  label: const Text(
                    '카드 뽑기',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryPurple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                  ),
                ),

              if (_isDrawing)
                const Column(
                  children: [
                    CircularProgressIndicator(color: AppTheme.accentGold),
                    SizedBox(height: 16),
                    Text(
                      '카드를 섞고 있습니다...',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ],
                ),

              // Result interpretation
              if (_showResult && _drawnCard != null) ...[
                const SizedBox(height: 10),
                _buildInterpretation(),
                // 상세 해석 (보상형 광고 또는 프리미엄)
                if (!_showDetailedReading && !AdService().isPremium) ...[
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      AdService().showRewardedAd(
                        onRewarded: () {
                          if (mounted) {
                            setState(() => _showDetailedReading = true);
                          }
                        },
                      );
                    },
                    icon: const Icon(Icons.play_circle_outline, size: 20),
                    label: const Text('광고 보고 상세 해석 보기'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.amber,
                      side: const BorderSide(color: Colors.amber),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
                if (_showDetailedReading || AdService().isPremium) ...[
                  const SizedBox(height: 16),
                  _buildDetailedReading(),
                ],
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: _resetDraw,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('다시 뽑기'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.accentGold,
                    side: const BorderSide(color: AppTheme.accentGold),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const BannerAdWidget(),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      width: 200,
      height: 320,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2D1B4E), Color(0xFF4A2C6E)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accentGold.withAlpha(128), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPurple.withAlpha(102),
            blurRadius: 20,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 48,
              color: AppTheme.accentGold.withAlpha(179),
            ),
            const SizedBox(height: 12),
            Text(
              '✦ TAROT ✦',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.accentGold.withAlpha(179),
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedReading() {
    final card = _drawnCard!;
    final isReversed = card.isReversed;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withAlpha(77)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.star_rounded, color: Colors.amber, size: 20),
              SizedBox(width: 8),
              Text(
                '상세 해석',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            isReversed
                ? '${card.card.nameKo} 역방향이 나왔습니다.\n\n'
                    '이 카드는 내면의 에너지가 막혀있거나 아직 준비되지 않은 상태를 나타냅니다. '
                    '지금은 무리하게 앞으로 나아가기보다 잠시 멈추고 자신을 돌아볼 시간입니다.\n\n'
                    '오늘의 조언: 서두르지 마세요. 때가 되면 자연스럽게 길이 열릴 것입니다. '
                    '내면의 목소리에 귀를 기울이고, 자신의 감정을 솔직하게 마주해보세요.'
                : '${card.card.nameKo} 정방향이 나왔습니다.\n\n'
                    '이 카드는 긍정적인 에너지가 당신에게 흐르고 있음을 의미합니다. '
                    '지금 하고 있는 일에 확신을 가지고 계속 나아가세요.\n\n'
                    '오늘의 조언: 당신의 직감을 믿으세요. 우주가 당신을 올바른 방향으로 '
                    '이끌고 있습니다. 새로운 기회가 찾아올 수 있으니 열린 마음을 유지하세요.',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterpretation() {
    final card = _drawnCard!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppTheme.accentGold, size: 20),
              const SizedBox(width: 8),
              const Text(
                '카드 해석',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Keywords
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: card.keywordText.split(', ').map((keyword) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryPurple.withAlpha(128),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.accentGold.withAlpha(77),
                  ),
                ),
                child: Text(
                  keyword,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.accentGold,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            card.interpretation,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white70,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
