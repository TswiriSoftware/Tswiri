// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter_google_ml_kit/global_values/global_colours.dart';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/objects/calibration/user_accelerometer_z_axis_data_objects.dart';
import 'package:flutter_google_ml_kit/objects/calibration/barcode_size_objects.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/calibration/camera_calibration_data_processing_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/calibration/calibration_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/calibration/painters/barcode_calibration_painter.dart';

import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart' as vm;

import '../../../functions/calibration_functions/check_if_camera_feed_is_black.dart';

class CameraCalibrationView extends StatefulWidget {
  const CameraCalibrationView({Key? key}) : super(key: key);

  @override
  _CameraCalibrationViewState createState() => _CameraCalibrationViewState();
}

class _CameraCalibrationViewState extends State<CameraCalibrationView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  //This is the timestamp that indicates at what time the calibration started.
  int startTimeStamp = 0;

  //This list contains all the rawUserAccelerometerData.
  List<RawUserAccelerometerZAxisData> rawAccelerometerData = [];

  //This list contains all the scanned barcode data.
  List<BarcodeData> rawBarcodesData = [];

  //Used to determine if the calibration process has started.
  bool hasStartedCalibration = false;
  //Initialized when camera feed is black.
  bool initializeCalibration = false;

  bool hasPhoneDiverted = false;

  //This is a counter used to determine if the barcode is still within range of the camera.
  int noBarcodesScanned = 0;

  bool isBusy = false;
  CustomPaint? customPaint;

  //The acceleration of the phone in the Z axis.
  double zAcceleration = 0;

  //barcode's UID
  String? barcodeUID;

  //StreamSubscriptions
  late StreamSubscription<UserAccelerometerEvent> userAccelerometerEventsSub;
  late StreamSubscription<GyroscopeEvent> gyroscopeEventsSub;

  vm.Vector3? initialPhoneOrientation;
  vm.Vector3? gyroScopeOrientation;

  @override
  void initState() {
    startStreamSubscriptions();
    super.initState();
  }

  @override
  void dispose() {
    barcodeScanner.close();
    cancelStreamSubscriptions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(builder: (context) {
        if (hasStartedCalibration == false && initializeCalibration == false) {
          return Center(child: _instructionWidget());
        } else if (hasPhoneDiverted) {
          return Center(child: _restartWidget());
        }
        return const Center();
      }),
      body: CalibrationCameraView(
        title: 'Camera Calibration',
        customPaint: customPaint,
        onImage: (inputImage) {
          processImage(inputImage);
        },
      ),
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    bool cameraFeedisBlack = false;

    final barcodes = await barcodeScanner.processImage(inputImage);
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    //Phone diversion check.
    double maxDiversion = 30;
    if (gyroScopeOrientation != null && mounted) {
      if (phoneDiversionCheck(maxDiversion)) {
        setState(() {
          hasPhoneDiverted = true;
        });
      }
    }

    if (hasStartedCalibration == false && initializeCalibration == false) {
      //Check if camera feed is black.
      cameraFeedisBlack = checkIfCameraFeedIsBlack(inputImage);

      //If it is black....
      if (cameraFeedisBlack) {
        setState(() {
          //Initilize the calibration.
          initializeCalibration = true;

          //Initialize gyroscope tracking :D Big brother is watching dont be naughty.
          gyroScopeOrientation = vm.Vector3(0, 0, 0);

          //Display a snackbar message.
          SnackBar snackBar = const SnackBar(
            content: Text('Calibration Starting'),
            duration: Duration(milliseconds: 500),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          //Start the calibration.
          hasStartedCalibration = true;
          //Set the start timestamp for use in the processing screen.
          startTimeStamp = DateTime.now().millisecondsSinceEpoch;
        });
      }
    }

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null &&
        barcodes.isNotEmpty) {
      //When the calibration has started start adding rawBarcodeData to the List.
      if (hasStartedCalibration == true) {
        rawBarcodesData
            .add(BarcodeData(timestamp: timestamp, barcode: barcodes.first));
      }
      barcodeUID = barcodes.first.displayValue;

      //Initialize the painter.
      final painter = BarcodeDetectorPainterCalibration(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);

      customPaint = CustomPaint(painter: painter);

      //Reset the barcode scanned counter.
      resetNoBarcodesScanned();
    } else {
      customPaint = null;
      if (mounted) {
        //Add to the no barcode scanned counter.
        addToNoBarcodesScanned();

        //If:
        //1. No barcodes have been scanned for 10 frames
        //2. At least 10 Frames contained a barcode.
        //3. Calibration has stared
        if (noBarcodesScanned == 10 &&
            rawBarcodesData.length >= 10 &&
            hasStartedCalibration == true) {
          navigateToProcessingScreen();
        }
      }
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  bool phoneDiversionCheck(double maxDiversion) {
    return -maxDiversion > gyroScopeOrientation!.x ||
        maxDiversion < gyroScopeOrientation!.x ||
        -maxDiversion > gyroScopeOrientation!.y ||
        maxDiversion < gyroScopeOrientation!.y ||
        -maxDiversion > gyroScopeOrientation!.z ||
        maxDiversion < gyroScopeOrientation!.z;
  }

  Card _instructionWidget() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.black87,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: sunbirdOrange, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Calibrate the Camera',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Divider(),
            Text(
              '1.Place the camera directly on the barcode, so that the feed goes black.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '2.Then slowly move thephone backwards until it no longer detects the barcode.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text('cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Card _restartWidget() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.black87,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: sunbirdOrange, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Restart Camera Calibration',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Divider(),
            Text(
              'You have changed your phones direction too much you need to restart the calibraton process D:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    rawAccelerometerData = [];
                    rawBarcodesData = [];
                    hasStartedCalibration = false;
                    initializeCalibration = false;
                    hasPhoneDiverted = false;
                    gyroScopeOrientation = null;
                  },
                  child: const Text('restart'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ///Cancel all stream subscriptions.
  ///1. userAccelerometerEventsSub
  ///2. gyroscopeEventsSub
  void cancelStreamSubscriptions() {
    userAccelerometerEventsSub.cancel();
    gyroscopeEventsSub.cancel();
  }

  ///Start all stream subscriptions.
  ///1. userAccelerometerEventsSub
  ///2. gyroscopeEventsSub
  void startStreamSubscriptions() {
    userAccelerometerEventsSub =
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      zAcceleration = event.z;
      setState(() {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        rawAccelerometerData.add(RawUserAccelerometerZAxisData(
            timestamp: timestamp, rawAcceleration: zAcceleration));
      });
    });

    gyroscopeEventsSub = gyroscopeEvents.listen((GyroscopeEvent event) {
      if (gyroScopeOrientation != null) {
        gyroScopeOrientation =
            gyroScopeOrientation! + vm.Vector3(event.x, event.y, event.z);
      }
    });
  }

  ///Add one to noBarcodesScanned counter.
  void addToNoBarcodesScanned() {
    if (mounted) {
      setState(() {
        noBarcodesScanned++;
      });
    }
  }

  ///Reset the noBarcodesScanned counter.
  void resetNoBarcodesScanned() {
    if (mounted) {
      setState(() {
        noBarcodesScanned = 0;
      });
    }
  }

  ///Proceed to data processing screen.
  Future<void> navigateToProcessingScreen() async {
    //Cancel all subscriptions.
    cancelStreamSubscriptions();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraCalibrationDataProcessingView(
          rawBarcodeData: rawBarcodesData,
          rawUserAccelerometerData: rawAccelerometerData,
          startTimeStamp: startTimeStamp,
          barcodeUID: barcodeUID!,
        ),
      ),
    );

    Navigator.pop(context);
  }

  ///Shows the Instruction Dialog only once.
  void showInitialInstructionDialog(
      {required void Function(BuildContext dialogContext) onCancel}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (initialDialogContext) {
        return AlertDialog(
          title: const Text('Camera Calibration'),
          content: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: const [
              Text(
                  '1. Place the camera directly on the barcode, so that the feed goes black \n\n2. Then slowly move the phone backwards in a straight line until it no longer detects the barcode.'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                onCancel(initialDialogContext);
              },
              child: const Text('cancel'),
            ),
          ],
        );
      },
    );
  }
}
