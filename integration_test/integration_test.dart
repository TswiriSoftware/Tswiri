import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tswiri/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify-import-function', (tester) async {
      app.main();

      //Test the manualImport functionality.
      await testImportFunction(tester);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Test the utilities view.
      await testUtilitiesView(tester);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Test the app info screen.
      await testAppInfoScreen(tester);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      //Test the gallery view.
      await testGalleryView(tester);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await testSettignsView(tester);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      //TODO: add more tests.
    });
  });
}

///Import databse and check if it populates the search screen.
Future<void> testImportFunction(WidgetTester tester) async {
  await tester.pumpAndSettle(const Duration(seconds: 1));
  bool foundBetaPopup = tester.any(find.byKey(const Key('noted')));

  if (foundBetaPopup) {
    await tester.tap(find.byKey(const Key('noted')));
    await tester.pumpAndSettle();
  }

  //Check that the tab bar is visible.
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('tab_bar')), findsOneWidget);
  await tester.pumpAndSettle();

  //Navigate to the settigns tab
  await tester.tap(find.byKey(
    const Key('settings_tab'),
  ));
  await tester.pumpAndSettle();

  //Navigate to manage backups.
  await tester.tap(find.byKey(
    const Key('manage_backup_view'),
  ));
  await tester.pumpAndSettle();

  //Navigate to manual backup.
  await tester.tap(find.byKey(
    const Key('manual_backup'),
  ));
  await tester.pumpAndSettle();

  //Tap hidden button to import asset.
  await tester.tap(find.byKey(
    const Key('import_from_asset'),
  ));
  await tester.pumpAndSettle(const Duration(seconds: 2));

  //Go back to Backup Options.
  await tester.pageBack();
  await tester.pumpAndSettle();

  //Go back to Settings.
  await tester.pageBack();
  await tester.pumpAndSettle();

  //Navigate back to the search tab.
  await tester.tap(find.byKey(
    const Key('search_tab'),
  ));
  await tester.pumpAndSettle();

  await tester.pump(const Duration(seconds: 1));

  expect(find.text('Shelf 1'), findsOneWidget);
  expect(find.text('Box 1'), findsOneWidget);
}

///Test Containers view.
Future<void> testContainersView(WidgetTester tester) async {
  //Navigate to the utilities tab.
  await tester.tap(find.byKey(
    const Key('settings_tab'),
  ));
  await tester.pumpAndSettle();

  // //Check if all imported photos are displayed.
  // expect(find.byKey(const Key('barcodes')), findsOneWidget);
  // expect(find.byKey(const Key('barcode_generator')), findsOneWidget);
  // expect(find.byKey(const Key('camera_calibration')), findsOneWidget);
  // expect(find.byKey(const Key('gallery')), findsOneWidget);
  // expect(find.byKey(const Key('container_types')), findsOneWidget);
  // expect(find.byKey(const Key('grids')), findsOneWidget);

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

  await tester.tap(find.byKey(const Key('flash_settings_tile')));
  await tester.pumpAndSettle();

  await tester.scrollUntilVisible(
    find.byKey(const Key('photo_flash')),
    500.0,
    scrollable: find.byKey(const Key('advanced_settings')),
  );
  await tester.pumpAndSettle();

  expect(find.text('OFF'), findsNWidgets(4));

  await tester.tap(find.byKey(const Key('flash_settings_tile')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('advanced_settings')));
  await tester.pumpAndSettle();

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
