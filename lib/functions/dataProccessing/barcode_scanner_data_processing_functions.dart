import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/consolidated_database_view.dart';
import 'package:hive/hive.dart';

void calculateAverageOffsets(RealInterBarcodeOffset similarInterBarcodeOffset,
    RealInterBarcodeOffset realInterBacrodeOffset) {
  if (checkIfDirectionIsSame(
      similarInterBarcodeOffset, realInterBacrodeOffset)) {
    realInterBacrodeOffset.interBarcodeOffset = calculateAverageOffset(
        realInterBacrodeOffset.interBarcodeOffset,
        similarInterBarcodeOffset.interBarcodeOffset);
  } else if (checkIfDirectionIsInverse(
      similarInterBarcodeOffset, realInterBacrodeOffset)) {
    realInterBacrodeOffset.interBarcodeOffset = calculateAverageOffset(
        realInterBacrodeOffset.interBarcodeOffset,
        (-similarInterBarcodeOffset.interBarcodeOffset));
  }
}

Offset calculateAverageOffset(
    Offset realInterBacrodeOffset, Offset similarInterBarcodeOffset) {
  return (realInterBacrodeOffset + similarInterBarcodeOffset) / 2;
}

bool checkIfDirectionIsInverse(RealInterBarcodeOffset similarInterBarcodeOffset,
    RealInterBarcodeOffset realInterBacrodeOffset) {
  return similarInterBarcodeOffset.uidEnd == realInterBacrodeOffset.uidStart &&
      similarInterBarcodeOffset.uidStart == realInterBacrodeOffset.uidEnd;
}

bool checkIfDirectionIsSame(RealInterBarcodeOffset similarInterBarcodeOffset,
    RealInterBarcodeOffset realInterBacrodeOffset) {
  return similarInterBarcodeOffset.uidStart ==
          realInterBacrodeOffset.uidStart &&
      similarInterBarcodeOffset.uidEnd == realInterBacrodeOffset.uidEnd;
}

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

void writeValidBarcodePositionsToDatabase(
    RealBarcodePosition realBarcodePosition, Box<dynamic> realPositionalData) {
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

bool indexIsValid(int index) => index != -1;

///Considers the InterBarcodeOffset Offset's Direction
void determinesInterBarcodeOffsetDirection(
    {required RealInterBarcodeOffset relevantInterBarcodeOffset,
    required RealBarcodePosition endBarcodeRealPosition,
    required RealBarcodePosition startBarcode}) {
  if (relevantInterBarcodeOffset.uidEnd == endBarcodeRealPosition.uid) {
    endBarcodeRealPosition.interBarcodeOffset =
        startBarcode.interBarcodeOffset! +
            relevantInterBarcodeOffset.interBarcodeOffset;
    // endBarcodeRealPosition.numberOfBarcodesFromOrigin =
    //     1 + startBarcode.numberOfBarcodesFromOrigin!;
    endBarcodeRealPosition.timestamp = relevantInterBarcodeOffset.timestamp;
  } else if (relevantInterBarcodeOffset.uidStart ==
      endBarcodeRealPosition.uid) {
    endBarcodeRealPosition.interBarcodeOffset =
        startBarcode.interBarcodeOffset! -
            relevantInterBarcodeOffset.interBarcodeOffset;
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
      RealBarcodePosition(interBarcodeData.uidStart, null, null,
          interBarcodeData.distanceFromCamera, null),
      RealBarcodePosition(interBarcodeData.uidEnd, null, null,
          interBarcodeData.distanceFromCamera, null)
    ]);
  }

  realPositionData = allBarcodesInScan.toSet().toList();
  return realPositionData;
}

List<RealInterBarcodeOffset> addRealInterBarcodeOffsets(
    List<RawOnImageInterBarcodeData> allDeduplicatedInterBarcodeData,
    List<MatchedCalibrationDataHiveObject> matchedCalibrationData) {
  List<RealInterBarcodeOffset> allRealInterBarcodeData = [];
  for (RawOnImageInterBarcodeData interBarcodeDataInstance
      in allDeduplicatedInterBarcodeData) {
    RealInterBarcodeOffset realInterBarcodeDataInstance =
        interBarcodeDataInstance.realInterBarcodeData(matchedCalibrationData);
    allRealInterBarcodeData.add(realInterBarcodeDataInstance);
    //print(interBarcodeDa
    //taInstance);
  }
  return allRealInterBarcodeData;
}

List<RealInterBarcodeOffset> findDatasContainingCurrentBarcode(
    List<RealInterBarcodeOffset> realInterBarcodeData,
    RealBarcodePosition workingData) {
  return realInterBarcodeData
      .where((element) =>
          workingData.uid == element.uidStart ||
          workingData.uid == element.uidEnd)
      .toList();
}

ElevatedButton proceedButton(BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HiveDatabaseConsolidationView()));
      },
      child: const Icon(Icons.check_circle_outline_rounded));
}

int mySortComparison(RealBarcodePosition a, RealBarcodePosition b) {
  if (a.numberOfBarcodesFromOrigin != null &&
      b.numberOfBarcodesFromOrigin != null) {
    if (a.numberOfBarcodesFromOrigin! < b.numberOfBarcodesFromOrigin!) {
      return -1;
    } else if (a.numberOfBarcodesFromOrigin! > b.numberOfBarcodesFromOrigin!) {
      return 1;
    } else {
      return 0;
    }
  } else if (a.numberOfBarcodesFromOrigin != null &&
      b.numberOfBarcodesFromOrigin == null) {
    return -1;
  } else if (a.numberOfBarcodesFromOrigin == null &&
      b.numberOfBarcodesFromOrigin != null) {
    return 1;
  } else {
    return 0;
  }
}
