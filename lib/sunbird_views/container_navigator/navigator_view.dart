import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isolate/grid_isolate.dart';
import 'package:flutter_google_ml_kit/isolate/navigator_image_processing_isolate.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_grid_object.dart';
import 'package:flutter_google_ml_kit/objects/reworked/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_object.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/navigator_painter_isolate.dart';
import 'package:isar/isar.dart';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_camera_view.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:sensors_plus/sensors_plus.dart';

class NavigatorView extends StatefulWidget {
  const NavigatorView({
    Key? key,
    required this.containerEntry,
    this.customColor,
  }) : super(key: key);

  final Color? customColor;
  final ContainerEntry containerEntry;

  @override
  _NavigatorViewState createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
  bool isBusy = false;
  CustomPaint? customPaint;

  vm.Vector3 accelerometerEvent = vm.Vector3(0, 0, 0);
  vm.Vector3 userAccelerometerEvent = vm.Vector3(0, 0, 0);

  ReceivePort mainPortImage1 = ReceivePort(); // send stuff to ui thread
  ReceivePort mainPortImage2 = ReceivePort();
  ReceivePort mainPortGrid1 = ReceivePort();
  SendPort? isolatePortImage1; //send stuff to isolate
  SendPort? isolatePortImage2; //send stuff to isolate
  SendPort? isolatePorGrid1;

  bool hasSentConfigIsolate1 = false;
  bool hasSentConfigIsolate2 = false;

  bool hasConfiguredIsolate1 = false;
  bool hasConfiguredIsolate2 = false;

  bool x = false;

  int counter1 = 0;

  List<dynamic> barcodeDataBatches = [];
  List<GridObject> knownGrids = [];
  List<IsolateGridObject> isolateGrids = [];
  List<BarcodeProperty> storedBarcodeProperties = [];

  @override
  void initState() {
    //Listen to accelerometer events.
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });

    //Build all known Grids.
    List<ContainerType> containerTypes = isarDatabase!.containerTypes
        .filter()
        .markerToChilrenEqualTo(true)
        .findAllSync();

    List<ContainerEntry> originContainers = isarDatabase!.containerEntrys
        .filter()
        .repeat(
            containerTypes,
            (q, ContainerType element) =>
                q.containerTypeMatches(element.containerType))
        .findAllSync();

    for (ContainerEntry item in originContainers) {
      GridObject gridObject = GridObject(
        originContainer: item,
      );

      isolateGrids.add(IsolateGridObject(
        gridPositions: gridObject.grid,
        markers: gridObject.markers,
      ));
      knownGrids.add(gridObject);
    }

    storedBarcodeProperties
        .addAll(isarDatabase!.barcodePropertys.where().findAllSync());

    initIsolate();

    super.initState();
  }

  void initIsolate() async {
    //Spawn grid updater...
    await FlutterIsolate.spawn(gridIsolate, mainPortGrid1.sendPort);

    //Spawn Impage Processing Isolates
    await FlutterIsolate.spawn(
        navigatorImageProcessorIsolate, mainPortImage1.sendPort);
    await FlutterIsolate.spawn(
        navigatorImageProcessorIsolate, mainPortImage2.sendPort);

    //Port setup.
    mainPortImage1.listen((message) {
      if (message is SendPort) {
        isolatePortImage1 = message;
      } else if (message == 'configured') {
        setState(() {
          hasConfiguredIsolate1 = true;
        });
      } else {
        drawImage(message);
      }
    });

    //Port setup.
    mainPortImage2.listen((message) {
      if (message is SendPort) {
        isolatePortImage2 = message;
      } else if (message == 'configured') {
        setState(() {
          hasConfiguredIsolate2 = true;
        });
      } else {
        drawImage(message);
      }
    });

    mainPortGrid1.listen((message) {
      if (message is SendPort) {
        isolatePorGrid1 = message;
        log('Grid Isolate Port Set.');
        String grids = jsonEncode(isolateGrids);
        List config = [
          //Send isolate ports to Grid isolate.
          'config',
          grids,
          focalLength,
        ];
        isolatePorGrid1!.send(config);
      } else if (message is List) {
        log(message.toString());
      }
    });
  }

  @override
  void dispose() {
    FlutterIsolate.killAll();
    mainPortImage1.close();
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
          },
          child: const Icon(Icons.check_circle_outline_rounded),
        ),
        body: BarcodePositionScannerCameraView(
          color: widget.customColor ?? Colors.deepOrange,
          title: 'Position Scanner',
          customPaint: customPaint,
          onImage: (inputImage) {
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

              if (counter1 == 0) {
                isolatePortImage1!.send(myList);
              } else if (counter1 == 3) {
                isolatePortImage2!.send(myList);
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

      Map<String, double> barcodeProperties = {
        'default': defaultBarcodeDiagonalLength!
      };
      for (BarcodeProperty barcodeProperty in storedBarcodeProperties) {
        barcodeProperties.putIfAbsent(
            barcodeProperty.barcodeUID, () => barcodeProperty.size);
      }

      //Setup config List.
      List config = [
        'config', //[0]
        inputImage.inputImageData!.size.width, //[1]
        inputImage.inputImageData!.size.height, //[2]
        screenSize.width, //[3]
        screenSize.height, //[4]
        inputImage.inputImageData!.inputImageFormat.index, //[5]
        widget.containerEntry.barcodeUID, //[6]
        barcodeProperties, //[7]
      ];

      //Send to isolate 1.
      // && isolatePorGrid1 != null
      if (isolatePortImage1 != null) {
        isolatePortImage1!.send(config);

        if (isolatePorGrid1 != null) {
          isolatePortImage1!.send(isolatePorGrid1);
        }
        setState(() {
          hasSentConfigIsolate1 = true;
        });
      }
      // && isolatePorGrid1 != null
      if (isolatePortImage2 != null) {
        isolatePortImage2!.send(config);
        if (isolatePorGrid1 != null) {
          isolatePortImage2!.send(isolatePorGrid1);
        }

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

    final painter = NavigatorPainterIsolate(
      message: barcodeDataBatch,
      containerEntry: widget.containerEntry,
      knownGrids: knownGrids,
    );

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
