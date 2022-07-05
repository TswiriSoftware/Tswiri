import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_google_ml_kit/main.dart' as app;

void main() {
  group('Testing App', () {
    var binding = TestWidgetsFlutterBinding.ensureInitialized();
    if (binding is LiveTestWidgetsFlutterBinding) {
      binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
    }

    testWidgets('Test', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Search'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      ///1. Reset Database.
      //i. Navigate to Integration Test
      await tester.scrollUntilVisible(find.text('Integration Test'), 500.0);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      //ii. Tap Integration Test
      await tester.tap(find.text('Integration Test'));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      //iii. Navigate to Database
      await tester.scrollUntilVisible(find.text('Database'), 500.0);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      await tester.tap(find.text('Database'));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      //iv. Reset Database
      await tester.scrollUntilVisible(
          find.byKey(const Key('reset_database')), 500.0);
      await tester.tap(find.byKey(const Key('reset_database')));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      //v. Load Barcodes
      await tester.scrollUntilVisible(
          find.byKey(const Key('load_barcodes')), 500.0);
      await tester.tap(find.byKey(const Key('load_barcodes')));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));

      //Check Values
      await tester.scrollUntilVisible(
          find.byKey(const Key('containerTypes')), 500.0);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(find.text('4'), findsOneWidget);

      await tester.scrollUntilVisible(
          find.byKey(const Key('barcodePropertys')), 500.0);
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(find.text('50'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(milliseconds: 100));
    });
  });
}
