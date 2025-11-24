import 'package:fiteats/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FitEatsApp());

    // Verify that app builds without errors
    expect(find.byType(FitEatsApp), findsOneWidget);
  });
}
