import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_google_ml_kit/main.dart' as app;

void main() {
  group('Testing App Performance Tests', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Integration Test', (tester) async {
      await app.main();
      await tester.pumpAndSettle();
      expect(find.text('Sunbird'), findsOneWidget);
      await tester.tap(find.text('Calibration'));
      await tester.pumpAndSettle(const Duration(milliseconds: 1200));
    });
  });
}
