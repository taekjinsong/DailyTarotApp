import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/tarot_card.dart';
import '../data/tarot_data.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<DrawnCard> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getStringList('tarot_history') ?? [];

      final history = historyJson.map((jsonStr) {
        final map = json.decode(jsonStr) as Map<String, dynamic>;
        return DrawnCard(
          card: TarotData.getCardById(map['cardId'] as int),
          isReversed: map['isReversed'] as bool,
          drawnAt: DateTime.parse(map['drawnAt'] as String),
          question: map['question'] as String?,
        );
      }).toList();

      // Sort by most recent first
      history.sort((a, b) => b.drawnAt.compareTo(a.drawnAt));

      setState(() {
        _history = history;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.mysticGradient,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 34),
            const Text(
              '타로 기록',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.accentGold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '지난 타로 리딩 기록을 확인하세요',
              style: TextStyle(fontSize: 14, color: Colors.white54),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: AppTheme.accentGold),
                    )
                  : _history.isEmpty
                      ? _buildEmptyState()
                      : _buildHistoryList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_rounded,
            size: 80,
            color: AppTheme.accentGold.withAlpha(77),
          ),
          const SizedBox(height: 20),
          const Text(
            '아직 기록이 없어요',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '타로 카드를 뽑으면\n여기에 기록이 저장됩니다',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white38,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _history.length,
      itemBuilder: (context, index) {
        final drawn = _history[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(13),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.accentGold.withAlpha(38),
            ),
          ),
          child: Row(
            children: [
              // Card icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.primaryPurple.withAlpha(128),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.auto_awesome,
                    color: AppTheme.accentGold,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          drawn.card.nameKo,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (drawn.isReversed) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withAlpha(51),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              '역',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      drawn.card.name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
              // Date
              Text(
                _formatDate(drawn.drawnAt),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white30,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}\n${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
