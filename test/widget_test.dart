import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: HomeView(),
    );
  }

  testWidgets(
    'Check Home Screen Widgets',
    (WidgetTester tester) async {
      //Title.
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
      expect(find.text('Sunbird', skipOffstage: false), findsOneWidget);
      //Search.
      await tester.scrollUntilVisible(find.byKey(const Key('Search')), 5);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('Search')), findsOneWidget);
      //Tags.
      await tester.scrollUntilVisible(find.byKey(const Key('Tags')), 5);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('Tags')), findsOneWidget);
      //Gallery.
      await tester.scrollUntilVisible(find.byKey(const Key('Gallery')), 5);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('Gallery')), findsOneWidget);
      //Calibration.
      await tester.scrollUntilVisible(find.byKey(const Key('Calibration')), 5);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('Calibration')), findsOneWidget);
      //Container Types.
      await tester.scrollUntilVisible(
          find.byKey(const Key('Container Types')), 5);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('Container Types')), findsOneWidget);
      //Barcode Generator.
      await tester.scrollUntilVisible(
          find.byKey(const Key('Barcode Generator')), 5);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('Barcode Generator')), findsOneWidget);
      //Barcodes.
      await tester.scrollUntilVisible(find.byKey(const Key('Barcodes')), 5);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('Barcodes')), findsOneWidget);
      //Tree Visualizer.
      await tester.scrollUntilVisible(
          find.byKey(const Key('Tree Visualizer')), 5);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('Tree Visualizer')), findsOneWidget);
    },
  );
}
