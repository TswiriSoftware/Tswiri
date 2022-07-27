import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:sensors_plus/sensors_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as vm;
import 'grid_scanner_camera_view.dart';
import 'grid_scanner_painter.dart';
import 'grid_scanning_image_processor.dart';

///Returns a single barcodeUID.
class GridScannerView extends StatefulWidget {
  const GridScannerView({Key? key}) : super(key: key);

  @override
  State<GridScannerView> createState() => _GridScannerViewState();
}

class _GridScannerViewState extends State<GridScannerView> {
  bool _isBusy = false;
  CustomPaint? _customPaint;

  String? currentBarcode;
  int? timestamp;

  vm.Vector3 accelerometerEvent = vm.Vector3(0, 0, 0);
  vm.Vector3 userAccelerometerEvent = vm.Vector3(0, 0, 0);

  ReceivePort mainPort = ReceivePort(); //Send stuff to ui thread (1).
  ReceivePort mainPort2 = ReceivePort(); //Send stuff to ui thread (2).
  SendPort? isolatePort1; //send stuff to isolate (1).
  SendPort? isolatePort2; //send stuff to isolate (2).

  bool hasSentConfigIsolate1 = false;
  bool hasSentConfigIsolate2 = false;

  bool hasConfiguredIsolate1 = false;
  bool hasConfiguredIsolate2 = false;

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
    FlutterIsolate.spawn(gridScanningImageProcessor, mainPort.sendPort);

    FlutterIsolate.spawn(gridScanningImageProcessor, mainPort2.sendPort);

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
    mainPort2.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _continueButton(),
      body: GridScannerCameraView(
          title: 'Grid Scanner',
          customPaint: _customPaint,
          onImage: (inputImage) {
            //Configure the Isolate.
            if (hasSentConfigIsolate1 == false ||
                hasSentConfigIsolate2 == false) {
              configureImageProcessors(inputImage);
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
          }),
    );
  }

  Widget _continueButton() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        Navigator.pop(context, barcodeDataBatches);
      },
      child: const Icon(Icons.check_circle_outline_rounded),
    );
  }

  ///Configures the Image Processors.
  void configureImageProcessors(InputImage inputImage) async {
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
    if (_isBusy) return;
    _isBusy = true;

    final painter = GridScannerPainter(message: barcodeDataBatch);
    _customPaint = CustomPaint(painter: painter);

    barcodeDataBatches.add(barcodeDataBatch);

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
