import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_data_entry.dart';

import 'package:flutter_google_ml_kit/functions/barcodeCalculations/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

import '../../databaseAdapters/calibrationAdapter/distance_from_camera_lookup_entry.dart';
import '../../databaseAdapters/scanningAdapter/real_barcode_position_entry.dart';
import '../../sunbirdViews/app_settings/app_settings.dart';

///Calculates the average interBarcodeOffset.
/// i. Takes into account for offset direction.
void calculateAverageOffsets(RealInterBarcodeOffset similarInterBarcodeOffset,
    RealInterBarcodeOffset realInterBacrodeOffset) {
  if (checkIfDirectionIsSame(
      similarInterBarcodeOffset, realInterBacrodeOffset)) {
    realInterBacrodeOffset.offset = calculateAverageOffset(
        realInterBacrodeOffset.offset, similarInterBarcodeOffset.offset);
  } else if (checkIfDirectionIsInverse(
      similarInterBarcodeOffset, realInterBacrodeOffset)) {
    realInterBacrodeOffset.offset = calculateAverageOffset(
        realInterBacrodeOffset.offset, (-similarInterBarcodeOffset.offset));
  }
}

///Takes 2 Offsets and calculates the average of the 2.
Offset calculateAverageOffset(
    Offset realInterBacrodeOffset, Offset similarInterBarcodeOffset) {
  return (realInterBacrodeOffset + similarInterBarcodeOffset) / 2;
}

///Checks if the start and end barcodeID's are inverted.
bool checkIfDirectionIsInverse(RealInterBarcodeOffset similarInterBarcodeOffset,
    RealInterBarcodeOffset realInterBacrodeOffset) {
  return similarInterBarcodeOffset.uidEnd == realInterBacrodeOffset.uidStart &&
      similarInterBarcodeOffset.uidStart == realInterBacrodeOffset.uidEnd;
}

///Checks if the start and end barcodeID's are the same.
bool checkIfDirectionIsSame(RealInterBarcodeOffset similarInterBarcodeOffset,
    RealInterBarcodeOffset realInterBacrodeOffset) {
  return similarInterBarcodeOffset.uidStart ==
          realInterBacrodeOffset.uidStart &&
      similarInterBarcodeOffset.uidEnd == realInterBacrodeOffset.uidEnd;
}

///This returns a list containing similar interBarcodeOffsets to the given interBarcodeOffset.
List<RealInterBarcodeOffset> findSimilarInterBarcodeOffsets(
    List<RealInterBarcodeOffset> allRealInterBarcodeOffsets,
    RealInterBarcodeOffset realInterBacrodeOffset) {
  return allRealInterBarcodeOffsets
      .where((element) =>
          (element.uidStart == realInterBacrodeOffset.uidStart &&
              element.uidEnd == realInterBacrodeOffset.uidEnd) ||
          (element.uidEnd == realInterBacrodeOffset.uidStart &&
              element.uidStart == realInterBacrodeOffset.uidEnd))
      .toList();
}

///Writes all valid barcode positions to the Hive database.
void writeValidBarcodePositionsToDatabase(
    RealBarcodePosition realBarcodePosition,
    Box<RealBarcodePositionEntry> realPositionalData,
    int shelfUID) {
  if (realBarcodePosition.offset != null) {
    //Creates an entry for each realBarcodePosition
    realPositionalData.put(
        realBarcodePosition.uid,
        RealBarcodePositionEntry(
            uid: realBarcodePosition.uid,
            offset: offsetToTypeOffset(realBarcodePosition.offset!),
            zOffset: realBarcodePosition.zOffset ?? 0,
            isMarker: false, //realBarcodePosition.isMarker,
            shelfUID: shelfUID,
            timestamp: realBarcodePosition.timestamp!));
  }
}

//Checks if the index is valid.
bool indexIsValid(int index) => index != -1;

///Finds the interBarcodeOffset which contains the start Barcode
int findInterBarcodeOffset(
    List<RealInterBarcodeOffset> relevantInterBarcodeOffsets,
    RealBarcodePosition startBarcode,
    RealBarcodePosition endBarcodeRealPosition) {
  return relevantInterBarcodeOffsets.indexWhere((element) {
    if ((startBarcode.uid == element.uidStart &&
            endBarcodeRealPosition.uid == element.uidEnd) ||
        (startBarcode.uid == element.uidEnd &&
            endBarcodeRealPosition.uid == element.uidStart)) {
      return true;
    }
    return false;
  });
}

