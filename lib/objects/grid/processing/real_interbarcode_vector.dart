// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/translating/offset_rotation.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';
import 'package:isar/isar.dart';
import 'package:vector_math/vector_math.dart';

class RealInterBarcodeVector {
  RealInterBarcodeVector({
    required this.startBarcodeUID,
    required this.endBarcodeUID,
    required this.vector,
  });

  //Start barcodeUID.
  final String startBarcodeUID;

  //End barcodeUID.
  final String endBarcodeUID;

  Vector3 vector;

  //Returns the UID of the interBarcodeVectorEntry
  String get uid {
    return '${startBarcodeUID}_$endBarcodeUID';
  }

  //Comparison
  @override
  bool operator ==(Object other) {
    if (other is RealInterBarcodeVector) {
      return hashCode == other.hashCode;
    } else {
      return hashCode == other.hashCode;
    }
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    return '\nstartBarcodeUID: $startBarcodeUID, endBarcodeUID: $endBarcodeUID,X: ${vector.x}, Y: ${vector.y}, Z: ${vector.z}';
  }

  void averageInterBarcodeVector(
      RealInterBarcodeVector isolateRealInterBarcodeVector) {
    Vector3 newVector = (vector + isolateRealInterBarcodeVector.vector) / 2;
    vector = newVector;
  }

  factory RealInterBarcodeVector.fromInterBarcodeVector(
    OnImageInterBarcodeData interBarcodeData,
    int creationTimestamp,
    Isar isar,
  ) {
    ///1. Calculate RealInterBarcodeOffset
    double phoneAngleRadians = interBarcodeData.startBarcode.accelerometerData
        .calculatePhoneAngle(); //*

    Offset rotatedStartBarcodeCenter = rotateOffset(
      offset: interBarcodeData.startBarcode.barcodeCenterPoint,
      angleRadians: phoneAngleRadians,
    );

    Offset rotatedEndBarcodeCenter = rotateOffset(
        offset: interBarcodeData.endBarcode.barcodeCenterPoint,
        angleRadians: phoneAngleRadians);

    Offset interBarcodeOffset =
        rotatedEndBarcodeCenter - rotatedStartBarcodeCenter;

    double startBarcodeSize = isar.barcodePropertys
        .filter()
        .barcodeUIDMatches(interBarcodeData.startBarcode.barcodeUID)
        .findFirstSync()!
        .size;

    double endBarcodeSize = isar.barcodePropertys
        .filter()
        .barcodeUIDMatches(interBarcodeData.startBarcode.barcodeUID)
        .findFirstSync()!
        .size;

    double startBarcodeMMperPX =
        interBarcodeData.startBarcode.barcodeDiagonalLength / startBarcodeSize;

    double endBarcodeMMperPX =
        interBarcodeData.endBarcode.barcodeDiagonalLength / endBarcodeSize;

    Offset realOffsetStartBarcode = interBarcodeOffset / startBarcodeMMperPX;
    Offset realOffsetEndBarcode = interBarcodeOffset / endBarcodeMMperPX;

    //Calculate the average distance of the two offsets.
    Offset averageRealInterBarcodeOffset =
        (realOffsetStartBarcode + realOffsetEndBarcode) / 2;

    return RealInterBarcodeVector(
        startBarcodeUID: interBarcodeData.startBarcode.barcodeUID,
        endBarcodeUID: interBarcodeData.endBarcode.barcodeUID,
        vector: Vector3(averageRealInterBarcodeOffset.dx,
            averageRealInterBarcodeOffset.dy, 0));
  }
}
