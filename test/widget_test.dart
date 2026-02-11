import 'package:flutter_test/flutter_test.dart';
import 'package:daily_tarot_app/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const DailyTarotApp());
    expect(find.text('오늘의 타로'), findsWidgets);
  });
}
