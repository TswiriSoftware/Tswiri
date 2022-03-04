import 'dart:async';
import 'dart:developer' as d;
import 'dart:math';
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
  bool hasStartedCalibration = false;
  bool initializeCalibration = false;
  bool isBusy = false;
  int noBarcodesScanned = 0;
  bool isShowingDialog = false;

  CustomPaint? customPaint;
  double zAcceleration = 0;
  int? barcodeID;
  late StreamSubscription<UserAccelerometerEvent> subscription;

  @override
  void initState() {
    subscription =
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      zAcceleration = event.z;
      setState(() {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        rawAccelerometerData.add(RawUserAccelerometerZAxisData(
            timestamp: timestamp, rawAcceleration: zAcceleration));
      });
    });
    super.initState();

    //Future(_showCalibrationInstuctions);
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
        body: CameraViewCameraCalibration(
      title: 'Camera Calibration',
      customPaint: customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      color: skyBlue,
    ));
  }

  AlertDialog myAlertDialog() {
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
  }

  BuildContext? myDialogContext;
  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    final barcodes = await barcodeScanner.processImage(inputImage);
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    if (hasStartedCalibration == false && initializeCalibration == false) {
      //This initializes the Instruction Dialog.
      showInitialInstructionDialog();

      checkIfCameraFeedIsBlack(inputImage);
    }

    if (hasStartedCalibration == true && isShowingDialog == true) {
      closeInstructionDialog();
    }

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null &&
        barcodes.isNotEmpty) {
      //When the calibration has started start adding rawBarcodeData to the List.
      if (hasStartedCalibration == true) {
        rawBarcodesData
            .add(BarcodeData(timestamp: timestamp, barcode: barcodes.first));
      }

      //This checks if the barcode has a display value and sets it.
      // if (mounted) {
      //   if (barcodes.first.value.displayValue != null) {
      //     setState(() {
      //       barcodeID = int.parse(barcodes.first.value.displayValue!);
      //     });
      //   }

      // }

      final painter = BarcodeDetectorPainterCalibration(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);

      customPaint = CustomPaint(painter: painter);

      resetNoBarcodesScanned();
    } else {
      customPaint = null;
      if (mounted) {
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

  void showInitialInstructionDialog() {
    if (isShowingDialog == false && initializeCalibration == false) {
      isShowingDialog = true;

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          myDialogContext = dialogContext;

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

  void closeInstructionDialog() {
    if (myDialogContext != null) {
      isShowingDialog = false;
      Navigator.pop(myDialogContext!);
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
    Navigator.pop(context);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => BarcodeCalibrationDataProcessingView(
              rawBarcodeData: rawBarcodesData,
              rawUserAccelerometerData: rawAccelerometerData,
              startTimeStamp: startTimeStamp,
              barcodeID: barcodeID ?? 1,
            )));
  }

  ///Checks if the input image has is black.
  void checkIfCameraFeedIsBlack(InputImage inputImage) {
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

    if (mounted) {
      if (averageColorValue <= 15 && initializeCalibration == false) {
        setState(() {
          //Initilize the calibration.
          initializeCalibration = true;

          d.log('d');
          //Display a snackbar message.
          SnackBar snackBar = const SnackBar(
            content: Text('Calibration will start in 1 second.'),
            duration: Duration(milliseconds: 100),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          //Wait 1 second.
          //Future.delayed(const Duration(seconds: 1));
          //Start the calibration.
          hasStartedCalibration = true;
          //Set the start timestamp for use in the processing screen.
          startTimeStamp = DateTime.now().millisecondsSinceEpoch;
        });
      }
    }
  }
}
