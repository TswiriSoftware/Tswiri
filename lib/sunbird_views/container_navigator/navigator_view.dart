import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcode_position_calulation/barcode_position_calculator.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/objects/reworked/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/display/real_barcode_position.dart';
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

  List<RawOnImageBarcodeData> allRawOnImageBarcodeData = [];

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
    } else {
      containingGrid = calculateRealBarcodePositions(
          parentUID: widget.containerEntry.containerUID);
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          barcodeScanner.close();

          // await Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CheckInterBarcodeData(
          //       allRawOnImageBarcodeData: allRawOnImageBarcodeData,
          //       containerEntry: widget.containerEntry,
          //     ),
          //   ),
          // );

          Navigator.pop(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContainerView(
                containerEntry: widget.containerEntry,
              ),
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

  ///This stores the AccelerometerEvent and UserAccelerometerEvent at an instant.
  AccelerometerData getAccelerometerData() {
    return AccelerometerData(
        accelerometerEvent: accelerometerEvent,
        userAccelerometerEvent: userAccelerometerEvent);
  }
}

// void checkBarcodePositions({
//     required List<Barcode> barcodes,
//     required List<RealBarcodePositionEntry> realBarcodePositions,
//     required List<BarcodeDataEntry> allBarcodes,
//     required double focalLength,
//   }) {
//     if (barcodes.length >= 2) {
//       //Checks that there are more than 2 barcodes in list.

//       //1. Get all the onImageBarcodeData from the current Istance.
//       //OnImageBarcodeData in this istance.
//       List<RawOnImageBarcodeData> allRawOnImageBarcodeData = [
//         RawOnImageBarcodeData(
//             barcodes: barcodes,
//             timestamp: DateTime.now().millisecondsSinceEpoch,
//             accelerometerData: getAccelerometerData(
//                 accelerometerEvent, userAccelerometerEvent))
//       ];

//       //2. Build the onImageInterBarcodeData.
//       // This list contains all onImageInterBarcodeData from the image instant.
//       List<RawOnImageInterBarcodeData> allOnImageInterBarcodeData =
//           buildAllOnImageInterBarcodeData(allRawOnImageBarcodeData);

//       //3. Build the realInterBarcodeOffsets.
//       // Builds and adds all the real realInterBarcodeOffsets in this instance.
//       //Get the camera's focal length

//       List<RealInterBarcodeOffset> allRealInterBarcodeOffsets =
//           buildAllRealInterBarcodeOffsets(
//         allOnImageInterBarcodeData: allOnImageInterBarcodeData,
//         calibrationLookupTable: calibrationLookupTable,
//         allBarcodes: allBarcodes,
//         focalLength: focalLength,
//       );

//       //Add the RealInterBarcodeOffset to the map
//       for (RealInterBarcodeOffset realInterBarcodeOffset
//           in allRealInterBarcodeOffsets) {
//         //This adds data to the map.
//         String uid = realInterBarcodeOffset.uid;
//         if (realInterBarcodeOffsetMap.containsKey(realInterBarcodeOffset.uid)) {
//           //If the map already contains the barcodeID then add the RealInterBarcodeOffset to the list in the map.
//           List<RealInterBarcodeOffset> temp = realInterBarcodeOffsetMap[uid]!;
//           temp.add(realInterBarcodeOffset);
//           realInterBarcodeOffsetMap.update(uid, (value) => temp);
//         } else {
//           //Create an entry for this barcodeID
//           realInterBarcodeOffsetMap.putIfAbsent(
//               uid, () => [realInterBarcodeOffset]);
//         }

//         //The amount of interBarcodeOffsets required before we check if a barcode has moved.
//         int x = 5;
//         if (realInterBarcodeOffsetMap[uid]!.length >= x) {
//           //When there are more than X similar RealInterBarcodeOffsets it will calculate the average of the realInterBarocdeOffsets.
//           List<RealInterBarcodeOffset> realInterBarcodeOffsets =
//               realInterBarcodeOffsetMap[uid]!;

//           //Calculate the average from the list of RealInterBarcodeOffsets.
//           List<RealInterBarcodeOffset> averagedRealInterBarcodeOffset =
//               processRealInterBarcodeData(
//                   uniqueRealInterBarcodeOffsets: realInterBarcodeOffsets
//                       .toSet()
//                       .toList(), //This will return the unique realInterBarcode Offset.
//                   listOfRealInterBarcodeOffsets: realInterBarcodeOffsets);

//           //Retrive stored StartBarcodePosition.
//           RealBarcodePositionEntry startBarcodePosition =
//               realBarcodePositions.firstWhere(
//                   (element) => element.uid == realInterBarcodeOffset.uidStart);

//           //Retrive stored EndBarcodePosition.
//           RealBarcodePositionEntry endBarcodePosition =
//               realBarcodePositions.firstWhere(
//                   (element) => element.uid == realInterBarcodeOffset.uidEnd);

//           //Calculate the stored RealInterBarcodePosition.
//           Offset storedInterbarcodeOffset =
//               typeOffsetToOffset(endBarcodePosition.offset) -
//                   typeOffsetToOffset(startBarcodePosition.offset);

//           if (checkIfInterbarcodeOffsetIsWithinError(
//               averagedRealInterBarcodeOffset[0], storedInterbarcodeOffset)) {
//             //If the barcodes are where they should be.
//             checksOut.addAll([
//               averagedRealInterBarcodeOffset[0].uidStart,
//               averagedRealInterBarcodeOffset[0].uidEnd
//             ]);
//           } else {
//             //If the barcodes are not where they should be
//             if (checkIfChecksOutContains(
//                 checksOut, averagedRealInterBarcodeOffset[0].uidStart)) {
//               RealBarcodePositionEntry updatedBarcodePosition =
//                   RealBarcodePositionEntry(
//                       uid: averagedRealInterBarcodeOffset[0].uidEnd,
//                       offset: offsetToTypeOffset(
//                           typeOffsetToOffset(startBarcodePosition.offset) +
//                               averagedRealInterBarcodeOffset[0].offset),
//                       zOffset: startBarcodePosition.zOffset +
//                           averagedRealInterBarcodeOffset[0].zOffset,
//                       isMarker: false,
//                       shelfUID: 1,
//                       timestamp: averagedRealInterBarcodeOffset[0].timestamp);

//               //Remove all incorrect interBarcodeOffsets.
//               realInterBarcodeOffsetMap
//                   .remove(averagedRealInterBarcodeOffset[0].uid);
//               //Get the index of this BarcodePosition.
//               int index = realBarcodePositionsUpdated.indexWhere(
//                   (element) => element.uid == updatedBarcodePosition.uid);

//               if (index != -1) {
//                 //Remove the barcode from the List of BarcodePositions.
//                 realBarcodePositionsUpdated.removeAt(index);

//                 //Add the new updated position.
//                 realBarcodePositionsUpdated.add(updatedBarcodePosition);

//                 //Add the new Position to the list PositionsThatChanged. This will be writen to the database afterwards.
//                 positionsThatChanged.add(updatedBarcodePosition);

//                 // log('Position updated in realBarcodePositionsUpdated: ' +
//                 //     updatedBarcodePosition.toString());
//               }
//             } else {
//               RealBarcodePositionEntry updatedBarcodePosition =
//                   RealBarcodePositionEntry(
//                       uid: averagedRealInterBarcodeOffset[0].uidStart,
//                       offset: offsetToTypeOffset(
//                           typeOffsetToOffset(endBarcodePosition.offset) -
//                               averagedRealInterBarcodeOffset[0].offset),
//                       zOffset: endBarcodePosition.zOffset +
//                           averagedRealInterBarcodeOffset[0].zOffset,
//                       isMarker: false,
//                       shelfUID: 1,
//                       timestamp: averagedRealInterBarcodeOffset[0].timestamp);

//               //Remove all incorrect interBarcodeOffsets.
//               realInterBarcodeOffsetMap
//                   .remove(averagedRealInterBarcodeOffset[0].uid);

//               //Get the index of this BarcodePosition.
//               int index = realBarcodePositionsUpdated.indexWhere(
//                   (element) => element.uid == updatedBarcodePosition.uid);

//               if (index != -1) {
//                 //Remove the barcode from the List of BarcodePositions.
//                 realBarcodePositionsUpdated.removeAt(index);

//                 //Add the new updated position.
//                 realBarcodePositionsUpdated.add(updatedBarcodePosition);

//                 //Add the new Position to the list PositionsThatChanged. This will be writen to the database afterwards.
//                 positionsThatChanged.add(updatedBarcodePosition);

//                 // log('Position updated in realBarcodePositionsUpdated: ' +
//                 //     updatedBarcodePosition.toString());
//               }
//             }
//           }
//         }
//       }
//     }
//   }
// }

///Calculate the phone angle on the X-Y plane.
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

// ///This stores the AccelerometerEvent and UserAccelerometerEvent at an instant.
// AccelerometerData getAccelerometerData(
//     vm.Vector3 accelerometerEvent, vm.Vector3 userAccelerometerEvent) {
//   return AccelerometerData(
//       accelerometerEvent: accelerometerEvent,
//       userAccelerometerEvent: userAccelerometerEvent);
// }

// //Check if the list contains a given string.
// bool checkIfChecksOutContains(List<String> checksOut, String barcodeID) {
//   if (checksOut.contains(barcodeID)) {
//     return true;
//   } else {
//     return false;
//   }
// }

// ///Checks if the interBarcodeOffset is within a margin of error from the storedInterBarcodeOffset
// bool checkIfInterbarcodeOffsetIsWithinError(
//     RealInterBarcodeOffset averagedRealInterBarcodeOffset,
//     Offset storedInterbarcodeOffset) {
// //This is to calculate the amount of positional error we allow for in mm.
//   double errorValue = 20; // max error value in mm
//   double currentX = averagedRealInterBarcodeOffset.offset.dx;
//   double currentXLowerBoundry = currentX - (errorValue);
//   double currentXUpperBoundry = currentX + (errorValue);

//   double currentY = averagedRealInterBarcodeOffset.offset.dy;
//   double currentYLowerBoundry = currentY - (errorValue);
//   double currentYUpperBoundry = currentY + (errorValue);

//   double storedX = storedInterbarcodeOffset.dx;
//   double storedY = storedInterbarcodeOffset.dy;

//   if (storedX <= currentXUpperBoundry &&
//       storedX >= currentXLowerBoundry &&
//       storedY <= currentYUpperBoundry &&
//       storedY >= currentYLowerBoundry) {
//     return true;
//   } else {
//     return false;
//   }
// }
