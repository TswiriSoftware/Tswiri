import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

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

  ///Gets the start barcode's diagonal length
  double get startDiagonalLength {
    if (checkBarcodes()) {
      return averageBarcodeDiagonalLength(startBarcode);
    } else {
      return averageBarcodeDiagonalLength(endBarcode);
    }
  }

  ///Gets the end barcode's diagonal length
  double get endDiagonalLength {
    if (checkBarcodes()) {
      return averageBarcodeDiagonalLength(endBarcode);
    } else {
      return averageBarcodeDiagonalLength(startBarcode);
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
  Offset get realInterBarcodeOffset {
    if (checkBarcodes()) {
      return calculateOffsetBetweenTwoPoints(
              calculateBarcodeCenterPoint(startBarcode),
              calculateBarcodeCenterPoint(endBarcode)) /
          ((startDiagonalLength + endDiagonalLength) / 2);
    } else {
      return calculateOffsetBetweenTwoPoints(
              calculateBarcodeCenterPoint(endBarcode),
              calculateBarcodeCenterPoint(startBarcode)) /
          ((startDiagonalLength + endDiagonalLength) / 2);
    }
  }

  RealInterBarcodeOffset get realInterBarcodeData {
    RealInterBarcodeOffset realInterBarcodeDataInstance =
        RealInterBarcodeOffset(
            uid: uid,
            uidStart: startBarcodeID,
            uidEnd: endBarcodeID,
            interBarcodeOffset: realInterBarcodeOffset,
            distanceFromCamera: 0,
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
    return '${startBarcode.displayValue}_${endBarcode.displayValue}, ${realInterBarcodeOffset.dx} , ${realInterBarcodeOffset.dy}, $timestamp';
  }
}
