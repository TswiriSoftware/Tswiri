import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/search/navigator/navigator_camera_view.dart';
import 'package:sunbird/views/search/navigator/navigator_painter.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as vm;

import 'navigator_grid_processor.dart';
import 'navigator_image_processor.dart';

//ImageProcessor Counter.
int counter = 0;

class NavigatorView extends StatefulWidget {
  const NavigatorView({
    Key? key,
    required this.catalogedContainer,
    required this.gridUID,
  }) : super(key: key);
  final CatalogedContainer catalogedContainer;
  final int gridUID;
  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
  late final CatalogedContainer _catalogedContainer = widget.catalogedContainer;
  //Painter
  CustomPaint? _customPaint;

  //UI-Ports (multiple-ports are snappier)
  final ReceivePort _uiPort1 = ReceivePort('uiPort1'); //ImageProcessor
  final ReceivePort _uiPort2 = ReceivePort('uiPort2'); //ImageProcessor
  final ReceivePort _uiPort3 = ReceivePort('uiPort3'); //GridProcessor

  //Isolate-Ports
  SendPort? _imageProcessor1;
  SendPort? _imageProcessor2;
  SendPort? _gridProcessor1;

  bool _hasConfiguredImageProcessors = false;

  //Accelerometer Data
  vm.Vector3 accelerometerEvent = vm.Vector3(0, 0, 0);
  vm.Vector3 userAccelerometerEvent = vm.Vector3(0, 0, 0);

  //Painter
  bool _isBusy = false;

  // //Dialogs
  // bool _showingDialog = false;

  @override
  void initState() {
    //reset counter
    counter = 0;
    //reset averageOffsetToBarcode.
    averageOffsetToBarcode = null;

    //Initiate accelerometer events.
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });

    //Initiate Image Processor Isolates.
    FlutterIsolate.spawn(
      navigationImageProcessor,
      [
        1, //[0] ID
        _uiPort1.sendPort, //[1] SendPort
        isarDirectory!.path, //[2] Isar Directory.
        focalLength, //[3] focalLength
        _catalogedContainer.barcodeUID, //[4] selectedContainer BarcodeUID
        defaultBarcodeSize, //[5]  Default Barcode Size.
        widget.gridUID, //[6] selectedContainer GridUID.
      ],
    );

    FlutterIsolate.spawn(
      navigationImageProcessor,
      [
        2, //[0] ID
        _uiPort2.sendPort, //[1] SendPort
        isarDirectory!.path, //[2] Isar Directory
        focalLength, //[3] focalLength
        _catalogedContainer.barcodeUID, //[4] selectedContainer BarcodeUID
        defaultBarcodeSize, //[5]  Default Barcode Size.
        widget.gridUID, //[6] selectedContainer GridUID.
      ],
    );

    //Spawn the Grid Processor.
    FlutterIsolate.spawn(
      gridProcessor,
      [
        _uiPort3.sendPort,
        isarDirectory!.path,
        focalLength,
        defaultBarcodeSize,
      ],
    );

    _uiPort1.listen((message) {
      if (message[0] == 'Sendport') {
        _imageProcessor1 = message[1];
        log('UI: ImageProcessor1 Port Set');
      } else if (message[0] == 'painterMessage') {
        drawImage(message);
      } else if (message[0] == 'error') {
        // errorHandler(message);
      }
    });

    _uiPort2.listen((message) {
      if (message[0] == 'Sendport') {
        _imageProcessor2 = message[1];
        log('UI: ImageProcessor2 Port Set');
      } else if (message[0] == 'painterMessage') {
        drawImage(message);
      } else if (message[0] == 'error') {
        // errorHandler(message);
      }
    });

    _uiPort3.listen((message) {
      if (message[0] == 'Sendport') {
        _gridProcessor1 = message[1];
        log('UI: GridProcessor1 Port Set');
      } else if (message[0] == 'update') {
        _imageProcessor1!.send(message);
        _imageProcessor2!.send(message);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    FlutterIsolate.killAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        NavigatorCameraView(
          title: _catalogedContainer.name ?? _catalogedContainer.containerUID,
          customPaint: _customPaint,
          onImage: (inputImage) {
            if (_hasConfiguredImageProcessors == false) {
              configureImageProcessors(inputImage);
            } else {
              sendImageDataMessage(inputImage);
            }
          },
        ),
        Visibility(
          visible: _imageProcessor1 == null && _imageProcessor2 == null,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  ///Draw on canvas from barcode message.
  void drawImage(message) {
    if (_isBusy) return;
    _isBusy = true;

    final painter = NavigatorPainter(
      message: message,
    );

    _customPaint = CustomPaint(painter: painter);

    if (mounted) {
      setState(() {
        _isBusy = false;
      });
    }
  }

  ///Configure the ImageProcessors.
  void configureImageProcessors(InputImage inputImage) {
    if (inputImage.inputImageData != null &&
        _imageProcessor1 != null &&
        _imageProcessor2 != null &&
        _gridProcessor1 != null) {
      //1. Calculate Canvas Size.
      Size canvasSize = Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top);

      //2. Setup config List.
      List config = [
        'ImageProcessorConfig', // [0]
        inputImage.inputImageData!.size.width, //Absolute Width. [1]
        inputImage.inputImageData!.size.height, //Absolute Height. [2]
        inputImage
            .inputImageData!.inputImageFormat.index, //InputImageFormat. [3]
        canvasSize.width, //Canvas Width. [4]
        canvasSize.height, //Canvas Height. [5]
        _gridProcessor1, //Grid Processor sendPort. [6]
      ];

      //3. Send Config.
      _imageProcessor1!.send(config);
      _imageProcessor2!.send(config);

      setState(() {
        _hasConfiguredImageProcessors = true;
      });
    }
  }

  ///Sends ImageData to the ImageProcessor(s)
  void sendImageDataMessage(InputImage inputImage) {
    List message = [
      'process', // Identifier [0]
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

    //Send Data.
    if (counter == 0) {
      _imageProcessor1!.send(message);
    } else if (counter == 3) {
      _imageProcessor2!.send(message);
    }

    counter++;
    if (mounted && counter == 6) {
      setState(() {
        counter = 0;
      });
    }
  }
}
