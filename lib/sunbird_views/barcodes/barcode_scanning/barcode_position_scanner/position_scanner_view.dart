// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:isolate';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isolates/image_processing_isolate.dart';
import 'package:flutter_google_ml_kit/objects/reworked/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/barcode_position_scanner/position_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/barcode_position_scanner/position_painter.dart';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/barcode_position_scanner/position_processing_view.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:sensors_plus/sensors_plus.dart';

class PositionScannerView extends StatefulWidget {
  const PositionScannerView({
    Key? key,
    required this.parentContainer,
    this.customColor,
  }) : super(key: key);

  final ContainerEntry parentContainer;
  final Color? customColor;

  @override
  _PositionScannerViewState createState() => _PositionScannerViewState();
}

class _PositionScannerViewState extends State<PositionScannerView> {
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
                builder: (context) => PositionProcessingView(
                  barcodeDataBatches: barcodeDataBatches,
                  parentContainer: widget.parentContainer,
                ),
              ),
            );
          },
          child: const Icon(Icons.check_circle_outline_rounded),
        ),
        body: PositionCameraView(
          title: 'Position Scanner',
          color: widget.customColor ?? sunbirdOrange,
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

    final painter = PositionPainter(message: barcodeDataBatch);
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
