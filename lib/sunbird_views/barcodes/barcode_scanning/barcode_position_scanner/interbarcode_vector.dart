import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/translating/offset_rotation.dart';
import 'package:flutter_google_ml_kit/functions/translating/real_unit_calculator.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';
import 'package:vector_math/vector_math.dart';

import '../../../../functions/translating/distance_from_camera.dart';

class InterBarcodeVector {
  InterBarcodeVector({
    required this.startBarcodeUID,
    required this.endBarcodeUID,
    required this.vector3,
  });

  //Start barcodeUID.
  String startBarcodeUID;

  //End barcodeUID.
  String endBarcodeUID;

  //Vector
  Vector3 vector3;

  //Returns the UID of the interBarcodeVectorEntry
  String get uid {
    return '${startBarcodeUID}_$endBarcodeUID';
  }

  //Comparison
  @override
  bool operator ==(Object other) {
    return other is InterBarcodeVector &&
        other.startBarcodeUID == startBarcodeUID &&
        other.endBarcodeUID == endBarcodeUID;
  }

  @override
  int get hashCode => uid.hashCode;

  ///Create from RawInterBarcodeData.
  factory InterBarcodeVector.fromRawInterBarcodeData({
    required OnImageInterBarcodeData interBarcodeData,
    required List<BarcodeProperty> barcodeProperties,
    required double focalLength,
  }) {
    //1. Calculate RealInterBarcodeOffset.
    //i. Calculate phone angle.
    double phoneAngleRadians =
        interBarcodeData.startBarcode.accelerometerData.calculatePhoneAngle();

    //ii. rotate StartBarcodeCenter.
    Offset rotatedStartBarcodeCenter = rotateOffset(
        offset: interBarcodeData.startBarcode.barcodeCenterPoint,
        angleRadians: phoneAngleRadians);
    //iii. rotate EndBarcodeCenter.
    Offset rotatedEndBarcodeCenter = rotateOffset(
        offset: interBarcodeData.endBarcode.barcodeCenterPoint,
        angleRadians: phoneAngleRadians);

    //iv. calculate interBarcodeOffset.
    Offset interBarcodeOffset =
        rotatedEndBarcodeCenter - rotatedStartBarcodeCenter;

    //v. Calculate MMperPX.
    //Start.
    double startBarcodeMMperPX = calculateRealUnit(
        diagonalLength: interBarcodeData.startBarcode.barcodeDiagonalLength,
        barcodeUID: interBarcodeData.startBarcode.barcodeUID,
        barcodeProperties: barcodeProperties);
    //End.
    double endBarcodeMMperPX = calculateRealUnit(
        diagonalLength: interBarcodeData.endBarcode.barcodeDiagonalLength,
        barcodeUID: interBarcodeData.endBarcode.barcodeUID,
        barcodeProperties: barcodeProperties);

    //vi. Calculate RealOffsets.
    Offset realOffsetStartBarcode = interBarcodeOffset / startBarcodeMMperPX;
    Offset realOffsetEndBarcode = interBarcodeOffset / endBarcodeMMperPX;

    //Calculate the average distance of the two offsets.
    Offset averageRealInterBarcodeOffset =
        (realOffsetStartBarcode + realOffsetEndBarcode) / 2;

    //2. Find the distance bewteen the camera and barcodes using the camera's focal length.
    //StartBarcode.
    double startBarcodeDistanceFromCamera = calculateDistanceFromCamera(
      barcodeOnImageDiagonalLength:
          interBarcodeData.startBarcode.barcodeDiagonalLength,
      barcodeUID: interBarcodeData.startBarcode.barcodeUID,
      focalLength: focalLength,
      barcodeProperties: barcodeProperties,
    );

    //EndBarcode.
    double endBarcodeDistanceFromCamera = calculateDistanceFromCamera(
      barcodeOnImageDiagonalLength:
          interBarcodeData.endBarcode.barcodeDiagonalLength,
      barcodeUID: interBarcodeData.endBarcode.barcodeUID,
      focalLength: focalLength,
      barcodeProperties: barcodeProperties,
    );

    //3. Calculate the zOffset.
    double zOffset =
        endBarcodeDistanceFromCamera - startBarcodeDistanceFromCamera;

    //4. Build InterBarcodeVectorEntry.
    return InterBarcodeVector(
        startBarcodeUID: interBarcodeData.startBarcode.barcodeUID,
        endBarcodeUID: interBarcodeData.endBarcode.barcodeUID,
        vector3: Vector3(averageRealInterBarcodeOffset.dx,
            averageRealInterBarcodeOffset.dy, zOffset));
  }

  @override
  String toString() {
    return '\n$startBarcodeUID => $endBarcodeUID : ${vector3.x}, ${vector3.y}, ${vector3.z}';
  }
}