///Find a relevant the start barcode
int findStartBarcodeIndex(List<RealBarcodePosition> barcodesWithOffset,
    List<RealInterBarcodeOffset> relevantInterBarcodeOffsets) {
  return barcodesWithOffset.indexWhere((barcodeWithOffsetToOrigin) {
    for (RealInterBarcodeOffset singleInterBarcodeData
        in relevantInterBarcodeOffsets) {
      if (singleInterBarcodeData.uidStart == barcodeWithOffsetToOrigin.uid ||
          singleInterBarcodeData.uidEnd == barcodeWithOffsetToOrigin.uid) {
        return true;
      }
    }
    return false;
  });
}

///Finds all barcodes with a offset (to the origin).
List<RealBarcodePosition> getBarcodesWithOffset(
    List<RealBarcodePosition> realBarcodePositions) {
  return realBarcodePositions
      .where((realBarcodePosition) => realBarcodePosition.offset != null)
      .toList();
}

///Finds all interbarcodeOffsets relevant to the endBarcodeRealPosition
List<RealInterBarcodeOffset> getRelevantInterBarcodeOffsets(
    List<RealInterBarcodeOffset> realInterBarcodeOffsets,
    RealBarcodePosition endBarcodeRealPosition) {
  return realInterBarcodeOffsets
      .where((interBarcodeData) =>
          (interBarcodeData.uidStart == endBarcodeRealPosition.uid) ||
          (interBarcodeData.uidEnd == endBarcodeRealPosition.uid))
      .toList();
}

///Creates a list of all scanned barcodes , but with null positions , they still need to be populated.
List<RealBarcodePosition> extractListOfScannedBarcodes(
  List<RealInterBarcodeOffset> allRealInterBarcodeData,
  List<BarcodeDataEntry> allBarcodes,
) {
  List<RealBarcodePosition> realPositionData = [];
  List<RealBarcodePosition> allBarcodesInScan = [];
  for (RealInterBarcodeOffset interBarcodeData in allRealInterBarcodeData) {
    int startIndex = allBarcodes.indexWhere(
        (element) => element.uid.toString() == interBarcodeData.uidStart);
    int endIndex = allBarcodes.indexWhere(
        (element) => element.uid.toString() == interBarcodeData.uidEnd);

    bool startIsFixed = false;
    bool endIsFixed = false;
    if (startIndex != -1) {
      startIsFixed = allBarcodes[startIndex].isMarker;
    }
    if (endIndex != -1) {
      endIsFixed = allBarcodes[endIndex].isMarker;
    }

    allBarcodesInScan.addAll([
      RealBarcodePosition(
        uid: interBarcodeData.uidStart,
        zOffset: interBarcodeData.zOffset,
      ),
      RealBarcodePosition(
        uid: interBarcodeData.uidEnd,
        zOffset: interBarcodeData.zOffset,
      )
    ]);
  }

  realPositionData = allBarcodesInScan.toSet().toList();
  return realPositionData;
}

