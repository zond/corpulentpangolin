import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:corpulentpangolin/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('non-logged-in test', () async {
    testWidgets('start app', (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text("corpulentpangolin"));
    });
    testWidgets('home requires login', (WidgetTester tester) async {
      expect(find.text('Log in to see your games'), findsOneWidget);
    });
    testWidgets('live has no games', (WidgetTester tester) async {
      tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      tester.tap(find.text("Live games"));
      await tester.pumpAndSettle();
      expect(find.text('Log in to see your games'), findsOneWidget);
    });
    testWidgets('finished has no games', (WidgetTester tester) async {
      tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      tester.tap(find.text("Finished games"));
      await tester.pumpAndSettle();
      expect(find.text('Log in to see your games'), findsOneWidget);
    });
  });
}