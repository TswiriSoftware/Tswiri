import 'dart:ui';

import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

///Describes the "Offset" between two barcodes.
class RawOnImageInterBarcodeData {
  RawOnImageInterBarcodeData(
      {required this.startBarcode,
      required this.endBarcode,
      required this.timestamp});

  final BarcodeValue startBarcode;
  final BarcodeValue endBarcode;
  final int timestamp;

  ///Check if startBarcode displayValue is less than endBarcode DisplayValue
  bool checkBarcodes() {
    return int.parse(startBarcode.displayValue!) <
        int.parse(endBarcode.displayValue!);
  }

  ///Gets the start barcode's diagonal length in px
  double get startDiagonalLength {
    if (checkBarcodes()) {
      return calculateAverageBarcodeDiagonalLength(startBarcode);
    } else {
      return calculateAverageBarcodeDiagonalLength(endBarcode);
    }
  }

  ///Gets the end barcode's diagonal length
  double get endDiagonalLength {
    if (checkBarcodes()) {
      return calculateAverageBarcodeDiagonalLength(endBarcode);
    } else {
      return calculateAverageBarcodeDiagonalLength(startBarcode);
    }
  }

  ///This returns the UID of the Start and end Barcode.
  ///The start barcode will alwyas be smaller than the end barcode.
  String get uid {
    if (checkBarcodes()) {
      return startBarcode.displayValue! + '_' + endBarcode.displayValue!;
    } else {
      return endBarcode.displayValue! + '_' + startBarcode.displayValue!;
    }
  }

  ///Returns the start Barcodes ID.
  String get startBarcodeID {
    if (checkBarcodes()) {
      return startBarcode.displayValue!;
    } else {
      return endBarcode.displayValue!;
    }
  }

  ///Returns the end Barcodes ID.
  String get endBarcodeID {
    if (checkBarcodes()) {
      return endBarcode.displayValue!;
    } else {
      return startBarcode.displayValue!;
    }
  }

  ///This calculates the real Offset between the two Barcodes.
  Offset realInterBarcodeOffset(List<BarcodeDataEntry> barcodeDataEntries) {
    //TODO: implement actual size calculations

    if (checkBarcodes()) {
      return calculateRealOffsetBetweenTwoPoints(
          calculateOffsetBetweenTwoPoints(
              calculateBarcodeCenterPoint(startBarcode),
              calculateBarcodeCenterPoint(endBarcode)),
          barcodeDataEntries);
    } else {
      return calculateRealOffsetBetweenTwoPoints(
          calculateOffsetBetweenTwoPoints(
              calculateBarcodeCenterPoint(endBarcode),
              calculateBarcodeCenterPoint(startBarcode)),
          barcodeDataEntries);
    }
  }

  ///Calculates the real interbarcode distace from the offset and barcode sizes.
  calculateRealOffsetBetweenTwoPoints(Offset offsetBetweenTwoPoints,
      List<BarcodeDataEntry> barcodeDataEntries) {
    // mm/px
    double startBarcodeMMperPX = startDiagonalLength /
        barcodeDataEntries
            .firstWhere(
                (element) => element.barcodeID == int.parse(startBarcodeID))
            .barcodeSize;

    double endBarcodeMMperPX = endDiagonalLength /
        barcodeDataEntries
            .firstWhere(
                (element) => element.barcodeID == int.parse(endBarcodeID))
            .barcodeSize;

    Offset realOffsetStartBarcode =
        offsetBetweenTwoPoints * startBarcodeMMperPX;
    Offset realOffsetEndBarcode = offsetBetweenTwoPoints * endBarcodeMMperPX;
    Offset average = (realOffsetStartBarcode + realOffsetEndBarcode) / 2;
    return average;
  }

  //Uses the lookup table matchedCalibration data to find the distance from camera
  double distanceFromCamera(
      List<MatchedCalibrationDataHiveObject> matchedCalibrationData) {
    double averageBarcodeSize = (startDiagonalLength + endDiagonalLength) / 2;

    //sort in descending order
    matchedCalibrationData.sort((a, b) => a.objectSize.compareTo(b.objectSize));

    //First index
    int distanceFromCameraIndex = matchedCalibrationData
        .indexWhere((element) => element.objectSize >= averageBarcodeSize);
    double distanceFromCamera = 0;
    //checks if index is valid
    if (distanceFromCameraIndex != -1) {
      distanceFromCamera =
          matchedCalibrationData[distanceFromCameraIndex].distance;
    }
    return distanceFromCamera;
  }

  RealInterBarcodeOffset realInterBarcodeData(
      List<MatchedCalibrationDataHiveObject> matchedCalibrationData,
      List<BarcodeDataEntry> barcodeDataEntries) {
    RealInterBarcodeOffset realInterBarcodeDataInstance =
        RealInterBarcodeOffset(
            uid: uid,
            uidStart: startBarcodeID,
            uidEnd: endBarcodeID,
            interBarcodeOffset: realInterBarcodeOffset(barcodeDataEntries),
            distanceFromCamera: distanceFromCamera(matchedCalibrationData),
            timestamp: timestamp);

    return realInterBarcodeDataInstance;
  }

  @override
  bool operator ==(Object other) {
    return other is RawOnImageInterBarcodeData && hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    return '${startBarcode.displayValue}_${endBarcode.displayValue}, ${realInterBarcodeOffset} , ${realInterBarcodeOffset}, $timestamp';
  }
}
