// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/calibration/camera_calibration.dart';
import 'package:flutter_google_ml_kit/database/consolidated_data_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'HiveDatabaseViews/hive_database_consolidation.dart';
import 'HiveDatabaseViews/hive_database_visualization.dart';
import 'HiveDatabaseViews/hive_raw_database_view.dart';
import 'VisionDetectorViews/detector_views.dart';
import 'package:flutter/material.dart';
import 'VisionDetectorViews/object_detector_view.dart';
import 'database/raw_data_adapter.dart';

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
  Hive.registerAdapter(RelativeQrCodesAdapter());
  Hive.registerAdapter(ConsolidatedDataAdapter());
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
      home: Home(),
    );
  }
}
//TODO: Implement navigator 2.0 => This is acceptable for now @Spodeopieter

class Home extends StatelessWidget {
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
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            CustomCard(
              'Barcode Scanner',
              BarcodeScannerView(),
              featureCompleted: true,
            ),
            CustomCard('Raw Data Viewer', HiveDatabaseView(),
                featureCompleted: true),
            CustomCard(
                'Consolidated Data Viewer', HiveDatabaseConsolidationView(),
                featureCompleted: true),
            CustomCard(' Consolidated Data Viewer', databaseVisualization(),
                featureCompleted: true),
            CustomCard(
              'Camera Calibration',
              CameraCalibration(),
              featureCompleted: true,
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

  // ignore: use_key_in_widget_constructors
  const CustomCard(this._label, this._viewPage,
      {this.featureCompleted = false});

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
        tileColor: Theme.of(context).primaryColor,
        title: Center(
          child: Text(
            _label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
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
// CustomCard(
//   //Possible use
//   ' Image Label Detector',
//   ImageLabelView(),
//   featureCompleted: true,
// ),
// CustomCard(
//   ' Text Detector',
//   TextDetectorView(),
//   featureCompleted: true,
// ),
// CustomCard(
//   ' Object Detector',
//   ObjectDetectorView(),
// ),
// CustomCard(
//   ' Remote Model Manager',
//   RemoteModelView(),
//   featureCompleted: true,
// ),
