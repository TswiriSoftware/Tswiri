import 'dart:async';
import 'dart:developer' as d;
import 'dart:math';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/calibrationToolsView/camera_calibration_tools_view.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/calibration/user_accelerometer_z_axis_data_objects.dart';
import 'package:flutter_google_ml_kit/objects/calibration/barcode_size_objects.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/barcode_calibration_data_processing.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/cameraView/camera_view_camera_calibration.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/cameraCalibration/painter/barcode_calibration_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart';

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

  //Used to determine if the calibration process has been initialized.
  bool initializeCalibration = false;

  //Used to determine if the instuction dialog is displayed.
  bool isShowingDialog = false;

  //This is a counter used to determine if the barcode is still within range of the camera.
  int noBarcodesScanned = 0;

  bool isBusy = false;
  CustomPaint? customPaint;

  //The acceleration of the phone in the Z axis.
  double zAcceleration = 0;
  int? barcodeID;
  late StreamSubscription<UserAccelerometerEvent> userAccelerometerEventsSub;
  late StreamSubscription<AccelerometerEvent> accelerometerEventsSub;
  late StreamSubscription<GyroscopeEvent> gyroscopeEventsSub;
  Vector3 accelerometerEvent = Vector3(0, 0, 0);

  Vector3? initialPhoneOrientation;
  Vector3? gyroScopeOrientation;

  bool hasPhoneDiverted = false;

  @override
  void initState() {
    userAccelerometerEventsSub =
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      zAcceleration = event.z;
      setState(() {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        rawAccelerometerData.add(RawUserAccelerometerZAxisData(
            timestamp: timestamp, rawAcceleration: zAcceleration));
      });
    });
    accelerometerEventsSub =
        accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = Vector3(event.x, event.y, event.z);
    });

    gyroscopeEventsSub = gyroscopeEvents.listen((GyroscopeEvent event) {
      if (gyroScopeOrientation != null) {
        gyroScopeOrientation =
            gyroScopeOrientation! + Vector3(event.x, event.y, event.z);
      }
    });

    super.initState();

    //Future(_showCalibrationInstuctions);
  }

  @override
  void dispose() {
    barcodeScanner.close();
    accelerometerEventsSub.cancel();
    userAccelerometerEventsSub.cancel();
    gyroscopeEventsSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CameraViewCameraCalibration(
      title: 'Camera Calibration',
      customPaint: customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      color: skyBlue,
    ));
  }

  //Instruction dialog context
  BuildContext? instructionDialogContext;

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    bool cameraFeedisBlack = false;

    final barcodes = await barcodeScanner.processImage(inputImage);
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    if (hasStartedCalibration == false && initializeCalibration == false) {
      //This initializes the Instruction Dialog.
      showInitialInstructionDialog();

      //Check if camera feed is black.
      cameraFeedisBlack = checkIfCameraFeedIsBlack(inputImage);

      //If it is black....
      if (cameraFeedisBlack) {
        setState(() {
          //Initilize the calibration.
          initializeCalibration = true;

          //Set initialPhoneOrientation
          initialPhoneOrientation = accelerometerEvent;

          //Initialize gyroscope tracking :D Big brother is watching dont be naughty.
          gyroScopeOrientation = Vector3(0, 0, 0);

          //Close instruction dialog.
          closeInstructionDialog();

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

    //Detects phone diversions and restarts the calibration.
    checkIfPhoneHasDiverted();

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null &&
        barcodes.isNotEmpty) {
      //When the calibration has started start adding rawBarcodeData to the List.
      if (hasStartedCalibration == true) {
        rawBarcodesData
            .add(BarcodeData(timestamp: timestamp, barcode: barcodes.first));
      }

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
        noBarcodesScannedThisFrame();

        //If:
        //1. No barcodes have been scanned for 10 frames
        //2. At least 10 Frames contained a barcode.
        //3. Calibration has stared
        if (noBarcodesScanned == 10 &&
            rawBarcodesData.length >= 10 &&
            hasStartedCalibration == true) {
          continueToProcessingScreen();
        }
      }
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  void checkIfPhoneHasDiverted() {
    //Detects Z axis diversions.
    double maxDiversion = 15;
    if (gyroScopeOrientation != null) {
      if (-maxDiversion > gyroScopeOrientation!.x ||
          maxDiversion < gyroScopeOrientation!.x ||
          -maxDiversion > gyroScopeOrientation!.y ||
          maxDiversion < gyroScopeOrientation!.y ||
          -maxDiversion > gyroScopeOrientation!.z ||
          maxDiversion < gyroScopeOrientation!.z) {
        if (hasPhoneDiverted == false) {
          showDialog(
            barrierDismissible: false,
            useRootNavigator: false,
            context: context,
            builder: (dialogContext) {
              return WillPopScope(
                onWillPop: () => Future.value(false),
                child: AlertDialog(
                  title: const Text('Camera Calibration'),
                  content: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: const [
                      Text(
                          'You have changed your phones direction too much you need to restart the calibraton process D:'),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        child: const Text('Restart Calibration'),
                        onPressed: () {
                          accelerometerEventsSub.cancel();
                          userAccelerometerEventsSub.cancel();
                          gyroscopeEventsSub.cancel();
                          barcodeScanner.close();
                          Navigator.pop(context);
                          Navigator.pop(dialogContext);
                        },
                        style:
                            ElevatedButton.styleFrom(primary: deepSpaceSparkle))
                  ],
                ),
              );
            },
          );
        }

        //Sets the bool
        hasPhoneDiverted = true;
      }
    }
  }

  ///Shows the Instruction Dialog only once.
  void showInitialInstructionDialog() {
    if (isShowingDialog == false && initializeCalibration == false) {
      isShowingDialog = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          instructionDialogContext = dialogContext;

          return AlertDialog(
            title: const Text('Camera Calibration'),
            content: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: const [
                Text(
                    '1. Place the camera directly on the barcode, so that the feed goes black \n\n2. Then slowly move the phone backwards until it no longer detects the barcode.'),
              ],
            ),
          );
        },
      );
    }
  }

  ///Close the instruction dialog.
  void closeInstructionDialog() {
    if (instructionDialogContext != null) {
      isShowingDialog = false;
      Navigator.pop(instructionDialogContext!);
    }
  }

  ///Add one to noBarcodesScanned counter.
  void noBarcodesScannedThisFrame() {
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
  void continueToProcessingScreen() {
    //Cancel all subscriptions.
    accelerometerEventsSub.cancel();
    userAccelerometerEventsSub.cancel();
    gyroscopeEventsSub.cancel();

    //Navigation.
    Navigator.pop(context);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BarcodeCalibrationDataProcessingView(
          rawBarcodeData: rawBarcodesData,
          rawUserAccelerometerData: rawAccelerometerData,
          startTimeStamp: startTimeStamp,
          barcodeID: barcodeID ?? 1,
        ),
      ),
    );
  }

  ///Checks if the input image has is black.
  bool checkIfCameraFeedIsBlack(InputImage inputImage) {
    //Convert the image to a bitmap 100x100
    img.Image bitmap = img.Image.fromBytes(100, 100, inputImage.bytes!,
        format: img.Format.rgba);

    //Counters to keep track of the pixel colour values.
    int redBucket = 0;
    int greenBucket = 0;
    int blueBucket = 0;
    //Count the number of pixels checked.
    int pixelCount = 0;

    //Run through the image.
    for (int y = 0; y < bitmap.height; y++) {
      for (int x = 0; x < bitmap.width; x++) {
        int c = bitmap.getPixel(x, y);
        pixelCount++;
        redBucket += img.getRed(c);
        greenBucket += img.getGreen(c);
        blueBucket += img.getBlue(c);
      }
    }

    //Calculate the average colour value of the image.
    //Note:
    //The more colour the image has the higher the average colour value will be.
    //The more black an image is the lower this average colour will be.
    //It is set to 15 units at the moment which is pretty much black.
    double averageColorValue = ((redBucket / pixelCount) +
            (greenBucket / pixelCount) +
            (blueBucket / pixelCount)) /
        3;

    if (averageColorValue <= 15 && initializeCalibration == false) {
      return true;
    } else {
      return false;
    }
  }
}
