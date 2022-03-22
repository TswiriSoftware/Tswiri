import 'dart:developer';

import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/objects/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_painter.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_processing_view.dart';
import 'package:isar/isar.dart';
import 'package:vector_math/vector_math.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:isolate';

class BarcodePositionScannerView extends StatefulWidget {
  const BarcodePositionScannerView({
    Key? key,
    required this.database,
    required this.barcodesToScan,
    required this.gridMarkers,
    required this.parentContainerUID,
  }) : super(key: key);

  final Isar database;
  final List<String> barcodesToScan;
  final List<String> gridMarkers;
  final String parentContainerUID;

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

  Vector3 accelerometerEvent = Vector3(0, 0, 0);
  Vector3 userAccelerometerEvent = Vector3(0, 0, 0);

  @override
  void initState() {
    //Listen to accelerometer events.
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = Vector3(event.x, event.y, event.z);
    });

    barcodesToScan = widget.barcodesToScan;
    gridMarkers = widget.gridMarkers;

    log('barcodesToScan: ' + barcodesToScan.toString());
    log('gridMarkers: ' + gridMarkers.toString());
    super.initState();
  }

  @override
  void dispose() {
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            List<String> allRelevantBarcodes = barcodesToScan + gridMarkers;
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BarcodePositionScannerProcessingView(
                  allRawOnImageBarcodeData: allRawOnImageBarcodeData,
                  database: widget.database,
                  parentContainerUID: widget.parentContainerUID,
                  relevantBarcodes: allRelevantBarcodes,
                ),
              ),
            );
          },
          child: const Icon(Icons.check_circle_outline_rounded),
        ),
        body: BarcodePositionScannerCameraView(
          color: brightOrange,
          title: 'Position Scanner',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
        ));
  }

  // @override
  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      //Dont bother if we haven't detected more than one barcode on a image.

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
      //Paint square on screen around barcode.

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
