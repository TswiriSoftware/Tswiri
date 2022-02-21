import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/all_barcodes.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeGeneration/barcode_generation_range_selector_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
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

  runApp(const MyApp());

  var status = await Permission.storage.status;
  if (status.isDenied) {
    Permission.storage.request();
  }
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter(TypeOffsetHiveObjectAdapter());
  Hive.registerAdapter(RealBarcodePostionEntryAdapter());
  Hive.registerAdapter(DistanceFromCameraLookupEntryAdapter());
  Hive.registerAdapter(BarcodeTagEntryAdapter());
  Hive.registerAdapter(TagEntryAdapter());
  Hive.registerAdapter(BarcodeDataEntryAdapter());
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
              BarcodeScanningView(),
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
              BarcodeNavigationView(),
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
              Icons.emoji_objects_rounded,
              featureCompleted: true,
              tileColor: deepSpaceSparkle,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String _label;
  final Widget _viewPage;
  final bool featureCompleted;
  final IconData _icon;
  final Color tileColor;
  // ignore: use_key_in_widget_constructors
  const CustomCard(this._label, this._viewPage, this._icon,
      {this.featureCompleted = false, required this.tileColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        tileColor: tileColor,
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _label,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  _icon,
                  color: Colors.white,
                  size: 45,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          if (Platform.isIOS && !featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('This feature has not been implemented for iOS yet')));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
          }
        },
      ),
    );
  }
}
