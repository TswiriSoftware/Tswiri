// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:tswiri_database/functions/general/check_camera_feed.dart';
import 'package:tswiri_database/models/camera/camera_calibration.dart';
import 'package:tswiri_widgets/colors/colors.dart';

import 'package:vector_math/vector_math_64.dart' as vm;

import 'calibration_camera_view.dart';

import 'camera_calibration_painter.dart';

class CameraCalibrationView extends StatefulWidget {
  const CameraCalibrationView({Key? key}) : super(key: key);

  @override
  State<CameraCalibrationView> createState() => _CameraCalibrationViewState();
}

class _CameraCalibrationViewState extends State<CameraCalibrationView> {
  //Initialize barcode scanner
  final _barcodeScanner = BarcodeScanner(
    formats: [
      BarcodeFormat.qrCode,
    ],
  );

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  //Collected AccelerometerData.
  Map<int, double> accelerometerData = {};

  //Collected BarcodeData.
  Map<int, Barcode> barcodeData = {};

  //Calibration Start Time.
  int startTimeStamp = 0;

  //Initialized when camera feed is black.
  bool initializeCalibration = false;

  //Used to determine if the calibration process has started.
  bool hasStartedCalibration = false;

  //Used to determine if the phone has diverted.
  bool hasPhoneDiverted = false;

  //Counter to check if barcodes are still being scanned.
  int noBarcodesScanned = 0;

  //The acceleration of the phone in the Z axis.
  double zAcceleration = 0;

  //StreamSubscriptions
  late StreamSubscription<UserAccelerometerEvent>
      _userAccelerometerEventsSubscription;
  late StreamSubscription<GyroscopeEvent> _gyroscopeEventsSubscription;

  vm.Vector3? initialPhoneOrientation;
  vm.Vector3? gyroScopeOrientation;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    _startStreamSubscriptions();
    super.initState();
  }

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    _userAccelerometerEventsSubscription.cancel();
    _gyroscopeEventsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
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
          title: 'Barcode Scanner',
          customPaint: _customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          }),
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    bool cameraFeedisBlack = false;

    final barcodes = await _barcodeScanner.processImage(inputImage);

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
        inputImage.inputImageData?.imageRotation != null) {
      //When the calibration has started start adding rawBarcodeData to the List.
      if (hasStartedCalibration == true && barcodes.isNotEmpty) {
        barcodeData.putIfAbsent(
            DateTime.now().millisecondsSinceEpoch, () => barcodes.first);
        resetNoBarcodesScanned();
      }

      final painter = CameraCalibrationPainter(
        barcodes: barcodes,
        absoluteImageSize: inputImage.inputImageData!.size,
        rotation: inputImage.inputImageData!.imageRotation,
      );

      _customPaint = CustomPaint(painter: painter);

      if (mounted) {
        //Add to the no barcode scanned counter.
        addToNoBarcodesScanned();
        //If:
        //1. No barcodes have been scanned for 10 frames
        //2. At least 10 Frames contained a barcode.
        //3. Calibration has stared
        if (noBarcodesScanned == 10 &&
            barcodeData.length >= 10 &&
            hasStartedCalibration == true &&
            hasPhoneDiverted == false) {
          navigateToProcessingScreen();
        }
      }
    } else {
      _customPaint = null;
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  ///Start all stream subscriptions.
  ///1. userAccelerometerEventsSub
  ///2. gyroscopeEventsSub
  void _startStreamSubscriptions() {
    _userAccelerometerEventsSubscription =
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        if (hasStartedCalibration == true) {
          accelerometerData.putIfAbsent(
              DateTime.now().millisecondsSinceEpoch, () => event.z);
        }
      });
    });

    _gyroscopeEventsSubscription =
        gyroscopeEvents.listen((GyroscopeEvent event) {
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

  ///Checks if the phone has diverted more than X degrees
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
        side: const BorderSide(color: tswiriOrange, width: 1.5),
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
                  onPressed: () {
                    setState(() {
                      accelerometerData.clear();
                      barcodeData.clear();
                      hasStartedCalibration = false;
                      initializeCalibration = false;
                      hasPhoneDiverted = false;
                      gyroScopeOrientation = null;
                    });
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

  ///Proceed to data processing screen.
  Future<void> navigateToProcessingScreen() async {
    //Cancel all subscriptions.
    _barcodeScanner.close();
    _userAccelerometerEventsSubscription.cancel();
    _gyroscopeEventsSubscription.cancel();

    Navigator.pop(
      context,
      CameraCalibration(
        accelerometerData: accelerometerData,
        barcodeData: barcodeData,
      ),
    );
  }
}
