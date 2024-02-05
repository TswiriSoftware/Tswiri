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
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              switch (settings.name) {
                case Routes.home:
                  return const HomeScreen();

                case Routes.container:
                  return ContainerScreen(
                    parent: settings.arguments as CatalogedContainer,
                  );

                case Routes.createContainer:
                  return CreateContainerScreen(
                    parentContainer: settings.arguments as CatalogedContainer?,
                  );

                case Routes.qrCodeBatches:
                  return const QrCodeBatchesScreen();

                case Routes.qrCodeGenerator:
                  return const QrCodeGeneratorScreen();

                case Routes.qrCodePDF:
                  var (size, barcodeUUIDs) =
                      settings.arguments as (double, List<String>);
                  return QrCodePDFView(
                    barcodeUUIDs: barcodeUUIDs,
                    size: size,
                  );

                case Routes.qrCodeBatch:
                  return QrCodeBatchScreen(
                    barcodeBatch: settings.arguments as BarcodeBatch,
                  );

                default:
                  return const HomeScreen();
              }
            },
          );
        },
      ),
    ),
  );
}
