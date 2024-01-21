import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tswiri/routes.dart';
import 'package:tswiri/settings/settings.dart';
import 'package:tswiri/theme.dart';
import 'package:tswiri/views/qr_codes/qr_code_generator_screen.dart';
import 'package:tswiri/views/container/cataloged_container_screen.dart';
import 'package:tswiri/views/home_screen.dart';
import 'package:tswiri/views/qr_codes/qr_code_batches_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';
import 'package:tswiri_database/space.dart';
import 'providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) async {
    final settings = Settings(prefs: prefs);
    await settings.loadSettings();

    final space = Space();
    await space.loadSpace(databasePath: settings.databasePath);

    settingsProvider = ChangeNotifierProvider<Settings>(
      (ref) => settings,
    );

    spaceProvider = ChangeNotifierProvider<Space>(
      (ref) => space,
    );
  });

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

                case Routes.catalogedContainer:
                  return CatalogedContainerScreen(
                    container: settings.arguments as CatalogedContainer,
                  );

                case Routes.createCatalogedContainer:
                  return CatalogedContainerScreen(
                    container: settings.arguments as CatalogedContainer,
                  );

                case Routes.qrCodes:
                  return const QrCodeBatchesScreen();

                case Routes.qrCodeGenerator:
                  return const QrCodeGeneratorScreen();

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
