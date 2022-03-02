import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeNavigation/cameraView/camera_view_barcode_navigator.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeNavigation/painter/barcode_navigation_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart';
import '../../databaseAdapters/allBarcodes/barcode_entry.dart';
import '../../databaseAdapters/calibrationAdapters/distance_from_camera_lookup_entry.dart';
import '../../databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import '../../functions/barcodeCalculations/type_offset_converters.dart';
import '../../functions/dataProccessing/barcode_scanner_data_processing_functions.dart';
import '../../globalValues/global_hive_databases.dart';
import '../../objects/accelerometer_data.dart';
import '../../objects/raw_on_image_barcode_data.dart';
import '../../objects/raw_on_image_inter_barcode_data.dart';
import '../../objects/real_inter_barcode_offset.dart';

class BarcodeCameraNavigatorView extends StatefulWidget {
  final String qrcodeID;
  const BarcodeCameraNavigatorView({Key? key, required this.qrcodeID})
      : super(key: key);

  @override
  _BarcodeCameraNavigatorViewState createState() =>
      _BarcodeCameraNavigatorViewState();
}

class _BarcodeCameraNavigatorViewState
    extends State<BarcodeCameraNavigatorView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;

  //List of offsets that are not within error aka. barcode have changed location.
  List<RealInterBarcodeOffset> offsetsThatDoNotCheckOut = [];
  List<RealInterBarcodeOffset> offsetsThatDoCheckOut = [];

  // //List of Barcodes that have not moved.
  // Set<RealBarcodePosition> realBarcodePositions = {};

  List<String> checksOut = [];
  List<String> doesNotcheckOut = [];

  ///Map<String, List<RealInterBarcodeOffset>> : String is the startBarcodeUID_endBarcodeUID and then a list of RealInterBarcodeOffsets.
  Map<String, List<RealInterBarcodeOffset>> realInterBarcodeOffsetMap = {};

  Vector3 accelerometerEvent = Vector3(0, 0, 0);
  Vector3 userAccelerometerEvent = Vector3(0, 0, 0);

  List<RealBarcodePostionEntry> realBarcodePositions = [];
  List<DistanceFromCameraLookupEntry> calibrationLookupTable = [];
  List<BarcodeDataEntry> allBarcodes = [];

  @override
  void initState() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = Vector3(event.x, event.y, event.z);
    });
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      userAccelerometerEvent = Vector3(event.x, event.y, event.z);
    });

    super.initState();
  }

  @override
  void dispose() {
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraBarcodeNavigationView(
      color: limeGreenMuted,
      title: 'Barcode Finder',
      customPaint: customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    if (realBarcodePositions.isEmpty ||
        calibrationLookupTable.isEmpty ||
        allBarcodes.isEmpty) {
      //Ensures data is fetched only once.
      realBarcodePositions = await getRealBarcodePositions();
      calibrationLookupTable = await getMatchedCalibrationData();
      allBarcodes = await getAllExistingBarcodes();
      log('Fetching data');
    }

    final barcodes = await barcodeScanner.processImage(inputImage);

    Vector3 gravityDirection3D = accelerometerEvent - userAccelerometerEvent;
    double angleRadians = calculatePhoneAngle(gravityDirection3D);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeDetectorPainterNavigation(
          barcodes: barcodes,
          absoluteImageSize: inputImage.inputImageData!.size,
          rotation: inputImage.inputImageData!.imageRotation,
          realBarcodePositions: realBarcodePositions,
          selectedBarcodeID: widget.qrcodeID,
          distanceFromCameraLookup: calibrationLookupTable,
          allBarcodes: allBarcodes,
          phoneAngle: angleRadians);

      checkBarcodePositions(
          barcodes: barcodes,
          realBarcodePositions: realBarcodePositions,
          allBarcodes: allBarcodes);

      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  ///Checks if any barcodes have moved.
  void checkBarcodePositions(
      {required List<Barcode> barcodes,
      required List<RealBarcodePostionEntry> realBarcodePositions,
      required List<BarcodeDataEntry> allBarcodes}) {
    if (barcodes.length >= 2) {
      //Checks that there are more than 2 barcodes in list.

      //1. Get all the onImageBarcodeData from the current Istance.
      //OnImageBarcodeData in this istance.
      List<RawOnImageBarcodeData> allRawOnImageBarcodeData = [
        RawOnImageBarcodeData(
            barcodes: barcodes,
            timestamp: DateTime.now().millisecondsSinceEpoch,
            accelerometerData: getAccelerometerData(
                accelerometerEvent, userAccelerometerEvent))
      ];

      //2. Build the onImageInterBarcodeData.
      // This list contains all onImageInterBarcodeData from the image instant.
      List<RawOnImageInterBarcodeData> allOnImageInterBarcodeData =
          buildAllOnImageInterBarcodeData(allRawOnImageBarcodeData);

      //3. Build the realInterBarcodeOffsets.
      // Builds and adds all the real realInterBarcodeOffsets in this instance.
      List<RealInterBarcodeOffset> allRealInterBarcodeOffsets =
          buildAllRealInterBarcodeOffsets(
              allOnImageInterBarcodeData: allOnImageInterBarcodeData,
              calibrationLookupTable: calibrationLookupTable,
              allBarcodes: allBarcodes);

      //Add the RealInterBarcodeOffset to the map
      for (RealInterBarcodeOffset realInterBarcodeOffset
          in allRealInterBarcodeOffsets) {
        //This adds data to the map.
        String uid = realInterBarcodeOffset.uid;
        if (realInterBarcodeOffsetMap.containsKey(realInterBarcodeOffset.uid)) {
          //If the map already contains the barcodeID then add the RealInterBarcodeOffset to the list in the map.
          List<RealInterBarcodeOffset> temp = realInterBarcodeOffsetMap[uid]!;
          temp.add(realInterBarcodeOffset);
          realInterBarcodeOffsetMap.update(uid, (value) => temp);
        } else {
          //Create an entry for this barcodeID
          realInterBarcodeOffsetMap.putIfAbsent(
              uid, () => [realInterBarcodeOffset]);
        }

        //The amount of interBarcodeOffsets required before we check if a barcode has moved.
        int x = 5;
        if (realInterBarcodeOffsetMap[uid]!.length >= x) {
          //When there are more than X similar RealInterBarcodeOffsets it will calculate the average of the realInterBarocdeOffsets.
          List<RealInterBarcodeOffset> realInterBarcodeOffsets =
              realInterBarcodeOffsetMap[uid]!;

          List<RealInterBarcodeOffset> averagedRealInterBarcodeOffset =
              processRealInterBarcodeData(
                  uniqueRealInterBarcodeOffsets: realInterBarcodeOffsets
                      .toSet()
                      .toList(), //This will return the unique realInterBarcode Offset.
                  listOfRealInterBarcodeOffsets: realInterBarcodeOffsets);

          //Retrive stored StartBarcodePosition
          RealBarcodePostionEntry startBarcodePosition =
              realBarcodePositions.firstWhere(
                  (element) => element.uid == realInterBarcodeOffset.uidStart);
          //Retrive stored EndBarcodePosition
          RealBarcodePostionEntry endBarcodePosition =
              realBarcodePositions.firstWhere(
                  (element) => element.uid == realInterBarcodeOffset.uidEnd);
          //Calculate the stored RealInterBarcodePosition.
          Offset storedInterbarcodeOffset =
              typeOffsetToOffset(endBarcodePosition.offset) -
                  typeOffsetToOffset(startBarcodePosition.offset);

          //This is to calculate the amount of positional error we allow for in mm.
          double errorValue = 20; // max error value in mm
          double currentX = averagedRealInterBarcodeOffset[0].offset.dx;
          double currentXLowerBoundry = currentX - (errorValue);
          double currentXUpperBoundry = currentX + (errorValue);

          double currentY = averagedRealInterBarcodeOffset[0].offset.dy;
          double currentYLowerBoundry = currentY - (errorValue);
          double currentYUpperBoundry = currentY + (errorValue);

          double storedX = storedInterbarcodeOffset.dx;
          double storedY = storedInterbarcodeOffset.dy;

          //This checks if the current positions falls within reasonable error from the stored position.
          //If it does then mark its checksOut value as true.
          //If not mark its checksOut value as false.
          if (storedX <= currentXUpperBoundry &&
              storedX >= currentXLowerBoundry &&
              storedY <= currentYUpperBoundry &&
              storedY >= currentYLowerBoundry) {
            offsetsThatDoCheckOut.add(realInterBarcodeOffset);
            checksOut.addAll([
              realInterBarcodeOffset.uidStart,
              realInterBarcodeOffset.uidEnd
            ]);
          } else {
            offsetsThatDoNotCheckOut.add(realInterBarcodeOffset);
            doesNotcheckOut.addAll([
              realInterBarcodeOffset.uidStart,
              realInterBarcodeOffset.uidEnd
            ]);

            Set<String> validStartBarcodes = checksOut
                .where((element) => !doesNotcheckOut.contains(element))
                .toSet();

            String movedBarcodeID = doesNotcheckOut
                .firstWhere((element) => !checksOut.contains(element))
                .toString();

            int indexOfUseableInterBarcodeOffset =
                offsetsThatDoNotCheckOut.indexWhere((element) =>
                    !validStartBarcodes.contains(element.uidStart) ||
                    !validStartBarcodes.contains(element.uidEnd));

            if (indexOfUseableInterBarcodeOffset != -1) {
              RealInterBarcodeOffset validInterBarcodeOffset =
                  offsetsThatDoNotCheckOut[indexOfUseableInterBarcodeOffset];

              if (validInterBarcodeOffset.uidEnd == movedBarcodeID) {
                //log('dont flip: ' + validInterBarcodeOffset.toString());

                RealBarcodePostionEntry x = realBarcodePositions.firstWhere(
                    (element) =>
                        element.uid == validInterBarcodeOffset.uidStart);
                Offset newPosition = typeOffsetToOffset(x.offset) +
                    validInterBarcodeOffset.offset;

                log(newPosition.toString());

                //TODO: Write to Database.
              } else {
                //log('flip: ' + validInterBarcodeOffset.toString());
                RealBarcodePostionEntry x = realBarcodePositions.firstWhere(
                    (element) => element.uid == validInterBarcodeOffset.uidEnd);

                Offset newPosition = typeOffsetToOffset(x.offset) -
                    validInterBarcodeOffset.offset;
                //TODO: Write to Database.
                //TODO: Remove from doesNotCheckOut
                log(x.uid);
                log(newPosition.toString());
              }
            }
          }
        }

        //TODO: Code to update barcode Positions.
        //1. Find offset that has the start barcode in checksOut and end barcode in doesNotCheckOut.
        //2. Update realPosition
      }
    }
  }
}

double calculatePhoneAngle(Vector3 gravityDirection3D) {
  //Convert to 2D plane X-Y
  Vector2 gravityDirection2D =
      Vector2(gravityDirection3D.x, gravityDirection3D.y);
  Vector2 zero = Vector2(0, 1);
  double angleRadians = gravityDirection2D.angleTo(zero);
  if (gravityDirection2D.x >= 0) {
    angleRadians = -angleRadians;
  }
  return angleRadians;
}

Future<List<RealBarcodePostionEntry>> getRealBarcodePositions() async {
//Open realBarcodePositionBox
  Box<RealBarcodePostionEntry> realBarcodePositionDataBox =
      await Hive.openBox(realPositionsBoxName);
  List<RealBarcodePostionEntry> realBarcodePositions =
      realBarcodePositionDataBox.values.toList();
  return realBarcodePositions;
}

///This stores the AccelerometerEvent and UserAccelerometerEvent at an instant.
AccelerometerData getAccelerometerData(
    Vector3 accelerometerEvent, Vector3 userAccelerometerEvent) {
  return AccelerometerData(
      accelerometerEvent: accelerometerEvent,
      userAccelerometerEvent: userAccelerometerEvent);
}
