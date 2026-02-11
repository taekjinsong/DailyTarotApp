class TarotCard {
  final int id;
  final String name;
  final String nameKo;
  final String imagePath;
  final String description;
  final String reverseDescription;
  final String keywords;
  final String reverseKeywords;
  final TarotCardType type;

  const TarotCard({
    required this.id,
    required this.name,
    required this.nameKo,
    required this.imagePath,
    required this.description,
    required this.reverseDescription,
    required this.keywords,
    required this.reverseKeywords,
    this.type = TarotCardType.majorArcana,
  });
}

enum TarotCardType {
  majorArcana,
  minorArcana,
}

class DrawnCard {
  final TarotCard card;
  final bool isReversed;
  final DateTime drawnAt;
  final String? question;

  const DrawnCard({
    required this.card,
    required this.isReversed,
    required this.drawnAt,
    this.question,
  });

  String get interpretation =>
      isReversed ? card.reverseDescription : card.description;

  String get keywordText =>
      isReversed ? card.reverseKeywords : card.keywords;

  Map<String, dynamic> toJson() => {
        'cardId': card.id,
        'isReversed': isReversed,
        'drawnAt': drawnAt.toIso8601String(),
        'question': question,
      };
}
