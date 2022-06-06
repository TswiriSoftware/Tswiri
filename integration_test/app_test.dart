import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_google_ml_kit/main.dart' as app;

void main() {
  group('Testing App Performance Tests', () {
    var binding = TestWidgetsFlutterBinding.ensureInitialized();
    if (binding is LiveTestWidgetsFlutterBinding) {
      binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
    }

    testWidgets('Integration Test', (tester) async {
      app.main();

      //This is time to accept permissions
      await tester.pumpAndSettle(const Duration(seconds: 3));

      //1. Navigate to containers.
      await tester.tap(find.text('Containers'));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.tap(find.byType(FloatingActionButton));
      // await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byKey(const Key('shelf')), findsOneWidget);
      await tester.tap(find.byKey(const Key('shelf')));
      await tester.pump(const Duration(seconds: 5));
      //Add a button to create a 'fake barcode'
    });
  });
}
