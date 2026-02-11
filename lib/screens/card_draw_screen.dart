import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/tarot_data.dart';
import '../models/tarot_card.dart';
import '../widgets/tarot_card_widget.dart';

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
      });
    });
  }

  void _resetDraw() {
    setState(() {
      _drawnCard = null;
      _showResult = false;
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
