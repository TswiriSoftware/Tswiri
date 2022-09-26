import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tswiri/main.dart' as app;

import 'test_import_function.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify-import-function', (tester) async {
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 1));
      bool foundBetaPopup = tester.any(find.byKey(const Key('noted')));

      if (foundBetaPopup) {
        await tester.tap(find.byKey(const Key('noted')));
        await tester.pumpAndSettle();
      }

      //Test the manualImport functionality.
      await testImportFunction(tester);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // //Test the utilities view.
      // await testUtilitiesView(tester);
      // await tester.pumpAndSettle(const Duration(seconds: 1));

      // //Test the app info screen.
      // await testAppInfoScreen(tester);
      // await tester.pumpAndSettle(const Duration(seconds: 1));

      // //Test the gallery view.
      // await testGalleryView(tester);
      // await tester.pumpAndSettle(const Duration(seconds: 1));

      // //TODO: Fix
      // await testSettignsView(tester);
      // await tester.pumpAndSettle(const Duration(seconds: 1));

      await testContainersView(tester);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //TODO: add more tests.
    });
  });
}

///Test Containers view.
Future<void> testContainersView(WidgetTester tester) async {
  //Navigate to the utilities tab.
  await tester.tap(find.byKey(
    const Key('containers_tab'),
  ));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Shelf 1'));
  await tester.pumpAndSettle();

  expect(find.byKey(const Key('name_text_field')), findsOneWidget);
  expect(find.byKey(const Key('description_text_field')), findsOneWidget);
  expect(find.byKey(const Key('parent_card')), findsOneWidget);
  expect(find.byKey(const Key('tags_card')), findsOneWidget);
  expect(find.byKey(const Key('photos_card')), findsOneWidget);
  expect(find.byKey(const Key('children_card')), findsOneWidget);
  expect(find.byKey(const Key('grid_card')), findsOneWidget);

  // await tester.dragUntilVisible(
  //   find.byKey(const Key('advanced_settings')),
  //   find.byType(SingleChildScrollView),
  //   const Offset(0, 500),
  // );
  // await tester.pumpAndSettle();

  //Navigate back.
  await tester.pageBack();
  await tester.pumpAndSettle();

  //Navigate back to the search tab.
  await tester.tap(find.byKey(
    const Key('search_tab'),
  ));
  await tester.pumpAndSettle();
}

///Test Utilities view.
Future<void> testUtilitiesView(WidgetTester tester) async {
  //Navigate to the utilities tab.
  await tester.tap(find.byKey(
    const Key('utilities_tab'),
  ));
  await tester.pumpAndSettle();

  //Check if all imported photos are displayed.
  expect(find.byKey(const Key('barcodes')), findsOneWidget);
  expect(find.byKey(const Key('barcode_generator')), findsOneWidget);
  expect(find.byKey(const Key('camera_calibration')), findsOneWidget);
  expect(find.byKey(const Key('gallery')), findsOneWidget);
  expect(find.byKey(const Key('container_types')), findsOneWidget);
  expect(find.byKey(const Key('grids')), findsOneWidget);

  //Navigate back to the search tab.
  await tester.tap(find.byKey(
    const Key('search_tab'),
  ));
  await tester.pumpAndSettle();
}

///Test Settings view.
Future<void> testSettignsView(WidgetTester tester) async {
  //Navigate to the utilities tab.
  await tester.tap(find.byKey(
    const Key('settings_tab'),
  ));
  await tester.pumpAndSettle();

  //Check if all settings are displayed.
  expect(find.byKey(const Key('app_info_view')), findsOneWidget);
  expect(find.byKey(const Key('manage_backup_view')), findsOneWidget);
  expect(find.byKey(const Key('vibration')), findsOneWidget);
  expect(find.byKey(const Key('color_mode')), findsOneWidget);
  expect(find.byKey(const Key('default_size')), findsOneWidget);
  expect(find.byKey(const Key('flash_settings')), findsOneWidget);
  expect(find.byKey(const Key('advanced_settings')), findsOneWidget);

  await tester.tap(find.text('Flash Settings'));
  await tester.pumpAndSettle();

  await tester.dragUntilVisible(
    find.byKey(const Key('advanced_settings')),
    find.byType(SingleChildScrollView),
    const Offset(0, 500),
  );
  await tester.pumpAndSettle();

  expect(find.text('OFF'), findsNWidgets(4));

  await tester.tap(find.byKey(const Key('advanced_settings')));
  await tester.pumpAndSettle();

  await tester.dragUntilVisible(
    find.byKey(const Key('text_detection')),
    find.byType(SingleChildScrollView),
    const Offset(0, 500),
  );

  expect(find.byKey(const Key('spaces')), findsOneWidget);
  expect(find.byKey(const Key('image_labeling')), findsOneWidget);
  expect(find.byKey(const Key('object_detection')), findsOneWidget);
  expect(find.byKey(const Key('text_detection')), findsOneWidget);

  //Navigate back to the search tab.
  await tester.tap(find.byKey(
    const Key('search_tab'),
  ));
  await tester.pumpAndSettle();
}

///Check if the app info view displays correct data.
Future<void> testAppInfoScreen(WidgetTester tester) async {
  //Navigate to the settigns tab.
  await tester.tap(find.byKey(
    const Key('settings_tab'),
  ));
  await tester.pumpAndSettle();

  //Navigate to the app info view.
  await tester.tap(find.byKey(
    const Key('app_info_view'),
  ));
  await tester.pumpAndSettle();

  expect(find.text('https://www.tswiri.com/'), findsOneWidget);
  expect(find.text('https://youtu.be/FwJ96Udr4NQ'), findsOneWidget);

  expect(find.text('0.01 GB'), findsOneWidget);
  expect(find.text('0.00 GB'), findsOneWidget);

  //Go back to Settings tab.
  await tester.pageBack();
  await tester.pumpAndSettle();

  //Navigate back to the search tab.
  await tester.tap(find.byKey(
    const Key('search_tab'),
  ));
  await tester.pumpAndSettle();
}

///Check if the gallery view displays photos.
Future<void> testGalleryView(WidgetTester tester) async {
  //Navigate to the utilities tab.
  await tester.tap(find.byKey(
    const Key('utilities_tab'),
  ));
  await tester.pumpAndSettle();

  //Navigate to the gallery view.
  await tester.tap(find.byKey(
    const Key('gallery'),
  ));
  await tester.pumpAndSettle();

  //Check if all imported photos are displayed.
  expect(find.byKey(const Key('photo_0')), findsOneWidget);
  expect(find.byKey(const Key('photo_1')), findsOneWidget);
  expect(find.byKey(const Key('photo_2')), findsOneWidget);
  expect(find.byKey(const Key('photo_3')), findsOneWidget);
  expect(find.byKey(const Key('photo_4')), findsOneWidget);
  expect(find.byKey(const Key('photo_5')), findsOneWidget);
  expect(find.byKey(const Key('photo_6')), findsOneWidget);
  expect(find.byKey(const Key('photo_7')), findsOneWidget);

  //Go back to utilities tab.
  await tester.pageBack();
  await tester.pumpAndSettle();

  //Navigate back to the search tab.
  await tester.tap(find.byKey(
    const Key('search_tab'),
  ));
  await tester.pumpAndSettle();
}
