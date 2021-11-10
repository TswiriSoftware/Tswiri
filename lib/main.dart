import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/services.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

//import 'NlpDetectorViews/entity_extraction_view.dart';
//import 'NlpDetectorViews/language_translator_view.dart';
//import 'NlpDetectorViews/smart_reply_view.dart';
import 'VisionDetectorViews/detector_views.dart';
import 'package:flutter/material.dart';

import 'VisionDetectorViews/object_detector_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Home extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google ML Kit Demo App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                //help
                children: [
                  Column(
                    //title: const Text("Vision"),
                    children: [
                      // CustomCard(
                      //   //Possible use
                      //   'Image Label Detector',
                      //   ImageLabelView(),
                      //   featureCompleted: true,
                      // ),
                      // CustomCard(
                      //   //No Use
                      //   'Face Detector',
                      //   FaceDetectorView(),
                      //   featureCompleted: true,
                      // ),
                      CustomCard(
                        'Barcode Scanner',
                        BarcodeScannerView(),
                        featureCompleted: true,
                      ),
                      // CustomCard(
                      //   //Utterly useless
                      //   'Pose Detector',
                      //   PoseDetectorView(),
                      //   featureCompleted: true,
                      // ),
                      // CustomCard(
                      //   'Digital Ink Recogniser',
                      //   DigitalInkView(),
                      //   featureCompleted: true,
                      // ),
                      // CustomCard(
                      //   'Text Detector',
                      //   TextDetectorView(),
                      //   featureCompleted: true,
                      // ),
                      // CustomCard(
                      //   'Object Detector',
                      //   ObjectDetectorView(),
                      // ),
                      // CustomCard(
                      //   //Useless
                      //   'Remote Model Manager',
                      //   RemoteModelView(),
                      //   featureCompleted: true,
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
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
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          _label,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
