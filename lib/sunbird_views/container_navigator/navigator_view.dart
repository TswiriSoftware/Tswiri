import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/objects/reworked/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/isolates/image_processor.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/isolates/messages/image_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/isolates/messages/image_processor_config.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/navigator_painter.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:isolate';
import 'package:vector_math/vector_math.dart' as vm;

import 'package:google_ml_kit/google_ml_kit.dart';

class NavigatorView extends StatefulWidget {
  const NavigatorView({
    Key? key,
    required this.containerEntry,
  }) : super(key: key);

  final ContainerEntry containerEntry;
  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
  //Color
  late Color color =
      getContainerColor(containerUID: widget.containerEntry.containerUID);

  //Painter
  CustomPaint? customPaint;

  //Isolate Ports
  ReceivePort uiPort = ReceivePort('uiPort1');

  SendPort? imageProcessor1;
  SendPort? imageProcessor2;

  bool hasConfiguredIPs = false;

  //Accelerometer Data
  vm.Vector3 accelerometerEvent = vm.Vector3(0, 0, 0);
  vm.Vector3 userAccelerometerEvent = vm.Vector3(0, 0, 0);

  //ImageProcessor Counter.
  int counter = 0;

  //Painter
  bool isBusy = false;

  @override
  void initState() {
    //Spawn Impage processors.
    initiateIsolates();

    //Initaite Accelerometer.
    initiateAccelerometer();
    super.initState();
  }

  //Initate Accelerometer Event Listeners.
  void initiateAccelerometer() {
    //Listen to accelerometer events.
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });
  }

  //Initiate Isolates and uiPort listener.
  void initiateIsolates() {
    FlutterIsolate.spawn(imageProcessor, [
      uiPort.sendPort, //SendPort [0]
      1, //ID [1]
      isarDirectory!.path, //IsarDirectory [2]
      focalLength, // FocalLength [3]
      widget.containerEntry.barcodeUID, //SelectedBarcodeUID [4]
      defaultBarcodeDiagonalLength ?? 100, //Default Barcode Size [5]
    ]);

    FlutterIsolate.spawn(imageProcessor, [
      uiPort.sendPort,
      2,
      isarDirectory!.path,
      focalLength,
      widget.containerEntry.barcodeUID,
      defaultBarcodeDiagonalLength ?? 100,
    ]);

    uiPort.listen((message) {
      if (message is List && message[0] == 'ip_ui_config') {
        switch (message[1]) {
          case 1: //Configure ImageProcessor1.
            setState(() {
              imageProcessor1 = message[2];
              log('ui : IP1 Port Set');
            });
            break;
          case 2: //Configure ImageProcessor2.
            setState(() {
              imageProcessor2 = message[2];
              log('ui : IP2 Port Set');
            });
            break;
        }
      } else if (message[0] == 'painterMessage') {
        drawImage(message);
      }
    });
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
      floatingActionButton: _floatingActionButton(),
    );
  }

  Stack _body() {
    return Stack(
      children: [
        BarcodePositionScannerCameraView(
          color: color,
          title: 'Position Scanner',
          customPaint: customPaint,
          onImage: (inputImage) {
            if (hasConfiguredIPs == false) {
              configureIPs(inputImage);
            } else {
              sendImageDataMessage(inputImage);
            }
          },
        ),
        Visibility(
          visible: imageProcessor1 == null && imageProcessor2 == null,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: color,
      heroTag: null,
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Icon(Icons.check_circle_outline_rounded),
    );
  }

  //Draw on canvas from barcode message.
  void drawImage(message) {
    if (isBusy) return;
    isBusy = true;

    final painter = NavigatorPainter(
      message: message,
      containerEntry: widget.containerEntry,
    );

    customPaint = CustomPaint(painter: painter);

    if (mounted) {
      setState(() {
        isBusy = false;
      });
    }
  }

  ///Configures the ImageProcessor(s) so they can receive ImageBytes.
  void configureIPs(InputImage inputImage) {
    if (imageProcessor1 != null && imageProcessor2 != null) {
      //Abosulte Image Size.
      Size absoluteSize = inputImage.inputImageData!.size;
      //Canvas Size.

      Size canvasSize = Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top);

      //InputImageFormat
      InputImageFormat inputImageFormat =
          inputImage.inputImageData!.inputImageFormat;

      ImageProcessorConfig config = ImageProcessorConfig(
        absoluteSize: absoluteSize,
        canvasSize: canvasSize,
        inputImageFormat: inputImageFormat,
      );

      imageProcessor1!.send(config.toMessage());
      imageProcessor2!.send(config.toMessage());

      setState(() {
        hasConfiguredIPs = true;
      });
    }
  }

  ///Sends ImageData to the ImageProcessor(s)
  void sendImageDataMessage(InputImage inputImage) {
    ImageMessage imageDataMessage = ImageMessage(
      bytes: inputImage.bytes!,
      accelerometerData: AccelerometerData(
        accelerometerEvent: accelerometerEvent,
        userAccelerometerEvent: userAccelerometerEvent,
      ),
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    //Send Data.
    if (counter == 0) {
      imageProcessor1!.send(imageDataMessage.toMessage());
    } else if (counter == 2) {
      imageProcessor2!.send(imageDataMessage.toMessage());
    }

    counter++;
    if (mounted && counter == 4) {
      setState(() {
        counter = 0;
      });
    }
  }
}
