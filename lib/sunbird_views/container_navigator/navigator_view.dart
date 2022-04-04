import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcode_position_calulation/barcode_position_calculator.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/objects/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/barcode_navigation_painter.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/camera_view_barcode_navigator.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart' as vm;

class NavigatorView extends StatefulWidget {
  const NavigatorView({Key? key, required this.containerEntry})
      : super(key: key);
  final ContainerEntry containerEntry;

  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
  late Color color;
  late String barcodeUID;
  CustomPaint? customPaint;
  bool isBusy = false;
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  //Accelerometer initial values.
  vm.Vector3 accelerometerEvent = vm.Vector3(0, 0, 0);
  vm.Vector3 userAccelerometerEvent = vm.Vector3(0, 0, 0);

  List<RealBarcodePosition> containingGrid = [];
  bool hasParent = false;

  @override
  void initState() {
    color = getContainerColor(containerUID: widget.containerEntry.containerUID);
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = vm.Vector3(event.x, event.y, event.z);
    });

    String? parentContainer = isarDatabase!.containerRelationships
        .filter()
        .containerUIDMatches(widget.containerEntry.containerUID)
        .findFirstSync()
        ?.parentUID;

    if (parentContainer != null) {
      hasParent = true;
      containingGrid =
          calculateRealBarcodePositions(parentUID: parentContainer);
      log(containingGrid.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ContainerView(containerEntry: widget.containerEntry),
            ),
          );
        },
        child: const Icon(Icons.done),
      ),
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          widget.containerEntry.containerUID,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: CameraBarcodeNavigationView(
        title: 'Barcode Finder',
        customPaint: customPaint,
        onImage: (inputImage) {
          processImage(inputImage);
        },
      ),
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    //Calculate phone angle.
    vm.Vector3 gravityDirection3D = accelerometerEvent - userAccelerometerEvent;
    double angleRadians = calculatePhoneAngle(gravityDirection3D);

    //Get on screen barcodes.
    List<Barcode> barcodes = await barcodeScanner.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      //Custom Painter.
      customPaint = CustomPaint(
        painter: BarcodeDetectorPainterNavigation(
            barcodes: barcodes,
            absoluteImageSize: inputImage.inputImageData!.size,
            rotation: inputImage.inputImageData!.imageRotation,
            selectedBarcodeID: widget.containerEntry.barcodeUID!,
            phoneAngle: angleRadians,
            containingGrid: containingGrid),
      );
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

double calculatePhoneAngle(vm.Vector3 gravityDirection3D) {
  //Convert to 2D plane X-Y
  vm.Vector2 gravityDirection2D =
      vm.Vector2(gravityDirection3D.x, gravityDirection3D.y);
  vm.Vector2 zero = vm.Vector2(0, 1);
  double angleRadians = gravityDirection2D.angleTo(zero);
  if (gravityDirection2D.x >= 0) {
    angleRadians = -angleRadians;
  }
  return angleRadians;
}

///This stores the AccelerometerEvent and UserAccelerometerEvent at an instant.
AccelerometerData getAccelerometerData(
    vm.Vector3 accelerometerEvent, vm.Vector3 userAccelerometerEvent) {
  return AccelerometerData(
      accelerometerEvent: accelerometerEvent,
      userAccelerometerEvent: userAccelerometerEvent);
}

//Check if the list contains a given string.
bool checkIfChecksOutContains(List<String> checksOut, String barcodeID) {
  if (checksOut.contains(barcodeID)) {
    return true;
  } else {
    return false;
  }
}

///Checks if the interBarcodeOffset is within a margin of error from the storedInterBarcodeOffset
bool checkIfInterbarcodeOffsetIsWithinError(
    RealInterBarcodeOffset averagedRealInterBarcodeOffset,
    Offset storedInterbarcodeOffset) {
//This is to calculate the amount of positional error we allow for in mm.
  double errorValue = 20; // max error value in mm
  double currentX = averagedRealInterBarcodeOffset.offset.dx;
  double currentXLowerBoundry = currentX - (errorValue);
  double currentXUpperBoundry = currentX + (errorValue);

  double currentY = averagedRealInterBarcodeOffset.offset.dy;
  double currentYLowerBoundry = currentY - (errorValue);
  double currentYUpperBoundry = currentY + (errorValue);

  double storedX = storedInterbarcodeOffset.dx;
  double storedY = storedInterbarcodeOffset.dy;

  if (storedX <= currentXUpperBoundry &&
      storedX >= currentXLowerBoundry &&
      storedY <= currentYUpperBoundry &&
      storedY >= currentYLowerBoundry) {
    return true;
  } else {
    return false;
  }
}
