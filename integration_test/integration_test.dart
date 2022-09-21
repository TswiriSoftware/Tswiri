import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tswiri/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify-widgets', (tester) async {
      app.main();

      //Check that the tab bar is visible.
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('tab_bar')), findsOneWidget);
      await tester.pumpAndSettle();

      //Navigate to the settigns tab
      tester.tap(find.byKey(
        const Key('settings_tab'),
      ));
      await tester.pumpAndSettle();

      //Navigate to manage backups.
      tester.tap(find.byKey(
        const Key('manage_backup'),
      ));
      await tester.pumpAndSettle();

      //Navigate to manual backup.
      tester.tap(find.byKey(
        const Key('manual_backup'),
      ));
      await tester.pumpAndSettle();

      tester.tap(find.byKey(
        const Key('restore_backup'),
      ));
      await tester.pumpAndSettle();

      // await Future.delayed(const Duration(milliseconds: 1000));
    });
  });
}