///This builds the realInterBarcodeData objects and returns a list:
///
///i. It takes the phones rotation into consideration.
///
///ii. It calculates the real life distance between barcodes.
///
///iii. It calculates the distance between the camera and the barcode.
///
///
List<RealInterBarcodeOffset> buildAllRealInterBarcodeOffsets({
  required List<RawOnImageInterBarcodeData> allOnImageInterBarcodeData,
  required List<DistanceFromCameraLookupEntry> calibrationLookupTable,
  required List<BarcodeDataEntry> allBarcodes,
  required double focalLength,
}) {
  List<RealInterBarcodeOffset> allRealInterBarcodeData = [];

  for (RawOnImageInterBarcodeData interBarcodeDataInstance
      in allOnImageInterBarcodeData) {
    //1. Calculate both onImageBarcodeCenters
    Offset startBarcodeCenter =
        calculateBarcodeCenterPoint(interBarcodeDataInstance.startBarcode);
    Offset endBarcodeCenter =
        calculateBarcodeCenterPoint(interBarcodeDataInstance.endBarcode);

    //2. Rotate both barcode center vectors by phone angle.
    double phoneAngleRadians =
        interBarcodeDataInstance.accelerometerData.calculatePhoneAngle();
    Offset rotatedStartBarcodeCenter = rotateOffset(
        offset: startBarcodeCenter, angleRadians: phoneAngleRadians);
    Offset rotatedEndBarcodeCenter =
        rotateOffset(offset: endBarcodeCenter, angleRadians: phoneAngleRadians);

    //3. Calculate the interBarcode Offset
    Offset interBarcodeOffset =
        rotatedEndBarcodeCenter - rotatedStartBarcodeCenter;

    //4. Check offset direction.
    //Flips the direction if necessary
    if (!(int.parse(interBarcodeDataInstance.startBarcode.displayValue!) <
        int.parse(interBarcodeDataInstance.endBarcode.displayValue!))) {
      interBarcodeOffset = -interBarcodeOffset;
    }

    //5. Calculate real life offset.
    //Calculate the milimeter value of 1 on image unit (OIU). (Pixel ?)
    double startBarcodeMMperPX = calculateBacodeMMperOIU(
      barcodeDataEntries: allBarcodes,
      diagonalLength: interBarcodeDataInstance.startDiagonalLength,
      barcodeID: interBarcodeDataInstance.uidStart,
    );

    double endBarcodeMMperPX = calculateBacodeMMperOIU(
      barcodeDataEntries: allBarcodes,
      diagonalLength: interBarcodeDataInstance.endDiagonalLength,
      barcodeID: interBarcodeDataInstance.uidEnd,
    );

    //Calculate the real distance of the offset.
    Offset realOffsetStartBarcode = interBarcodeOffset / startBarcodeMMperPX;
    Offset realOffsetEndBarcode = interBarcodeOffset / endBarcodeMMperPX;
    //Calculate the average distance of the offsets.
    Offset averageRealInterBarcodeOffset =
        (realOffsetStartBarcode + realOffsetEndBarcode) / 2;

    //Use focal length
    //6. Find the distance bewteen the camera and barcodes.
    //startBarcode
    double startBarcodeDistanceFromCamera = findDistanceFromCamera(
      barcodeOnImageDiagonalLength:
          interBarcodeDataInstance.startDiagonalLength,
      barcodeValue: interBarcodeDataInstance.startBarcode,
      allBarcodes: allBarcodes,
      focalLength: focalLength,
    );
    //endBarcode
    double endBarcodeDistanceFromCamera = findDistanceFromCamera(
      barcodeOnImageDiagonalLength: interBarcodeDataInstance.endDiagonalLength,
      barcodeValue: interBarcodeDataInstance.endBarcode,
      allBarcodes: allBarcodes,
      focalLength: focalLength,
    );

    //Calculate the zOffset
    double zOffset =
        endBarcodeDistanceFromCamera - startBarcodeDistanceFromCamera;

    //Creating the realInterBarcodeOffset.
    RealInterBarcodeOffset realInterBarcodeDataInstance =
        RealInterBarcodeOffset(
            uid: interBarcodeDataInstance.uid,
            uidStart: interBarcodeDataInstance.uidStart,
            uidEnd: interBarcodeDataInstance.uidEnd,
            offset: averageRealInterBarcodeOffset,
            zOffset: zOffset,
            timestamp: interBarcodeDataInstance.timestamp);

    allRealInterBarcodeData.add(realInterBarcodeDataInstance);
  }
  return allRealInterBarcodeData;
}

///Rotates the offset by the given angle.
Offset rotateOffset({required Offset offset, required double angleRadians}) {
  double x = offset.dx * cos(angleRadians) - offset.dy * sin(angleRadians);
  double y = offset.dx * sin(angleRadians) + offset.dy * cos(angleRadians);
  return Offset(x, y);
}

//calculates the mm per OIU for the given barcodeID.
double calculateBacodeMMperOIU({
  required List<BarcodeDataEntry> barcodeDataEntries,
  required double diagonalLength,
  required String barcodeID,
}) {
  //If the barcode has not been generated. use default barcode size.
  int index =
      barcodeDataEntries.indexWhere((element) => element.uid == barcodeID);

  if (index != -1) {
    return diagonalLength / barcodeDataEntries[index].barcodeSize;
  } else {
    //get shared prefs.
    return diagonalLength / defaultBarcodeDiagonalLength!;
  }
}

//Uses the lookup table matchedCalibration data to find the distance from camera.
double findDistanceFromCamera({
  required double barcodeOnImageDiagonalLength,
  required BarcodeValue barcodeValue,
  required List<BarcodeDataEntry> allBarcodes,
  required double focalLength,
}) {
  int index = allBarcodes
      .indexWhere((element) => element.uid == barcodeValue.displayValue!);

  if (index != -1) {
    double barcodeRealDiagonalLength = allBarcodes[index].barcodeSize;
    double distanceFromCamera =
        focalLength * barcodeRealDiagonalLength / barcodeOnImageDiagonalLength;
    return distanceFromCamera;
  } else {
    double distanceFromCamera = focalLength *
        defaultBarcodeDiagonalLength! /
        barcodeOnImageDiagonalLength;
    return distanceFromCamera;
  }
}

