import 'dart:developer';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/objects/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/painters/barcode_position_painter_isolate.dart';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_processing_view.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:sensors_plus/sensors_plus.dart';

class BarcodePositionScannerView extends StatefulWidget {
  const BarcodePositionScannerView({
    Key? key,
    required this.barcodesToScan,
    required this.gridMarkers,
    required this.parentContainerUID,
    this.customColor,
  }) : super(key: key);

  final List<String> barcodesToScan;
  final List<String> gridMarkers;
  final String parentContainerUID;
  final Color? customColor;

  @override
  _BarcodePositionScannerViewState createState() =>
      _BarcodePositionScannerViewState();
}

class _BarcodePositionScannerViewState
    extends State<BarcodePositionScannerView> {
  late List<String> barcodesToScan = widget.barcodesToScan;
  late List<String> gridMarkers = widget.gridMarkers;

  // BarcodeScanner barcodeScanner =
  //     GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  List<RawOnImageBarcodeData> allRawOnImageBarcodeData = [];
  bool isBusy = false;
  CustomPaint? customPaint;

  vm.Vector3 accelerometerEvent = vm.Vector3(0, 0, 0);
  vm.Vector3 userAccelerometerEvent = vm.Vector3(0, 0, 0);

  ReceivePort mainPort = ReceivePort(); // send stuff to ui thread
  ReceivePort mainPort2 = ReceivePort();
  SendPort? isolatePort1; //send stuff to isolate
  SendPort? isolatePort2; //send stuff to isolate

  bool hasSentConfigIsolate1 = false;
  bool hasSentConfigIsolate2 = false;

  bool hasConfiguredIsolate1 = false;
  bool hasConfiguredIsolate2 = false;

  bool x = false;

  int counter1 = 0;

  List<dynamic> barcodeDataBatches = [];

  //Spawn Isolate.

  //TODO: multiple Isolates ?

  @override
  void initState() {
    //Listen to accelerometer events.
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });

    initIsolate();

    super.initState();
  }

  void initIsolate() async {
    //Spawn Isolate.
    FlutterIsolate.spawn(imageProcessorIsolate, mainPort.sendPort);

    FlutterIsolate.spawn(imageProcessorIsolate, mainPort2.sendPort);

    //Port setup.
    mainPort.listen((msg) {
      if (msg is SendPort) {
        isolatePort1 = msg;
      } else if (msg == 'configured') {
        setState(() {
          hasConfiguredIsolate1 = true;
        });
      } else {
        drawImage(msg);
      }
    });

    //Port setup.
    mainPort2.listen((msg) {
      if (msg is SendPort) {
        isolatePort2 = msg;
      } else if (msg == 'configured') {
        setState(() {
          hasConfiguredIsolate2 = true;
        });
      } else {
        drawImage(msg);
      }
    });
  }

  @override
  void dispose() {
    FlutterIsolate.killAll();
    mainPort.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: widget.customColor,
          heroTag: null,
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BarcodePositionScannerProcessingView(
                  barcodeDataBatches: barcodeDataBatches,
                  parentContainerUID: widget.parentContainerUID,
                  gridMarkers: gridMarkers,
                  barcodesToScan: barcodesToScan,
                ),
              ),
            );
          },
          child: const Icon(Icons.check_circle_outline_rounded),
        ),
        body: BarcodePositionScannerCameraView(
          color: widget.customColor ?? Colors.deepOrange,
          title: 'Position Scanner',
          customPaint: customPaint,
          onImage: (inputImage) async {
            //Configure the Isolate.
            if (hasSentConfigIsolate1 == false ||
                hasSentConfigIsolate2 == false) {
              configureIsolate(inputImage);
            }

            //Send Image Data.
            if (inputImage.bytes != null &&
                hasConfiguredIsolate1 == true &&
                hasConfiguredIsolate2 == true) {
              List myList = [
                'compute', // Identifier [0]
                TransferableTypedData.fromList([inputImage.bytes!]), //Bytes [1]
                [
                  //Accelerometer Data [2]
                  accelerometerEvent.x,
                  accelerometerEvent.y,
                  accelerometerEvent.z,
                  userAccelerometerEvent.x,
                  userAccelerometerEvent.y,
                  userAccelerometerEvent.z,
                ],
                DateTime.now().microsecondsSinceEpoch, //Timestamp [3]
              ];

              if (counter1 == 0) {
                isolatePort1!.send(myList);
              } else if (counter1 == 3) {
                isolatePort2!.send(myList);
              }

              counter1++;
              if (mounted && counter1 == 6) {
                setState(() {
                  counter1 = 0;
                });
              }
            }
          },
        ));
  }

  void configureIsolate(InputImage inputImage) async {
    if (inputImage.inputImageData != null) {
      //Calculate Canvas Size.
      Size screenSize = Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top);

      //Setup config List.
      List config = [
        inputImage.inputImageData!.size.height,
        inputImage.inputImageData!.size.width,
        inputImage.inputImageData!.inputImageFormat.index,
        screenSize.width,
        screenSize.height,
      ];
      //Send to isolate 1.
      if (isolatePort1 != null) {
        isolatePort1!.send(config);
        setState(() {
          hasSentConfigIsolate1 = true;
        });
      }
      if (isolatePort2 != null) {
        isolatePort2!.send(config);
        setState(() {
          hasSentConfigIsolate2 = true;
        });
      }
    }
  }

  //Draw on canvas from barcode message.
  void drawImage(List barcodeDataBatch) {
    if (isBusy) return;
    isBusy = true;

    final painter = BarcodePositionPainterIsolate(message: barcodeDataBatch);
    customPaint = CustomPaint(painter: painter);

    barcodeDataBatches.add(barcodeDataBatch);

    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  ///This stores the AccelerometerEvent and UserAccelerometerEvent at an instant.
  AccelerometerData getAccelerometerData() {
    return AccelerometerData(
        accelerometerEvent: accelerometerEvent,
        userAccelerometerEvent: userAccelerometerEvent);
  }
}

