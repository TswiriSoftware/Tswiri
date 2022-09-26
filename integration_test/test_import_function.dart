import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

///1. Navigate to manual backup screen.
///
///2. Import databse.
///
///4. Navigate back to search screen.
///
///5. Check if search screen is populated.
Future<void> testImportFunction(WidgetTester tester) async {
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
