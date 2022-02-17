import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:hive/hive.dart';

///Calculates the average interBarcodeOffset.
/// i. Takes into account for offset direction.
void calculateAverageOffsets(RealInterBarcodeOffset similarInterBarcodeOffset,
    RealInterBarcodeOffset realInterBacrodeOffset) {
  if (checkIfDirectionIsSame(
      similarInterBarcodeOffset, realInterBacrodeOffset)) {
    realInterBacrodeOffset.realInterBarcodeOffset = calculateAverageOffset(
        realInterBacrodeOffset.realInterBarcodeOffset,
        similarInterBarcodeOffset.realInterBarcodeOffset);
  } else if (checkIfDirectionIsInverse(
      similarInterBarcodeOffset, realInterBacrodeOffset)) {
    realInterBacrodeOffset.realInterBarcodeOffset = calculateAverageOffset(
        realInterBacrodeOffset.realInterBarcodeOffset,
        (-similarInterBarcodeOffset.realInterBarcodeOffset));
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
    Box<RealBarcodePostionEntry> realPositionalData) {
  if (realBarcodePosition.interBarcodeOffset != null) {
    //Creates an entry for each realBarcodePosition
    realPositionalData.put(
        realBarcodePosition.uid,
        RealBarcodePostionEntry(
            uid: realBarcodePosition.uid,
            offset: offsetToTypeOffset(realBarcodePosition.interBarcodeOffset!),
            distanceFromCamera: realBarcodePosition.distanceFromCamera,
            fixed: false,
            timestamp: realBarcodePosition.timestamp!));
  }
}

//Checks if the index is valid.
bool indexIsValid(int index) => index != -1;

///Considers the InterBarcodeOffset Offset's Direction
void determinesInterBarcodeOffsetDirection(
    {required RealInterBarcodeOffset relevantInterBarcodeOffset,
    required RealBarcodePosition endBarcodeRealPosition,
    required RealBarcodePosition startBarcode}) {
  if (relevantInterBarcodeOffset.uidEnd == endBarcodeRealPosition.uid) {
    endBarcodeRealPosition.interBarcodeOffset =
        startBarcode.interBarcodeOffset! +
            relevantInterBarcodeOffset.realInterBarcodeOffset;
    // endBarcodeRealPosition.numberOfBarcodesFromOrigin =
    //     1 + startBarcode.numberOfBarcodesFromOrigin!;
    endBarcodeRealPosition.timestamp = relevantInterBarcodeOffset.timestamp;
  } else if (relevantInterBarcodeOffset.uidStart ==
      endBarcodeRealPosition.uid) {
    endBarcodeRealPosition.interBarcodeOffset =
        startBarcode.interBarcodeOffset! -
            relevantInterBarcodeOffset.realInterBarcodeOffset;
    // endBarcodeRealPosition.numberOfBarcodesFromOrigin =
    //     1 + startBarcode.numberOfBarcodesFromOrigin!;
    endBarcodeRealPosition.timestamp = relevantInterBarcodeOffset.timestamp;
  }
}

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
      .where((realBarcodePosition) =>
          realBarcodePosition.interBarcodeOffset != null)
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
) {
  List<RealBarcodePosition> realPositionData = [];
  List<RealBarcodePosition> allBarcodesInScan = [];
  for (RealInterBarcodeOffset interBarcodeData in allRealInterBarcodeData) {
    allBarcodesInScan.addAll([
      RealBarcodePosition(
        uid: interBarcodeData.uidStart,
        distanceFromCamera: interBarcodeData.distanceFromCamera,
      ),
      RealBarcodePosition(
        uid: interBarcodeData.uidEnd,
        distanceFromCamera: interBarcodeData.distanceFromCamera,
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
List<RealInterBarcodeOffset> buildAllRealInterBarcodeOffsets(
    {required List<RawOnImageInterBarcodeData> allOnImageInterBarcodeData,
    required List<MatchedCalibrationDataHiveObject> matchedCalibrationData,
    required List<BarcodeDataEntry> barcodeDataEntries}) {
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
        barcodeDataEntries: barcodeDataEntries,
        diagonalLength: interBarcodeDataInstance.startDiagonalLength,
        barcodeID: interBarcodeDataInstance.uidStart);

    double endBarcodeMMperPX = calculateBacodeMMperOIU(
        barcodeDataEntries: barcodeDataEntries,
        diagonalLength: interBarcodeDataInstance.endDiagonalLength,
        barcodeID: interBarcodeDataInstance.uidEnd);

    //Calculate the real distance of the offset.
    Offset realOffsetStartBarcode = interBarcodeOffset * startBarcodeMMperPX;
    Offset realOffsetEndBarcode = interBarcodeOffset * endBarcodeMMperPX;
    //Calculate the average distance of the offsets.
    Offset averageRealInterBarcodeOffset =
        (realOffsetStartBarcode + realOffsetEndBarcode) / 2;

    //6. Find the distance bewteen the camera and barcodes.
    double distanceFromCamera = findDistanceFromCamera(
        calibrationLookupTable: matchedCalibrationData,
        startBarcodeDiagonalLength:
            interBarcodeDataInstance.startDiagonalLength,
        endBarcodeDiagonalLength: interBarcodeDataInstance.endDiagonalLength);

    //Creating the realInterBarcodeOffset.
    RealInterBarcodeOffset realInterBarcodeDataInstance =
        RealInterBarcodeOffset(
            uid: interBarcodeDataInstance.uid,
            uidStart: interBarcodeDataInstance.uidStart,
            uidEnd: interBarcodeDataInstance.uidEnd,
            realInterBarcodeOffset: averageRealInterBarcodeOffset,
            distanceFromCamera: distanceFromCamera,
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
double calculateBacodeMMperOIU(
    {required List<BarcodeDataEntry> barcodeDataEntries,
    required double diagonalLength,
    required String barcodeID}) {
  return diagonalLength /
      barcodeDataEntries
          .firstWhere((element) => element.barcodeID == int.parse(barcodeID))
          .barcodeSize;
}

//Uses the lookup table matchedCalibration data to find the distance from camera.
double findDistanceFromCamera(
    {required List<MatchedCalibrationDataHiveObject> calibrationLookupTable,
    required double startBarcodeDiagonalLength,
    required double endBarcodeDiagonalLength}) {
  //calculate the average size of the barcodes.
  double averageBarcodeSize =
      (startBarcodeDiagonalLength + endBarcodeDiagonalLength) / 2;

  //sort in descending order
  calibrationLookupTable.sort((a, b) => a.objectSize.compareTo(b.objectSize));

  //First index
  int distanceFromCameraIndex = calibrationLookupTable
      .indexWhere((element) => element.objectSize >= averageBarcodeSize);
  double distanceFromCamera = 0;
  //checks if index is valid
  if (distanceFromCameraIndex != -1) {
    distanceFromCamera =
        calibrationLookupTable[distanceFromCameraIndex].distanceFromCamera;
  }
  return distanceFromCamera;
}

///processRealInterBarcodeData
///
///1. Removes any outliers from allRealInterBarcodeOffsets
///
///2. Calculates the averages from the remaining data.
List<RealInterBarcodeOffset> processRealInterBarcodeData(
    {required List<RealInterBarcodeOffset> uniqueRealInterBarcodeOffsets,
    required List<RealInterBarcodeOffset> allRealInterBarcodeOffsets}) {
  //Calculates the average of each RealInterBarcode Data and removes outliers
  List<RealInterBarcodeOffset> finalRealInterBarcodeOffsets = [];
  for (RealInterBarcodeOffset realInterBacrodeOffset
      in uniqueRealInterBarcodeOffsets) {
    //All similar interBarcodeOffsets ex 1_2 will return all 1_2 interbarcodeOffsets
    List<RealInterBarcodeOffset> similarInterBarcodeOffsets =
        findSimilarInterBarcodeOffsets(
            allRealInterBarcodeOffsets, realInterBacrodeOffset);

    //Sort similarInterBarcodeOffsets by the magnitude of the Offset. (aka. the distance of the offset).
    similarInterBarcodeOffsets.sort((a, b) => a.realInterBarcodeOffset.distance
        .compareTo(b.realInterBarcodeOffset.distance));

    //Indexes (Stats)
    int medianIndex = (similarInterBarcodeOffsets.length ~/ 2);
    int quartile1Index = ((similarInterBarcodeOffsets.length / 2) ~/ 2);
    int quartile3Index = medianIndex + quartile1Index;

    //Values of indexes
    double median =
        similarInterBarcodeOffsets[medianIndex].realInterBarcodeOffset.distance;
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
        element.realInterBarcodeOffset.distance <= q1Boundry &&
        element.realInterBarcodeOffset.distance >= q3Boundry);

    //Loops through all remaining similar interBarcodeOffsets to calculate the average
    for (RealInterBarcodeOffset similarInterBarcodeOffset
        in similarInterBarcodeOffsets) {
      calculateAverageOffsets(
          similarInterBarcodeOffset, realInterBacrodeOffset);
      realInterBacrodeOffset.distanceFromCamera =
          (realInterBacrodeOffset.distanceFromCamera +
                  similarInterBarcodeOffset.distanceFromCamera) /
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
  return (similarInterBarcodeOffsets[quartile1Index]
              .realInterBarcodeOffset
              .distance +
          median) /
      2;
}

///This returns the matchedCalibrationData lookup table
///
///This lookup table contains 2 things:
///(onImageBarcodeSize , realDistanceFromCamera)
Future<List<MatchedCalibrationDataHiveObject>>
    getMatchedCalibrationData() async {
  Box<MatchedCalibrationDataHiveObject> matchedCalibrationDataBox =
      await Hive.openBox(matchedDataHiveBoxName);

  return matchedCalibrationDataBox.values.toList();
}

///Returns a list of generated barcodeData
///
///This list contains 2 things
///(BarcodeID, realBarcodeSize)
Future<List<BarcodeDataEntry>> getGeneratedBarcodeData() async {
  Box<BarcodeDataEntry> generatedBarcodeData =
      await Hive.openBox(generatedBarcodesBoxName);
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