void imageProcessorIsolate(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  InputImageData? inputImageData;
  Size? screenSize;

  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  void processImage(var message) async {
    if (inputImageData != null && screenSize != null) {
      InputImage inputImage = InputImage.fromBytes(
          bytes:
              (message[1] as TransferableTypedData).materialize().asUint8List(),
          inputImageData: inputImageData!);

      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      List<dynamic> barcodeData = [];

      for (Barcode barcode in barcodes) {
        List<Offset> offsetPoints = <Offset>[];
        List<math.Point<num>> cornerPoints = barcode.value.cornerPoints!;
        for (var point in cornerPoints) {
          double x = translateX(point.x.toDouble(),
              inputImageData!.imageRotation, screenSize!, inputImageData!.size);
          double y = translateY(point.y.toDouble(),
              inputImageData!.imageRotation, screenSize!, inputImageData!.size);

          offsetPoints.add(Offset(x, y));
        }

        barcodeData.add([
          barcode.value.displayValue, //Display value. [0]
          [
            //On Screen Points [1]
            offsetPoints[0].dx,
            offsetPoints[0].dy,
            offsetPoints[1].dx,
            offsetPoints[1].dy,
            offsetPoints[2].dx,
            offsetPoints[2].dy,
            offsetPoints[3].dx,
            offsetPoints[3].dy,
          ],
          [
            //On Image Points [2]
            cornerPoints[0].x.toDouble(), // Point1. x
            cornerPoints[0].y.toDouble(), // Point1. y
            cornerPoints[1].x.toDouble(), // Point2. x
            cornerPoints[1].y.toDouble(), // Point2. y
            cornerPoints[2].x.toDouble(), // Point3. x
            cornerPoints[2].y.toDouble(), // Point3. y
            cornerPoints[3].x.toDouble(), // Point4. x
            cornerPoints[3].y.toDouble(), // Point5. y
          ],
          [
            // Accelerometer Data [3]
            message[2][0], //accelerometerEvent.x
            message[2][1], //accelerometerEvent.y
            message[2][2], //accelerometerEvent.z
            message[2][3], //userAccelerometerEvent.x
            message[2][4], //userAccelerometerEvent.y
            message[2][5], //userAccelerometerEvent.z
          ],
          message[3], // timeStamp [4]
        ]);
      }
      //log(barcodeData.toString());

      sendPort.send(barcodeData);
    }
  }

  receivePort.listen(
    (message) {
      if (message[0] == 'compute') {
        //Process the image.
        processImage(message);
      } else if (message is List) {
        log('configured');
        //Configure InputImageData.
        inputImageData = InputImageData(
          size: Size(message[1], message[0]),
          imageRotation: InputImageRotation.Rotation_90deg,
          inputImageFormat: InputImageFormat.values.elementAt(message[2]),
          planeData: null,
        );

        screenSize = Size(message[3], message[4]);

        sendPort.send('configured');
      }
    },
  );
}
