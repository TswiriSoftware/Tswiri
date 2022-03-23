import 'dart:ui';

import 'package:flutter_google_ml_kit/objects/raw_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/functions/functions.dart';
import 'package:isar/isar.dart';

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
    required double focalLength,
    required Isar database}) {
  List<RealInterBarcodeOffset> allRealInterBarcodeData = [];

  for (RawOnImageInterBarcodeData interBarcodeDataInstance
      in allOnImageInterBarcodeData) {
    //1. Calculate onImageBarcodeCenters using cornerPoints.
    //StartBarcode
    Offset startBarcodeCenter = calculateOnImageBarcodeCenterPoint(
        interBarcodeDataInstance.startBarcode.cornerPoints!);
    //EndBarcode
    Offset endBarcodeCenter = calculateOnImageBarcodeCenterPoint(
        interBarcodeDataInstance.endBarcode.cornerPoints!);

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
      database: database,
      diagonalLength: interBarcodeDataInstance.startDiagonalLength,
      barcodeUID: interBarcodeDataInstance.uidStart,
    );

    double endBarcodeMMperPX = calculateBacodeMMperOIU(
      database: database,
      diagonalLength: interBarcodeDataInstance.endDiagonalLength,
      barcodeUID: interBarcodeDataInstance.uidEnd,
    );

    //Calculate the real distance of the offset.
    Offset realOffsetStartBarcode = interBarcodeOffset / startBarcodeMMperPX;
    Offset realOffsetEndBarcode = interBarcodeOffset / endBarcodeMMperPX;

    //Calculate the average distance of the offsets.
    Offset averageRealInterBarcodeOffset =
        (realOffsetStartBarcode + realOffsetEndBarcode) / 2;

    //6. Find the distance bewteen the camera and barcodes using the camera's focal length.
    //StartBarcode
    double startBarcodeDistanceFromCamera = calculateDistanceFromCamera(
      barcodeOnImageDiagonalLength:
          interBarcodeDataInstance.startDiagonalLength,
      barcodeUID: interBarcodeDataInstance.uidStart,
      database: database,
      focalLength: focalLength,
    );

    //EndBarcode
    double endBarcodeDistanceFromCamera = calculateDistanceFromCamera(
      barcodeOnImageDiagonalLength: interBarcodeDataInstance.endDiagonalLength,
      barcodeUID: interBarcodeDataInstance.uidEnd,
      database: database,
      focalLength: focalLength,
    );

    //Calculate the zOffset
    double zOffset =
        endBarcodeDistanceFromCamera - startBarcodeDistanceFromCamera;

    //Creating the realInterBarcodeOffset.
    RealInterBarcodeOffset realInterBarcodeDataInstance =
        RealInterBarcodeOffset(
            uid: interBarcodeDataInstance.uid,
            uidStart: interBarcodeDataInstance.uidStart,
            uidEnd: interBarcodeDataInstance.uidEnd,
            offset: averageRealInterBarcodeOffset,
            zOffset: zOffset,
            timestamp: interBarcodeDataInstance.timestamp);

    allRealInterBarcodeData.add(realInterBarcodeDataInstance);
  }
  return allRealInterBarcodeData;
}
