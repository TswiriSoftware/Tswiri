import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:flutter_google_ml_kit/objects/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/painters/barcode_position_painter.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_processing_view.dart';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_isolate/flutter_isolate.dart';


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
  List<String> barcodesToScan = [];
  List<String> gridMarkers = [];

  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  List<RawOnImageBarcodeData> allRawOnImageBarcodeData = [];
  bool isBusy = false;
  CustomPaint? customPaint;

  vm.Vector3 accelerometerEvent = vm.Vector3(0, 0, 0);
  vm.Vector3 userAccelerometerEvent = vm.Vector3(0, 0, 0);

  ReceivePort mainPort = ReceivePort(); // send stuff to ui thread
  SendPort? isolatePort; //send stuff to isolate 

  @override
  void initState() {
    //Listen to accelerometer events.
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });

    barcodesToScan = widget.barcodesToScan;
    gridMarkers = widget.gridMarkers;

    log('barcodesToScan: ' + barcodesToScan.toString());
    log('gridMarkers: ' + gridMarkers.toString());

    mainPort.listen((msg) { //is listining on any massages that come to the main ui 
    if (msg is SendPort) {
    isolatePort = msg;
    }
    print("Received message from isolate $msg");
    
    });

    FlutterIsolate.spawn(imageProcessorIsolate, mainPort.sendPort);

    //extra note

    //FlutterIsolate isolate = FlutterIsolate.spawn(imageProcessorIsolate, port.sendPort);
    super.initState();
  }

  @override
  void dispose() {
    barcodeScanner.close();
    FlutterIsolate.killAll();
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
            processImage(inputImage);
          },
        ));
  }


















  //changes

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    isolatePort!.send(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      //Dont bother if we haven't detected more than one barcode on a image.

      

      final List<Barcode> barcodes =
      await barcodeScanner.processImage(inputImage);

      //TODO: create asset/on device image with scannable barcode , get it working here. 

      if (barcodes.length >= 2) {
        ///Captures a list of barcodes and accelerometerData for a a single image frame.
        allRawOnImageBarcodeData.add(
          RawOnImageBarcodeData(
            barcodes: barcodes,
            timestamp: DateTime.now().millisecondsSinceEpoch,
            accelerometerData: getAccelerometerData(),
          ),
        );
      }

      //Paint different colors around barcodes depending on their type, Normal, Marker, non-relevant.
      final painter = BarcodePositionPainter(
        barcodes: barcodes,
        absoluteImageSize: inputImage.inputImageData!.size,
        rotation: inputImage.inputImageData!.imageRotation,
        barcodesToScan: barcodesToScan,
        gridMarkers: gridMarkers,
      );

      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
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

   //TODO: create asset image , test ml kit here.

    receivePort.listen((message) { //is listening for all messages coming to isolate 
    if (message is InputImage) {
         print("input image received:");
         print("size:" + message.inputImageData!.size.height.toString());
    }
    else {
        print(message);
    }
    
  });
    Timer.periodic(
      Duration(seconds: 1), (timer) => sendPort.send("hello" + DateTime.now().toString()));
    
}