import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/objects/display/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';

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
  //List<BarcodeDataEntry> allBarcodes,
) {
  List<RealBarcodePosition> realPositionData = [];
  List<RealBarcodePosition> allBarcodesInScan = [];
  for (RealInterBarcodeOffset interBarcodeData in allRealInterBarcodeData) {
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
