import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';

import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/cameraView/camera_view_barcode_scanning.dart';

import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:vector_math/vector_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/barcode_scanner_data_processing.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../objects/accelerometer_data.dart';

class BarcodeScannerIsolateView extends StatefulWidget {
  const BarcodeScannerIsolateView({Key? key}) : super(key: key);

  @override
  _BarcodeScannerIsolateViewState createState() =>
      _BarcodeScannerIsolateViewState();
}

class _BarcodeScannerIsolateViewState extends State<BarcodeScannerIsolateView> {
  // BarcodeScanner barcodeScanner =
  //     GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  List<RawOnImageBarcodeData> allRawOnImageBarcodeData = [];
  bool isBusy = false;
  CustomPaint? customPaint;

  Vector3 accelerometerEvent = Vector3(0, 0, 0);
  Vector3 userAccelerometerEvent = Vector3(0, 0, 0);

  late FlutterIsolate isolate;
  ReceivePort mainReceivePort = ReceivePort();
  SendPort? isolateReceivePort;
  bool hasSentImageConfig = false;
  bool accelerometerEventsCanceled = false;
  int frames = 0;

  @override
  void initState() {
    //Start the isolate.
    _startIsolate();
    super.initState();
  }

  @override
  void dispose() {
    //Cancel Accelerometer Stream.
    cancelAccelerometerStream();
    //Kill Isolate.
    _killIsolate();
    super.dispose();
  }

  Future<void> _startIsolate() async {
    isolate = await FlutterIsolate.spawn(
        imageProcessingIsolate, mainReceivePort.sendPort);
    mainReceivePort.listen(handleMessageFromIsolate);
  }

  void _killIsolate() {
    isolate.kill();
  }

