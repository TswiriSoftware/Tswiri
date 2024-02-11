import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tswiri/routes.dart';
import 'package:tswiri/settings/settings.dart';
import 'package:tswiri/theme.dart';
import 'package:tswiri/views/container/create_container_screen.dart';
import 'package:tswiri/views/qr_codes/qr_code_batch_screen.dart';
import 'package:tswiri/views/qr_codes/qr_code_generator_screen.dart';
import 'package:tswiri/views/container/container_screen.dart';
import 'package:tswiri/views/home_screen.dart';
import 'package:tswiri/views/qr_codes/qr_code_batches_screen.dart';
import 'package:tswiri/views/qr_codes/qr_code_pdf_view.dart';
import 'package:tswiri/views/qr_codes/qr_codes_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';
import 'package:tswiri_database/space.dart';
import 'providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final settings = Settings(prefs: prefs);
  await settings.loadSettings();

  settingsProvider = ChangeNotifierProvider<Settings>(
    (ref) => settings,
  );

  final space = Space();
  await space.loadSpace(spacePath: settings.spacePath);

  spaceProvider = ChangeNotifierProvider<Space>(
    (ref) => space,
  );

  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Tswiri App',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => const HomeScreen(),

          /// Containers ///
          Routes.container: (context) {
            final container = ModalRoute.of(context)!.settings.arguments
                as CatalogedContainer;

            return ContainerScreen(
              container: container,
            );
          },
          Routes.createContainer: (context) {
            final parentContainer = ModalRoute.of(context)!.settings.arguments
                as CatalogedContainer?;

            return CreateContainerScreen(
              parentContainer: parentContainer,
            );
          },

          /// QR Codes ///
          Routes.qrCodesScreen: (context) {
            final barcodeBatch =
                ModalRoute.of(context)!.settings.arguments as BarcodeBatch;

            return QrCodesScreen(
              barcodeBatch: barcodeBatch,
            );
          },
          Routes.qrCodeBatches: (context) => const QrCodeBatchesScreen(),
          Routes.qrCodeGenerator: (context) => const QrCodeGeneratorScreen(),
          Routes.qrCodePDF: (context) {
            var (size, barcodeUUIDs) = ModalRoute.of(context)!
                .settings
                .arguments as (double, List<String>);
            return QrCodePDFView(
              barcodeUUIDs: barcodeUUIDs,
              size: size,
            );
          },
          Routes.qrCodeBatch: (context) {
            final barcodeBatch =
                ModalRoute.of(context)!.settings.arguments as BarcodeBatch;

            return QrCodeBatchScreen(
              barcodeBatch: barcodeBatch,
            );
          },
        },
      ),
    ),
  );
}
