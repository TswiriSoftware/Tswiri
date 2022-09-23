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

      //Test the app info screen.
      await testAppInfoScreen(tester);

      await tester.pumpAndSettle(const Duration(seconds: 1));

      //TODO: add more tests.
    });
  });
}

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
