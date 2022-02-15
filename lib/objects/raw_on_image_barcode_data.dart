import 'dart:math';
import 'dart:ui';

import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/objects/accelerometer_events.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart';

///Describes the "Offset" between two barcodes.
class RawOnImageInterBarcodeData {
  RawOnImageInterBarcodeData(
      {required this.startBarcode,
      required this.endBarcode,
      required this.accelerometerEvent,
      required this.timestamp});

  ///Data related to the start barcode.
  final BarcodeValue startBarcode;

  ///Data related to the end barcode.
  final BarcodeValue endBarcode;

  ///Contains accelerometer Events
  final AccelerometerEvents accelerometerEvent;

  ///Time of creation.
  final int timestamp;

  ///Check if startBarcode displayValue is less than endBarcode DisplayValue.
  bool checkBarcodes() {
    return int.parse(startBarcode.displayValue!) <
        int.parse(endBarcode.displayValue!);
  }

  ///Gets the start barcode's diagonal length in px.
  double get startDiagonalLength {
    if (checkBarcodes()) {
      return calculateAverageBarcodeDiagonalLength(startBarcode);
    } else {
      return calculateAverageBarcodeDiagonalLength(endBarcode);
    }
  }

  ///Gets the end barcode's diagonal length.
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

  //TODO: implement x<-45 and x>45
  ///Calculates the real interbarcode distace from the offset and barcode sizes.
  ///This will only work for -45deg to 45deg from up on the y axis.
  ///
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

    Vector2 realOffset = Vector2(average.dx, average.dy);
    double angleRadians = accelerometerEvent.calculatePhoneAngle();

    Offset rotatedOffset = Offset(
        (realOffset.x * cos(angleRadians) + (realOffset.y * sin(angleRadians))),
        (realOffset.x * sin(angleRadians) +
            (realOffset.y * cos(angleRadians))));

    print(angleRadians);

    return rotatedOffset;
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

  ///Creates a RealInterBarcodeOffset from data
  RealInterBarcodeOffset realInterBarcodeData(
      List<MatchedCalibrationDataHiveObject> matchedCalibrationData,
      List<BarcodeDataEntry> barcodeDataEntries) {
    RealInterBarcodeOffset realInterBarcodeDataInstance =
        RealInterBarcodeOffset(
            uid: uid,
            uidStart: startBarcodeID,
            uidEnd: endBarcodeID,
            interBarcodeOffset: realInterBarcodeOffset(barcodeDataEntries),
            phoneAngle: accelerometerEvent.calculatePhoneAngle(),
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
