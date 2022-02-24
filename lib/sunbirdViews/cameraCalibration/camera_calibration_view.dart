import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/camera_view.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/calibration/user_accelerometer_z_axis_data_objects.dart';
import 'package:flutter_google_ml_kit/objects/calibration/barcode_size_objects.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/barcode_calibration_data_processing.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/cameraView/camera_view_camera_calibration.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/painter/barcode_calibration_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CameraCalibrationView extends StatefulWidget {
  const CameraCalibrationView({Key? key}) : super(key: key);

  @override
  _CameraCalibrationViewState createState() => _CameraCalibrationViewState();
}

class _CameraCalibrationViewState extends State<CameraCalibrationView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  int startTimeStamp = 0;

  //This list contains all the rawUserAccelerometerData.
  List<RawUserAccelerometerZAxisData> rawAccelerometerData = [];
  //This list contains all the scanned barcode data.
  List<BarcodeData> rawBarcodesData = [];
  bool hasStarted = false;
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
      rawAccelerometerData.add(RawUserAccelerometerZAxisData(
          timestamp: timestamp, rawAcceleration: zAcceleration));
    });

    super.initState();

    Future(_showDialog);
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Builder(builder: (context) {
                if (hasStarted == false) {
                  return FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      hasStarted = !hasStarted;
                      startTimeStamp =
                          DateTime.now().millisecondsSinceEpoch + 5;
                    },
                    child: const Icon(Icons.check),
                  );
                } else {
                  return FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      subscription.cancel();
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              BarcodeCalibrationDataProcessingView(
                                  rawBarcodeData: rawBarcodesData,
                                  rawUserAccelerometerData:
                                      rawAccelerometerData,
                                  startTimeStamp: startTimeStamp)));
                    },
                    child: const Icon(Icons.done_all_outlined),
                  );
                }
              }),
            ],
          ),
        ),
        body: CameraViewCameraCalibration(
          title: 'Camera Calibration',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
          color: skyBlue,
        ));
  }

  _showDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Camera Calibration'),
            content: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: const [
                Text('When ready to start click. '),
                Icon(Icons.check),
                Text('When you are done click. '),
                Icon(Icons.done_all)
              ],
            ),
            actions: [
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
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