  ///Handle Message coming from Isolate.
  void handleMessageFromIsolate(dynamic data) {
    //Checks the type of data received.
    //Data type must be stored in data[0] except when default data is passed.

    String dataType = data[0];
    log('dataReceived: ' + dataType);
    switch (dataType) {
      case 'isolateReceivePort': //Isolate receive port
        isolateReceivePort = data[1];
        break;
      case 'accelerometerEventsCanceled': //Isolate receive port
        if (mounted) {
          setState(() {
            accelerometerEventsCanceled = true;
          });
        }

        break;
      default:
      //How to draw from here?
    }
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
                if (accelerometerEventsCanceled == false) {
                  return FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      cancelAccelerometerStream();
                    },
                    child: const Icon(Icons.check),
                  );
                } else {
                  return FloatingActionButton(
                      child: const Icon(Icons.check_circle_outline_rounded),
                      onPressed: () {
                        if (accelerometerEventsCanceled == true) {
                          _killIsolate();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BarcodeScannerDataProcessingView(
                                          allRawOnImageBarcodeData:
                                              allRawOnImageBarcodeData)));
                        }
                      });
                }
              }),
            ],
          ),
        ),
        body: CameraBarcodeScanningView(
          color: brightOrange,
          title: 'Barcode Scanner',
          customPaint: customPaint,
          onImage: (inputImage) {
            if (isolateReceivePort != null) {
              sendConfigToIsolate(inputImage);
            }
            if (inputImage.bytes != null &&
                isolateReceivePort != null &&
                frames == 0) {
              isolateReceivePort!.send(['bytes', inputImage.bytes]);
              frames++;
            } else if (frames == 3) {
              frames = 0;
            }
          },
        ));
  }

  @override
  Future<void> processImage(InputImage inputImage) async {
    // Run all of this lovely code in an isolate. :D
    if (isBusy) return;
    isBusy = true;

    // final List<Barcode> barcodes =
    //     await barcodeScanner.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      //Dont bother if we haven't detected more than one barcode on a image.
      // if (barcodes.length >= 2) {
      //   ///Captures a list of barcodes and accelerometerData for a a single image frame.
      // allRawOnImageBarcodeData.add(RawOnImageBarcodeData(
      //     barcodes: barcodes,
      //     timestamp: DateTime.now().millisecondsSinceEpoch,
      //     accelerometerData: getAccelerometerData()));
      // }
      //Paint square on screen around barcode.
      // final painter = BarcodeDetectorPainter(
      //     barcodes,
      //     inputImage.inputImageData!.size,
      //     inputImage.inputImageData!.imageRotation);

      //customPaint = CustomPaint(painter: painteghr);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  void sendConfigToIsolate(InputImage inputImage) {
    //Send Image config to Isolate.
    if (hasSentImageConfig == false) {
      //Checks if config has been sent.
      isolateReceivePort!.send([
        'imageConfig',
        inputImage.inputImageData!.size.height,
        inputImage.inputImageData!.size.width
      ]);
      hasSentImageConfig = true;
      //Future.delayed(const Duration(milliseconds: 200));
    }
  }

  void cancelAccelerometerStream() {
    if (isolateReceivePort != null) {
      isolateReceivePort!.send(['stopAccelerometer']);
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///Isolate code.
void imageProcessingIsolate(SendPort sendPort) {
  //This port is used to send data to the Main Loop.
  SendPort isolateSendPort = sendPort;

  //Isolate receive port.
  bool hasSent = false;
  ReceivePort isolateReceivePort = ReceivePort('isolateReceivePort');
  sendIsolateReceivePort(hasSent, sendPort, isolateReceivePort);

  //This will be populated from the config message coming from the mainloop.
  InputImageData? inputImageData;

  //Start google ml kit.
  late BarcodeScanner barcodeScanner;
  //GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  //Create accelerometer variables.
  Vector3 accelerometerEvent = Vector3(0, 0, 0);
  Vector3 userAccelerometerEvent = Vector3(0, 0, 0);
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  ///Handle Message coming from Main Loop.
  void handleMessageFromMain(dynamic data) async {
    //Checks the type of data received.
    //Data type must be stored in data[0] except when default data is passed.
    String dataType = data[0];

    switch (dataType) {
      case 'imageConfig':
        //Create InputImageData.
        //InputImageData for xiaomi redmi note 10S
        inputImageData = InputImageData(
            size: Size(data[2], data[1]), //Gets the image size from main loop.
            imageRotation: InputImageRotation
                .Rotation_90deg, //InputImageRotation.Rotation_90deg
            inputImageFormat: InputImageFormat
                .YUV_420_888, //InputImageFormat.YUV_420_888. there are many types take care.
            planeData: null);
        log('InputImageData created');
        barcodeScanner =
            GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);
        break;
      case 'stopAccelerometer':
        for (final subscription in _streamSubscriptions) {
          subscription.cancel();
        }
        isolateSendPort.send(['accelerometerEventsCanceled']);
        break;
      default:
        InputImage inputImage = InputImage.fromBytes(
            bytes: data[1], inputImageData: inputImageData!);

        final List<Barcode> barcodes =
            await barcodeScanner.processImage(inputImage);
        //Process data and send to main loop.
        //Must contain:
        //1. BoundingBox.
        //2. List of barcodes.

        log(barcodes.toString());
    }
  }

  //Listen to accelerometer events.
  _streamSubscriptions.add(
    accelerometerEvents.listen(
      (AccelerometerEvent event) {
        accelerometerEvent = Vector3(event.x, event.y, event.z);
      },
    ),
  );

  _streamSubscriptions.add(
    userAccelerometerEvents.listen(
      (UserAccelerometerEvent event) {
        userAccelerometerEvent = Vector3(event.x, event.y, event.z);
      },
    ),
  );

  //Gets the current accelerometer data.
  AccelerometerData getAccelerometerData() {
    return AccelerometerData(
        accelerometerEvent: accelerometerEvent,
        userAccelerometerEvent: userAccelerometerEvent);
  }

  isolateReceivePort.listen(handleMessageFromMain);
}

void sendIsolateReceivePort(
    bool hasSent, SendPort sendPort, ReceivePort isolateReceivePort) {
  if (hasSent == false) {
    //Checks if the port has been sent to the main loop.
    sendPort.send([
      'isolateReceivePort',
      isolateReceivePort.sendPort
    ]); //Send the receiveport to mainLoop.
    hasSent == true;
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////