///processRealInterBarcodeData
///
///1. Removes any outliers from allRealInterBarcodeOffsets
///
///2. Calculates the averages from the remaining data.
List<RealInterBarcodeOffset> processRealInterBarcodeData(
    {required List<RealInterBarcodeOffset> uniqueRealInterBarcodeOffsets,
    required List<RealInterBarcodeOffset> listOfRealInterBarcodeOffsets}) {
  //Calculates the average of each RealInterBarcode Data and removes outliers
  List<RealInterBarcodeOffset> finalRealInterBarcodeOffsets = [];
  for (RealInterBarcodeOffset realInterBacrodeOffset
      in uniqueRealInterBarcodeOffsets) {
    //All similar interBarcodeOffsets ex 1_2 will return all 1_2 interbarcodeOffsets
    List<RealInterBarcodeOffset> similarInterBarcodeOffsets =
        findSimilarInterBarcodeOffsets(
            listOfRealInterBarcodeOffsets, realInterBacrodeOffset);

    //Sort similarInterBarcodeOffsets by the magnitude of the Offset. (aka. the distance of the offset).
    similarInterBarcodeOffsets
        .sort((a, b) => a.offset.distance.compareTo(b.offset.distance));

    //Indexes (Stats)
    int medianIndex = (similarInterBarcodeOffsets.length ~/ 2);
    int quartile1Index = ((similarInterBarcodeOffsets.length / 2) ~/ 2);
    int quartile3Index = medianIndex + quartile1Index;

    //Values of indexes
    double median = similarInterBarcodeOffsets[medianIndex].offset.distance;
    double quartile1 = calculateQuartileValue(
        similarInterBarcodeOffsets, quartile1Index, median);
    double quartile3 = calculateQuartileValue(
        similarInterBarcodeOffsets, quartile3Index, median);

    //Boundry calculations
    double interQuartileRange = quartile3 - quartile1;
    double q1Boundry = quartile1 - interQuartileRange * 1.5; //Lower boundry
    double q3Boundry = quartile3 + interQuartileRange * 1.5; //Upper boundry

    //Remove data outside the boundries
    similarInterBarcodeOffsets.removeWhere((element) =>
        element.offset.distance <= q1Boundry &&
        element.offset.distance >= q3Boundry);

    //Loops through all remaining similar interBarcodeOffsets to calculate the average
    for (RealInterBarcodeOffset similarInterBarcodeOffset
        in similarInterBarcodeOffsets) {
      calculateAverageOffsets(
          similarInterBarcodeOffset, realInterBacrodeOffset);
      realInterBacrodeOffset.zOffset =
          (realInterBacrodeOffset.zOffset + similarInterBarcodeOffset.zOffset) /
              2;
    }
    finalRealInterBarcodeOffsets.add(realInterBacrodeOffset);
  }

  return finalRealInterBarcodeOffsets;
}

//Calculates the quartile value.
double calculateQuartileValue(
    List<RealInterBarcodeOffset> similarInterBarcodeOffsets,
    int quartile1Index,
    double median) {
  return (similarInterBarcodeOffsets[quartile1Index].offset.distance + median) /
      2;
}

///This returns the matchedCalibrationData lookup table
///
///This lookup table contains 2 things:
///(onImageBarcodeSize , realDistanceFromCamera)
Future<List<DistanceFromCameraLookupEntry>> getMatchedCalibrationData() async {
  Box<DistanceFromCameraLookupEntry> matchedCalibrationDataBox =
      await Hive.openBox(distanceLookupTableBoxName);

  return matchedCalibrationDataBox.values.toList();
}

///Returns a list of generated barcodeData
///
///This list contains 2 things
///(BarcodeID, realBarcodeSize)
Future<List<BarcodeDataEntry>> getAllExistingBarcodes() async {
  Box<BarcodeDataEntry> generatedBarcodeData =
      await Hive.openBox(allBarcodesBoxName);
  return generatedBarcodeData.values.toList();
}

///This builds the objects That describes the startBarcode, EndBarcode, AccelerometerData and timestamp
///
///It builds all the objects relative to the first onImageBarcodeData.
List<RawOnImageInterBarcodeData> buildAllOnImageInterBarcodeData(
    List<RawOnImageBarcodeData> allRawOnImageBarcodeData) {
  List<RawOnImageInterBarcodeData> allInterBarcodeData = [];
  for (RawOnImageBarcodeData onImageBarcodeData in allRawOnImageBarcodeData) {
    for (var barcodeIndex = 1;
        barcodeIndex < onImageBarcodeData.barcodes.length;
        barcodeIndex++) {
      allInterBarcodeData.add(RawOnImageInterBarcodeData(
          startBarcode: onImageBarcodeData.barcodes[0].value,
          endBarcode: onImageBarcodeData.barcodes[barcodeIndex].value,
          accelerometerData: onImageBarcodeData.accelerometerData,
          timestamp: onImageBarcodeData.timestamp));
    }
  }
  return allInterBarcodeData;
}
