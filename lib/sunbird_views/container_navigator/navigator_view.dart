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
  late ContainerEntry selectedContainer = widget.containerEntry;
  //Color
  late Color color =
      getContainerColor(containerUID: widget.containerEntry.containerUID);

  //Painter
  CustomPaint? customPaint;

  //UI-Ports (multiple-ports are snappier)
  ReceivePort uiPort1 = ReceivePort('uiPort1');
  ReceivePort uiPort2 = ReceivePort('uiPort2');

  //Isolate-Ports
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

  //Dialogs
  bool showingDialog = false;

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
      1, //[0] ID
      uiPort1.sendPort, //[1] SendPort
      isarDirectory!.path, //[2] Isar Directory
      focalLength, //[3] focalLength
      selectedContainer.barcodeUID, //[4] selectedContainer BarcodeUID
      defaultBarcodeDiagonalLength ?? 100, //[5]  Default Barcode Size.
    ]);

    FlutterIsolate.spawn(imageProcessor, [
      2, //[0] ID
      uiPort2.sendPort, //[1] SendPort
      isarDirectory!.path, //[2] Isar Directory
      focalLength, //[3] focalLength
      selectedContainer.barcodeUID, //[4] selectedContainer BarcodeUID
      defaultBarcodeDiagonalLength ?? 100, //[5]  Default Barcode Size.
    ]);

    uiPort1.listen((message) {
      if (message[0] == 'Sendport') {
        imageProcessor1 = message[1];
        log('UI: ImageProcessor1 Port Set');
      } else if (message[0] == 'painterMessage') {
        drawImage(message);
      } else if (message[0] == 'error') {
        errorHandler(message);
      }
    });

    uiPort2.listen((message) {
      if (message[0] == 'Sendport') {
        imageProcessor2 = message[1];
        log('UI: ImageProcessor2 Port Set');
      } else if (message[0] == 'painterMessage') {
        drawImage(message);
      } else if (message[0] == 'error') {
        errorHandler(message);
      }
    });
  }

  void errorHandler(message) {
    switch (message[1]) {
      case 'nogrid':
        showNoGridDialog(context);

        break;
      case 'unkownposition':
        initiateDialog(
          'Unkown Position',
          'This barcode does not appear in any grids.',
        );
        break;
      default:
    }
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
              configureImageProcessors(inputImage);
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
  void configureImageProcessors(InputImage inputImage) {
    if (imageProcessor1 != null && imageProcessor2 != null) {
      //1. Abosulte Image Size.
      Size absoluteSize = inputImage.inputImageData!.size;

      //2. Canvas Size.
      Size canvasSize = Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top);

      //3. InputImageFormat.
      InputImageFormat inputImageFormat =
          inputImage.inputImageData!.inputImageFormat;

      //4. Compile ImageProcessorConfig.
      ImageProcessorConfig config = ImageProcessorConfig(
        absoluteSize: absoluteSize,
        canvasSize: canvasSize,
        inputImageFormat: inputImageFormat,
      );

      //5. Send Config(s).
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
    } else if (counter == 3) {
      imageProcessor2!.send(imageDataMessage.toMessage());
    }

    counter++;
    if (mounted && counter == 6) {
      setState(() {
        counter = 0;
      });
    }
  }

  void showNoGridDialog(BuildContext context) {
    //No Grid Error
    if (showingDialog == false) {
      setState(() {
        showingDialog = true;
      });
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (initialDialogContext) {
          return AlertDialog(
            title: const Text('Error'),
            content: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: const [
                Text(
                    "This container has not been scanned previously and it's location is unkown."),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(initialDialogContext);
                  Navigator.pop(context);
                },
                child: const Text('close'),
              ),
            ],
          );
        },
      );
    }
  }

  void initiateDialog(String title, String message) async {
    if (showingDialog == false) {
      setState(() {
        showingDialog = true;
      });
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (initialDialogContext) {
          return AlertDialog(
            title: Text(title),
            content: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Text(message),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(initialDialogContext);
                },
                child: const Text('close'),
              ),
            ],
          );
        },
      );
      setState(() {
        showingDialog = false;
      });
    }
  }
}
