import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/barcodePhotos/barcode_photo_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/routes.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/all_barcodes.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeGeneration/barcode_generation_range_selector_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/gettingStarted/getting_started_view.dart';
import 'package:flutter_google_ml_kit/widgets/custom_card_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'sunbirdViews/appSettings/app_settings_functions.dart';
import 'sunbirdViews/appSettings/app_settings_view.dart';
import 'databaseAdapters/calibrationAdapters/distance_from_camera_lookup_entry.dart';
import 'databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import 'databaseAdapters/typeAdapters/type_offset_adapter.dart';
import 'sunbirdViews/barcodeNavigation/navigationToolsView/barcode_navigation_tools_view.dart';
import 'sunbirdViews/barcodeScanning/scanningToolsView/barcode_scanning_tools_view.dart';
import 'sunbirdViews/cameraCalibration/calibrationToolsView/camera_calibration_tools_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  //await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MaterialApp(
    title: 'Sunbird',
    initialRoute: '/',
    routes: allRoutes,
    debugShowCheckedModeBanner: false,
  ));

  //Request Permissions.
  var status = await Permission.storage.status;
  if (status.isDenied) {
    Permission.storage.request();
  }
  //Get App Settings.
  getCurrentAppSettings();

  //Initiate Hive.
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter(TypeOffsetHiveObjectAdapter());
  Hive.registerAdapter(RealBarcodePostionEntryAdapter());
  Hive.registerAdapter(DistanceFromCameraLookupEntryAdapter());
  Hive.registerAdapter(BarcodeTagEntryAdapter());
  Hive.registerAdapter(TagEntryAdapter());
  Hive.registerAdapter(BarcodeDataEntryAdapter());
  Hive.registerAdapter(BarcodePhotoEntryAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.deepOrange[500],
          appBarTheme: AppBarTheme(
            //foregroundColor: Colors.deepOrange[900],
            backgroundColor: Colors.deepOrange[500],
          ),
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.deepOrangeAccent,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              foregroundColor: Colors.black,
              backgroundColor: Colors.deepOrange)),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
//TODO:@Spodeopieter implement navigator 2.0

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                        builder: (context) => const SettingsView()));
              },
              icon: const Icon(Icons.settings))
        ],
        title: const Text(
          'Sunbird',
          style: TextStyle(fontSize: 25),
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
              'Barcode Scanning Tools',
              BarcodeScanningToolsView(),
              Icons.qr_code_scanner_rounded,
              featureCompleted: true,
              tileColor: brightOrange,
            ),
            CustomCard(
              'Camera Calibration Tools',
              CameraCalibrationToolsView(),
              Icons.camera_alt,
              featureCompleted: true,
              tileColor: skyBlue80,
            ),
            CustomCard(
              'Barcode Navigation Tools',
              BarcodeNavigationToolsView(),
              Icons.qr_code_rounded,
              featureCompleted: true,
              tileColor: limeGreenMuted,
            ),
            CustomCard(
              'Barcode Generator',
              BarcodeGenerationRangeSelectorView(),
              Icons.qr_code_2_rounded,
              featureCompleted: true,
              tileColor: deeperOrange,
            ),
            CustomCard(
              'Barcodes List',
              AllBarcodesView(),
              Icons.list_alt,
              featureCompleted: true,
              tileColor: deepSpaceSparkle,
            ),
            CustomCard(
              'Getting Started',
              GettingStartedView(),
              Icons.emoji_objects_rounded,
              featureCompleted: true,
              tileColor: skyBlue80,
            ),
          ],
        ),
      ),
    );
  }
}
