import 'package:flutter/material.dart';
import '../models/tarot_card.dart';
import '../theme/app_theme.dart';

class TarotCardWidget extends StatelessWidget {
  final DrawnCard drawnCard;

  const TarotCardWidget({super.key, required this.drawnCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 320,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3D2B5A), Color(0xFF1A0A2E)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.accentGold, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accentGold.withAlpha(51),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateZ(drawnCard.isReversed ? 3.14159 : 0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Card number
              Text(
                _getRomanNumeral(drawnCard.card.id),
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.accentGold.withAlpha(179),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 12),
              // Card icon
              _buildCardIcon(),
              const SizedBox(height: 16),
              // Card name
              Text(
                drawnCard.card.nameKo,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentGold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                drawnCard.card.name,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withAlpha(128),
                  letterSpacing: 1,
                ),
              ),
              if (drawnCard.isReversed) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(51),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.withAlpha(128)),
                  ),
                  // Counter-rotate so text is readable
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateZ(drawnCard.isReversed ? 3.14159 : 0),
                    child: const Text(
                      '역방향',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardIcon() {
    final icons = {
      0: Icons.emoji_people_rounded, // Fool
      1: Icons.auto_fix_high_rounded, // Magician
      2: Icons.visibility_rounded, // High Priestess
      3: Icons.local_florist_rounded, // Empress
      4: Icons.shield_rounded, // Emperor
      5: Icons.menu_book_rounded, // Hierophant
      6: Icons.favorite_rounded, // Lovers
      7: Icons.directions_car_rounded, // Chariot
      8: Icons.pets_rounded, // Strength
      9: Icons.lightbulb_rounded, // Hermit
      10: Icons.change_circle_rounded, // Wheel
      11: Icons.balance_rounded, // Justice
      12: Icons.swap_vert_rounded, // Hanged Man
      13: Icons.autorenew_rounded, // Death
      14: Icons.water_drop_rounded, // Temperance
      15: Icons.whatshot_rounded, // Devil
      16: Icons.flash_on_rounded, // Tower
      17: Icons.star_rounded, // Star
      18: Icons.nightlight_round, // Moon
      19: Icons.wb_sunny_rounded, // Sun
      20: Icons.campaign_rounded, // Judgement
      21: Icons.public_rounded, // World
    };

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppTheme.accentGold.withAlpha(51),
            Colors.transparent,
          ],
        ),
      ),
      child: Icon(
        icons[drawnCard.card.id] ?? Icons.auto_awesome,
        size: 64,
        color: AppTheme.accentGold,
      ),
    );
  }

  String _getRomanNumeral(int number) {
    const numerals = [
      'O', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX',
      'X', 'XI', 'XII', 'XIII', 'XIV', 'XV', 'XVI', 'XVII', 'XVIII', 'XIX',
      'XX', 'XXI',
    ];
    return number < numerals.length ? numerals[number] : '$number';
  }
}
