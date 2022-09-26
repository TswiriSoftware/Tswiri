import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tswiri/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  patrolTest(
    nativeAutomation: true,
    'description',
    ($) async {
      app.main();

      await $.pumpWidgetAndSettle(const app.MyApp());
      await $.pumpAndSettle(const Duration(seconds: 1));
      bool foundBetaPopup = $.tester.any(find.byKey(const Key('noted')));

      if (foundBetaPopup) {
        await $.tap(find.byKey(const Key('noted')));
        await $.pumpAndSettle();
      }

      //Check that the tab bar is visible.
      await $.pumpAndSettle();
      expect(find.byKey(const Key('tab_bar')), findsOneWidget);
      await $.pumpAndSettle();

      //Navigate to the settigns tab
      await $.tap(find.byKey(
        const Key('settings_tab'),
      ));
      await $.pumpAndSettle();

      //Navigate to manage backups.
      await $.tap(find.byKey(
        const Key('manage_backup_view'),
      ));
      await $.pumpAndSettle();

      //Navigate to manual backup.
      await $.tap(find.byKey(
        const Key('manual_backup'),
      ));
      await $.pumpAndSettle();

      // await $.tap(find.byKey(const Key('restore_backup')));
      // await $.native.tap(const Selector(textContains: 'main_space_te'));

      await $.pumpAndSettle(const Duration(seconds: 5));
    },
  );
}
