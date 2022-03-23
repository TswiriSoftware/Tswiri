import 'dart:math';
import 'dart:ui';

import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:isar/isar.dart';

Offset calculateOnImageBarcodeCenterPoint(List<Point<num>> cornerPoints) {
  //Calculate 4 corners of barcode.
  List<Offset> offsetPoints = [];
  for (var point in cornerPoints) {
    double x = point.x.toDouble();
    double y = point.y.toDouble();
    offsetPoints.add(Offset(x, y));
  }
  Offset centerPoint =
      offsetPoints[0] + offsetPoints[1] + offsetPoints[2] + offsetPoints[3] / 4;

  return centerPoint;
}

///Rotates the offset by the given angle.
Offset rotateOffset({required Offset offset, required double angleRadians}) {
  double x = offset.dx * cos(angleRadians) - offset.dy * sin(angleRadians);
  double y = offset.dx * sin(angleRadians) + offset.dy * cos(angleRadians);
  return Offset(x, y);
}

///Calculate the milimeter value of 1 on image unit (OIU). (Pixel ?)
double calculateBacodeMMperOIU(
    {required Isar database,
    required double diagonalLength,
    required String barcodeUID}) {
  //If the barcode has not been generated. use default barcode size.
  double barcodeDiagonalLength = database.barcodePropertys
          .filter()
          .barcodeUIDMatches(barcodeUID)
          .findFirstSync()
          ?.size ??
      defaultBarcodeDiagonalLength!;

  return diagonalLength / barcodeDiagonalLength;
}

double calculateDistanceFromCamera(
    {required double barcodeOnImageDiagonalLength,
    required String barcodeUID,
    required Isar database,
    required double focalLength}) {
  //If the barcode has not been generated. use default barcode size.
  double barcodeDiagonalLength = database.barcodePropertys
          .filter()
          .barcodeUIDMatches(barcodeUID)
          .findFirstSync()
          ?.size ??
      defaultBarcodeDiagonalLength!;

  //Calculate the distance from the camera
  double distanceFromCamera =
      focalLength * barcodeDiagonalLength / barcodeOnImageDiagonalLength;

  return distanceFromCamera;
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

    //TODO: investigate.
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

//Calculates the quartile value.
double calculateQuartileValue(
    List<RealInterBarcodeOffset> similarInterBarcodeOffsets,
    int quartile1Index,
    double median) {
  return (similarInterBarcodeOffsets[quartile1Index].offset.distance + median) /
      2;
}

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
