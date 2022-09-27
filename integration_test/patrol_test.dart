import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tswiri/main.dart' as app;

import 'patrol_config.dart';

void main() {
  patrolTest(
    config: patrolConfig,
    nativeAutomation: true,
    'description',
    ($) async {
      await app.main();
      // await $.pumpWidgetAndSettle(const MyApp());
      await $.pumpAndSettle(const Duration(seconds: 1));
      bool foundBetaPopup = $.tester.any(find.byKey(const Key('noted')));

      if (foundBetaPopup) {
        await $.tap(find.byKey(const Key('noted')));
        await $.pumpAndSettle();
      }

      //Navigate to the settigns tab.
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

      //Tap 'Restore Backup' button.
      await $.tap(find.byKey(const Key('restore_backup')));

      //Tap main_space_test_V1.zip in file explorer.
      await $.native.tap(const Selector(textContains: 'main_space_te'));
      await $.pumpAndSettle();

      //Tap 'Restore' button.
      await $.tap(find.text('Restore'));

      //Wait for the backup to restore.
      await Future.delayed(const Duration(seconds: 5));

      //Navigate back to 'Backup Options'
      await $.tap(find.byIcon(Icons.arrow_back));

      //Navigate back to 'Settings'
      await $.tap(find.byIcon(Icons.arrow_back));

      // //Navigate to the search tab.
      await $.tap(find.byKey(
        const Key('search_tab'),
      ));
      await $.pumpAndSettle();

      expect(find.text('Shelf 1'), findsOneWidget);
      expect(find.text('Box 1'), findsOneWidget);

      await $.pumpAndSettle(const Duration(seconds: 5));
    },
  );
}
