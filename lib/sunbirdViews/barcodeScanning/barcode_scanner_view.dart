import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/main.dart';
import 'package:flutter_google_ml_kit/objects/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/cameraView/camera_view_barcode_scanning.dart';
import 'package:vector_math/vector_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/barcode_scanner_data_processing.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:isolate';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({Key? key}) : super(key: key);

  @override
  _BarcodeScannerViewState createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  List<RawOnImageBarcodeData> allRawOnImageBarcodeData = [];
  bool isBusy = false;
  CustomPaint? customPaint;

  Vector3 accelerometerEvent = Vector3(0, 0, 0);
  Vector3 userAccelerometerEvent = Vector3(0, 0, 0);

  //Isolate
  late Isolate imageProcessorIsolate;
  late ReceivePort mainReceivePort;
  late SendPort isolateReceivePort;
  bool hasSentImageConfig = false;

  @override
  void initState() {
    //Listen to accelerometer events.
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = Vector3(event.x, event.y, event.z);
    });

    //Start the Isolate that will process the images.
    startImageProcessor();
    super.initState();
  }

  @override
  void dispose() {
    barcodeScanner.close();
    //Kills the Isolate.
    killImageProcessor();
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
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  //Kills the Isolate.
                  killImageProcessor();
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BarcodeScannerDataProcessingView(
                          allRawOnImageBarcodeData: allRawOnImageBarcodeData)));
                },
                child: const Icon(Icons.check_circle_outline_rounded),
              ),
            ],
          ),
        ),
        body: CameraBarcodeScanningView(
          color: brightOrange,
          title: 'Barcode Scanner',
          customPaint: customPaint,
          onImage: (inputImage) {
            sendConfigToIsolate(inputImage);
            if (inputImage.bytes != null) {
              isolateReceivePort.send(['bytes', inputImage.bytes]);
              Future.delayed(Duration(milliseconds: 100));
            }

            //isolateReceivePort.send('Sending DATA');
          },
        ));
  }

  ///Handle Message coming from Isolate.
  void handleMessageFromIsolate(dynamic data) {
    //Checks the type of data received.
    //Data type must be stored in data[0] except when default data is passed.
    String dataType = data[0];
    switch (dataType) {
      case 'isolateReceivePort': //Isolate receive port
        isolateReceivePort = data[1];
        break;
      default:
      //log('Default');
    }
  }

  void sendConfigToIsolate(InputImage inputImage) {
    //Send Image config to Isolate.
    if (hasSentImageConfig == false) {
      //Checks if config has been sent.
      isolateReceivePort.send([
        'imageConfig',
        inputImage.inputImageData!.size.height,
        inputImage.inputImageData!.size.width
      ]);
      hasSentImageConfig = true;
    }
  }

  ///This stores the AccelerometerEvent and UserAccelerometerEvent at an instant.
  AccelerometerData getAccelerometerData() {
    return AccelerometerData(
        accelerometerEvent: accelerometerEvent,
        userAccelerometerEvent: userAccelerometerEvent);
  }

  ///Starts the Isolate.
  void startImageProcessor() async {
    mainReceivePort = ReceivePort('mainReceivePort');
    //Create the Isolate.
    imageProcessorIsolate =
        await Isolate.spawn(imageProcessor, mainReceivePort.sendPort);
    //This creates a listener on the port.
    mainReceivePort.listen(handleMessageFromIsolate, onDone: () {});
  }

  ///Kills the Isolate
  void killImageProcessor() {
    if (imageProcessorIsolate != null) {
      mainReceivePort.close();
      imageProcessorIsolate.kill(priority: Isolate.immediate);
    }
  }
}

///This is the code that runs in the isolate.
Future<void> imageProcessor(SendPort sendPort) async {
  WidgetsFlutterBinding.ensureInitialized();

  //This SendPort is for sending data to the main loop.
  SendPort isolateSendPort = sendPort;

  //Isolate receive port.
  ReceivePort isolateReceivePort = ReceivePort('isolateReceivePort');

  //This will be populated from the config message coming from the mainloop.
  InputImageData? inputImageData;

  //Send isolate receivePort to main loop.
  bool hasSent = false;
  sendIsolateReceivePort(hasSent, sendPort, isolateReceivePort);

  //runApp(testApp());

  BarcodeScanner isolatebarcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);
  bool isBusy = false;

  void processImages(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    log('message');
    List<Barcode> barcodes =
        await isolatebarcodeScanner.processImage(inputImage);
    isBusy = false;
  }

  ///Handle Message coming from Main Loop.
  void handleMessageFromMain(dynamic data) async {
    //Checks the type of data received.
    //Data type must be stored in data[0] except when default data is passed.
    String dataType = data[0];

    if (dataType == 'imageConfig') {
      //Create InputImageData.
      //InputImageData for xiaomi redmi note 10S
      inputImageData = InputImageData(
          size: Size(data[2], data[1]), //Gets the image size from main loop.
          imageRotation: InputImageRotation
              .Rotation_90deg, //InputImageRotation.Rotation_90deg
          inputImageFormat: InputImageFormat
              .YUV_420_888, //InputImageFormat.YUV_420_888. there are many types take care.
          planeData: null);

      //log('InputImageData created');
    } else if (data[0] == 'bytes' && inputImageData != null) {
      InputImage inputImage =
          InputImage.fromBytes(bytes: data[1], inputImageData: inputImageData!);
      processImages(inputImage);
    }
  }

  //This creates a listener on the port.
  isolateReceivePort.listen(handleMessageFromMain, onDone: () {});
}

void sendIsolateReceivePort(
    bool hasSent, SendPort sendPort, ReceivePort isolateReceivePort) {
  if (hasSent == false) {
    //Checks if the port has been sent to the main loop.
    sendPort.send([
      'isolateReceivePort',
      isolateReceivePort.sendPort
    ]); //Send the receiveport send port to mainLoop.
    hasSent == true;
  }
}

// @override
// Future<void> processImage(InputImage inputImage) async {
//   Run all of this lovely code in an isolate. :D
//     if (isBusy) return;
//     isBusy = true;

//   final List<Barcode> barcodes =
//       await barcodeScanner.processImage(inputImage);

//     if (inputImage.inputImageData?.size != null &&
//         inputImage.inputImageData?.imageRotation != null) {
//       //Dont bother if we haven't detected more than one barcode on a image.
//       if (barcodes.length >= 2) {
//         ///Captures a list of barcodes and accelerometerData for a a single image frame.
//         allRawOnImageBarcodeData.add(RawOnImageBarcodeData(
//             barcodes: barcodes,
//             timestamp: DateTime.now().millisecondsSinceEpoch,
//             accelerometerData: getAccelerometerData()));
//       }
//       //Paint square on screen around barcode.
//       final painter = BarcodeDetectorPainter(
//           barcodes,
//           inputImage.inputImageData!.size,
//           inputImage.inputImageData!.imageRotation);

//       customPaint = CustomPaint(painter: painter);
//     } else {
//       customPaint = null;
//     }
//     isBusy = false;
//     if (mounted) {
//       setState(() {});
//     }
// }

class QueuedImage {
  QueuedImage({required this.imageBytes, required this.timestamp});
  final Uint8List imageBytes;
  final int timestamp;
}
