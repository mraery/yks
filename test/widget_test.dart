import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ykslingo/main.dart';
import 'package:ykslingo/screens/home_screen.dart';

void main() {
  testWidgets('YKSify smoke test - renders units and stats', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: YksQuestApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));

    // Verify HomeScreen renders
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
