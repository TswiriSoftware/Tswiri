import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isolate/grid_processor.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';
import 'package:flutter_google_ml_kit/objects/reworked/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/barcode_position_scanner/position_camera_view.dart';
import 'package:flutter_google_ml_kit/isolate/image_processor.dart';
import 'package:flutter_google_ml_kit/objects/navigation/image_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/image_processor_config.dart';
import 'package:flutter_google_ml_kit/sunbird_views/containers/container_view/container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/containers/container_navigator/navigator_painter.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/default_card/defualt_card.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:isolate';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';

//ImageProcessor Counter.
int counter = 0;

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
  ReceivePort uiPort1 = ReceivePort('uiPort1'); //ImageProcessor
  ReceivePort uiPort2 = ReceivePort('uiPort2'); //ImageProcessor
  ReceivePort uiPort3 = ReceivePort('uiPort3'); //GridProcessor

  //Isolate-Ports
  SendPort? imageProcessor1;
  SendPort? imageProcessor2;
  SendPort? gridProcessor1;

  bool hasConfiguredIPs = false;

  //Accelerometer Data
  vm.Vector3 accelerometerEvent = vm.Vector3(0, 0, 0);
  vm.Vector3 userAccelerometerEvent = vm.Vector3(0, 0, 0);

  //Painter
  bool isBusy = false;

  //Dialogs
  bool showingDialog = false;

  //Coordinate Updates
  //List<Coordinate> updatedCoordinates = [];

  @override
  void initState() {
    //Spawn Impage processors.
    initiateIsolates();
    counter = 0;

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
    //FlutterIsolate.killAll();
    FlutterIsolate.spawn(
      imageProcessor,
      [
        1, //[0] ID
        uiPort1.sendPort, //[1] SendPort
        isarDirectory!.path, //[2] Isar Directory
        focalLength, //[3] focalLength
        selectedContainer.barcodeUID, //[4] selectedContainer BarcodeUID
        defaultBarcodeDiagonalLength ?? 100, //[5]  Default Barcode Size.
      ],
    );

    FlutterIsolate.spawn(
      imageProcessor,
      [
        2, //[0] ID
        uiPort2.sendPort, //[1] SendPort
        isarDirectory!.path, //[2] Isar Directory
        focalLength, //[3] focalLength
        selectedContainer.barcodeUID, //[4] selectedContainer BarcodeUID
        defaultBarcodeDiagonalLength ?? 100, //[5]  Default Barcode Size.
      ],
    );

    FlutterIsolate.spawn(
      gridProcessor,
      [
        uiPort3.sendPort,
        isarDirectory!.path,
        focalLength,
        defaultBarcodeDiagonalLength ?? 70
      ],
    );

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

    uiPort3.listen((message) {
      if (message[0] == 'Sendport') {
        gridProcessor1 = message[1];
        log('UI: GridProcessor1 Port Set');
      } else if (message[0] == 'Update') {
        //Coordinate coordinate = Coordinate.fromJson(jsonDecode(message[1]));
        // updatedCoordinates.add(coordinate);
        // imageProcessor1!.send(message);
        // imageProcessor2!.send(message);

        //TODO: Update InterBarcodeVectors in database...
      }
    });
  }

  void errorHandler(message) {
    switch (message[1]) {
      case 'nogrid':
        showNoGridDialog(context);

        break;
      case 'NoPath':
        initiateDialog(
          'No Path',
          'Cannot find a path to selected barcode.',
        );
        break;
      case 'Path':
        treeNavigator('Navigator', message[3], message[2]);
        break;
      default:
    }
  }

  @override
  void dispose() {
    FlutterIsolate.killAll();
    averageOffsetToBarcode = null;
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
        RepaintBoundary(
          child: PositionCameraView(
            title: 'Position Scanner',
            color: color,
            customPaint: customPaint,
            onImage: (inputImage) {
              if (hasConfiguredIPs == false) {
                configureImageProcessors(inputImage);
              } else {
                sendImageDataMessage(inputImage);
              }
            },
          ),
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

  Visibility _floatingActionButton() {
    return Visibility(
      visible: imageProcessor1 != null && imageProcessor2 != null,
      child: FloatingActionButton(
        backgroundColor: color,
        heroTag: null,
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ContainerView(containerEntry: selectedContainer),
            ),
          );
        },
        child: const Icon(Icons.check_circle_outline_rounded),
      ),
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
    if (imageProcessor1 != null &&
        imageProcessor2 != null &&
        gridProcessor1 != null) {
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
        gridProcessor: gridProcessor1!,
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
                Text(
                  message,
                  style: const TextStyle(fontSize: 15),
                ),
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

  void treeNavigator(String title, List<String> selectedBarcodeTree,
      List<String> currentBarcodeTree) async {
    if (showingDialog == false) {
      setState(() {
        showingDialog = true;
      });
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (initialDialogContext) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(20),
            contentPadding: const EdgeInsets.all(5),
            title: Text(title),
            content: Builder(builder: (context) {
              ContainerEntry? currentContainer = isarDatabase!.containerEntrys
                  .filter()
                  .containerUIDMatches(currentBarcodeTree[0])
                  .findFirstSync();

              ContainerEntry? selectedContainer = isarDatabase!.containerEntrys
                  .filter()
                  .containerUIDMatches(selectedBarcodeTree[0])
                  .findFirstSync();

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        defaultCard(
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('You are here:'),
                                Text(
                                  'UID',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                    currentContainer?.containerUID ?? 'unkown'),
                                Text(
                                  'name',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(currentContainer?.name ?? 'no name'),
                              ],
                            ),
                            borderColor: color),
                        defaultCard(
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('You want to go here:'),
                                Text(
                                  'UID',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(selectedContainer?.containerUID ??
                                    'unkown'),
                                Text(
                                  'name',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(selectedContainer?.name ?? 'no name'),
                              ],
                            ),
                            borderColor: color),
                      ],
                    ),
                    Row(
                      children: [
                        defaultCard(
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Path'),
                                for (String x in currentBarcodeTree) Text(x)
                              ],
                            ),
                            borderColor: color),
                        defaultCard(
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Path'),
                                for (String x in selectedBarcodeTree) Text(x)
                              ],
                            ),
                            borderColor: color),
                      ],
                    ),
                  ],
                ),
              );
            }),
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
