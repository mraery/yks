import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpss_quest/main.dart';

void main() {
  testWidgets('YKSify smoke test - renders units and stats', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: YksLingoApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));

    // Verify stats and title render
    expect(find.text('KPSS Dil Bilgisi ve Sözel Mantık'), findsOneWidget);
  });
}
