import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/calibration_accelerometer_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/dataInjectors/barcode_calibration_data_injector.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/camera_view.dart';
import 'package:flutter_google_ml_kit/functions/mathfunctions/round_to_double.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/accelerometer_data_objects.dart';
import 'package:flutter_google_ml_kit/objects/barcode_size_objects.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/barcode_calibration_data_processing.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/painter/barcode_calibration_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CameraCalibration extends StatefulWidget {
  const CameraCalibration({Key? key}) : super(key: key);

  @override
  _CameraCalibrationState createState() => _CameraCalibrationState();
}

class _CameraCalibrationState extends State<CameraCalibration> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  List<RawAccelerometerData> rawAccelerometerData = [];
  List<BarcodeData> rawBarcodesData = [];

  bool isBusy = false;
  CustomPaint? customPaint;
  double zAcceleration = 0;

  late StreamSubscription<UserAccelerometerEvent> subscription;

  @override
  void initState() {
    subscription =
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      zAcceleration = event.z;

      int timestamp = DateTime.now().millisecondsSinceEpoch;
      rawAccelerometerData.add(RawAccelerometerData(
          timestamp: timestamp, rawAcceleration: zAcceleration));
    });

    super.initState();
  }

  @override
  void dispose() {
    barcodeScanner.close();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  subscription.cancel();
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          BarcodeCalibrationDataProcessingView(
                              rawBarcodeData: rawBarcodesData,
                              rawAccelerometerData: rawAccelerometerData)));
                },
                child: const Icon(Icons.check_circle_outline_rounded),
              ),
            ],
          ),
        ),
        body: CameraView(
          title: 'Camera Calibration',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
        ));
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final barcodes = await barcodeScanner.processImage(inputImage);

    int timestamp = DateTime.now().millisecondsSinceEpoch;

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null &&
        barcodes.isNotEmpty) {
      //Add scanned barcodeData
      rawBarcodesData
          .add(BarcodeData(timestamp: timestamp, barcode: barcodes.first));

      final painter = BarcodeDetectorPainterCalibration(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);

      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
