import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/firebase_options.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/global_values/routes.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_generator/barcode_generator_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/calibration/calibration_tools_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/containers/container_manager/container_manager_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/containers/container_search/search_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/containers/container_types/types_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tree_visualizer/tree_visualizer_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/custom_card/custom_card.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'sunbird_views/app_settings/app_settings_functions.dart';
import 'sunbird_views/app_settings/app_settings_view.dart';
import 'sunbird_views/barcodes/barcode_manager/barcode_manager_view.dart';
import 'sunbird_views/gallery/gallery_view.dart';
import 'sunbird_views/tag_manager/tag_manager_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Set screen orientation.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //Initialize Firebase.
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    Firebase.app();
  }

  //debugRepaintRainbowEnabled = true;

  runApp(
    MaterialApp(
      title: 'Sunbird',
      initialRoute: '/',
      routes: allRoutes,
      debugShowCheckedModeBanner: false,
    ),
  );

  //Get camera's
  cameras = await availableCameras();

  //Request Permissions.
  var status = await Permission.storage.status;

  //TODO: Disable for integration Test.
  // if (status.isDenied) {
  //   Permission.storage.request();
  // }

  //Get App Settings. From Shared Prefernces.
  getStoredAppSettings();

  //Get support directory
  isarDirectory = await getApplicationSupportDirectory();
  //Open Isar.
  isarDatabase = openIsar();

  createBasicContainerTypes();
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        primaryColor: sunbirdOrange,
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepOrange,
            brightness: Brightness.dark,
            backgroundColor: Colors.black),
        appBarTheme: const AppBarTheme(
          backgroundColor: sunbirdOrange,
        ),
        scaffoldBackgroundColor: backgroundColor,
        buttonTheme: const ButtonThemeData(
          buttonColor: sunbirdOrange,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: sunbirdOrange,
              textStyle: Theme.of(context).textTheme.bodyLarge),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(Colors.white),
          fillColor: MaterialStateProperty.all(sunbirdOrange),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: sunbirdOrange,
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: sunbirdOrange),
        textTheme: const TextTheme(
          labelLarge: TextStyle(fontSize: 20),
          labelMedium: TextStyle(fontSize: 17),
          labelSmall: TextStyle(fontSize: 15),
          titleLarge: TextStyle(fontSize: 25),
          titleMedium: TextStyle(fontSize: 18),
          titleSmall: TextStyle(fontSize: 16),
          bodyLarge: TextStyle(fontSize: 16),
          headlineSmall: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w300),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
//TODO:@Spodeopieter implement navigator 2.0

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsView(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
        title: Text(
          'Sunbird',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: GridView.count(
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          children: const [
            CustomCard(
              'Search',
              SearchView(),
              Icons.search,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Containers',
              ContainerManagerView(),
              Icons.add_box_outlined,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Tags',
              TagManagerView(),
              Icons.tag,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Gallery',
              GalleryView(),
              Icons.photo,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Calibration',
              CalibrationToolsView(),
              Icons.camera,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Container Types',
              ContainerTypeView(),
              Icons.code,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Barcode Generator',
              BarcodeGeneratorView(),
              Icons.qr_code_2_rounded,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Barcodes',
              BarcodeManagerView(),
              Icons.list,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Tree Visualizer',
              GridVisualizerView(),
              Icons.grid_4x4_sharp,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
          ],
        ),
      ),
    );
  }
}
