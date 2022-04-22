import 'dart:math';
import 'dart:ui';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/objects/reworked/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:isar/isar.dart';
import 'package:vector_math/vector_math.dart' as vm;

class RealInterBarcodeData {
  RealInterBarcodeData({
    required this.uid,
    required this.startBarcodeUID,
    required this.endBarcodeUID,
    required this.vector3,
    required this.timestamp,
  });

  ///uidStart_uidEnd
  String uid;

  ///ID of the Start Barcode.
  String startBarcodeUID;

  ///ID of the End Barcode.
  String endBarcodeUID;

  //3D vector from start *to* end.
  vm.Vector3 vector3;

  ///Timestamp of when it was created.
  int timestamp;

  @override
  bool operator ==(Object other) {
    return other is RealInterBarcodeData && hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    return '\n$startBarcodeUID => $endBarcodeUID, vector: (${vector3.x}, ${vector3.y}, ${vector3.z}), Z: $timestamp';
  }

  factory RealInterBarcodeData.fromRawInterBarcodeData(
      OnImageInterBarcodeData interBarcodeData) {
    ///1. Calculate RealInterBarcodeOffset
    double phoneAngleRadians =
        interBarcodeData.startBarcode.accelerometerData.calculatePhoneAngle();

    Offset rotatedStartBarcodeCenter = rotateOffset(
        offset: interBarcodeData.startBarcode.barcodeCenterPoint,
        angleRadians: phoneAngleRadians);

    Offset rotatedEndBarcodeCenter = rotateOffset(
        offset: interBarcodeData.endBarcode.barcodeCenterPoint,
        angleRadians: phoneAngleRadians);

    Offset interBarcodeOffset =
        rotatedEndBarcodeCenter - rotatedStartBarcodeCenter;

    double startBarcodeMMperPX = calculateBacodeMMperOIU(
      diagonalLength: interBarcodeData.startBarcode.barcodeDiagonalLength,
      barcodeUID: interBarcodeData.startBarcode.barcodeUID,
    );

    double endBarcodeMMperPX = calculateBacodeMMperOIU(
      diagonalLength: interBarcodeData.endBarcode.barcodeDiagonalLength,
      barcodeUID: interBarcodeData.endBarcode.barcodeUID,
    );

    Offset realOffsetStartBarcode = interBarcodeOffset / startBarcodeMMperPX;
    Offset realOffsetEndBarcode = interBarcodeOffset / endBarcodeMMperPX;

    //Calculate the average distance of the two offsets.
    Offset averageRealInterBarcodeOffset =
        (realOffsetStartBarcode + realOffsetEndBarcode) / 2;

    ///2. Find the distance bewteen the camera and barcodes using the camera's focal length.
    //StartBarcode
    double startBarcodeDistanceFromCamera = calculateDistanceFromCamera(
      barcodeOnImageDiagonalLength:
          interBarcodeData.startBarcode.barcodeDiagonalLength,
      barcodeUID: interBarcodeData.startBarcode.barcodeUID,
      focalLength: focalLength,
    );

    //EndBarcode
    double endBarcodeDistanceFromCamera = calculateDistanceFromCamera(
      barcodeOnImageDiagonalLength:
          interBarcodeData.endBarcode.barcodeDiagonalLength,
      barcodeUID: interBarcodeData.endBarcode.barcodeUID,
      focalLength: focalLength,
    );

    //Calculate the zOffset
    double zOffset =
        endBarcodeDistanceFromCamera - startBarcodeDistanceFromCamera;

    return RealInterBarcodeData(
      uid: interBarcodeData.uid,
      startBarcodeUID: interBarcodeData.startBarcode.barcodeUID,
      endBarcodeUID: interBarcodeData.endBarcode.barcodeUID,
      vector3: vm.Vector3(
        averageRealInterBarcodeOffset.dx,
        averageRealInterBarcodeOffset.dy,
        zOffset,
      ),
      timestamp: interBarcodeData.startBarcode.timestamp,
    );
  }
}

///Rotates the offset by the given angle.
Offset rotateOffset({required Offset offset, required double angleRadians}) {
  double x = offset.dx * cos(angleRadians) - offset.dy * sin(angleRadians);
  double y = offset.dx * sin(angleRadians) + offset.dy * cos(angleRadians);
  return Offset(x, y);
}

///Calculate the milimeter value of 1 on image unit (OIU). (Pixel ?)
double calculateBacodeMMperOIU(
    {required double diagonalLength, required String barcodeUID}) {
  //If the barcode has not been generated. use default barcode size.
  double barcodeDiagonalLength = isarDatabase!.barcodePropertys
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
    required double focalLength}) {
  //If the barcode has not been generated. use default barcode size.
  double barcodeDiagonalLength = isarDatabase!.barcodePropertys
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
