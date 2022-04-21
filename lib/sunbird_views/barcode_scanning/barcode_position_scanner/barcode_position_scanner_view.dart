import 'dart:developer';
import 'dart:isolate';
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
  SendPort? isolatePort; //send stuff to isolate
  bool hasSentConfig = false;

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

  void initIsolate() {
    //Spawn Isolate.
    FlutterIsolate.spawn(imageProcessorIsolate, mainPort.sendPort);

    //Port setup.
    mainPort.listen((msg) {
      if (msg is SendPort) {
        isolatePort = msg;
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
                  allRawOnImageBarcodeData: allRawOnImageBarcodeData,
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
            configureIsolate(inputImage);

            //Send Image Data.
            if (isolatePort != null && inputImage.bytes != null) {
              isolatePort!.send(inputImage.bytes!);
            }
          },
        ));
  }

  //Draw on canvas from barcode message.
  void drawImage(List message) {
    if (isBusy) return;
    isBusy = true;

    final painter = BarcodePositionPainterIsolate(message: message);
    customPaint = CustomPaint(painter: painter);

    //TODO: Record Position etc.

    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  void configureIsolate(InputImage inputImage) {
    if (inputImage.inputImageData != null &&
        hasSentConfig == false &&
        isolatePort != null) {
      //Calculate Canvas size.
      Size screenSize = Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top);

      List config = [
        inputImage.inputImageData!.size.height,
        inputImage.inputImageData!.size.width,
        inputImage.inputImageData!.inputImageFormat.index,
        screenSize.width,
        screenSize.height,
      ];

      isolatePort!.send(config);

      setState(() {
        hasSentConfig = true;
      });
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

  void processImage(Uint8List message) async {
    if (inputImageData != null && screenSize != null) {
      InputImage inputImage =
          InputImage.fromBytes(bytes: message, inputImageData: inputImageData!);

      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      List barcodeData = [];
      for (Barcode barcode in barcodes) {
        List<Offset> offsetPoints = <Offset>[];

        for (var point in barcode.value.cornerPoints!) {
          double x = translateX(point.x.toDouble(),
              inputImageData!.imageRotation, screenSize!, inputImageData!.size);
          double y = translateY(point.y.toDouble(),
              inputImageData!.imageRotation, screenSize!, inputImageData!.size);

          offsetPoints.add(Offset(x, y));
        }

        barcodeData.add([
          barcode.value.displayValue, //Display value.
          [
            offsetPoints[0].dx, //On Screen Points
            offsetPoints[0].dy,
            offsetPoints[1].dx,
            offsetPoints[1].dy,
            offsetPoints[2].dx,
            offsetPoints[2].dy,
            offsetPoints[3].dx,
            offsetPoints[3].dy,
          ],
          [],
        ]);
      }
      log(barcodeData.toString());

      sendPort.send(barcodeData);
    }
  }

  //TODO: create asset image , test ml kit here.

  receivePort.listen(
    (message) {
      if (message is Uint8List) {
        //Process the image.
        processImage(message);
      } else if (message is List) {
        //Configure InputImageData.
        inputImageData = InputImageData(
          size: Size(message[1], message[0]),
          imageRotation: InputImageRotation.Rotation_90deg,
          inputImageFormat: InputImageFormat.values.elementAt(message[2]),
          planeData: null,
        );

        screenSize = Size(message[3], message[4]);
      }
    },
  );
}
