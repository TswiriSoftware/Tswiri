import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/translating/offset_rotation.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_on_image_inter_barcode_data.dart';
import 'package:vector_math/vector_math.dart';

class IsolateRealInterBarcodeVector {
  IsolateRealInterBarcodeVector({
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
    return hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    return '\nstartBarcodeUID: $startBarcodeUID, endBarcodeUID: $endBarcodeUID,X: ${vector.x}, Y: ${vector.y}, Z: ${vector.z}';
  }

  void averageInterBarcodeVector(
      IsolateRealInterBarcodeVector isolateRealInterBarcodeVector) {
    Vector3 newVector = (vector + isolateRealInterBarcodeVector.vector) / 2;
    vector = newVector;
  }

  factory IsolateRealInterBarcodeVector.fromIsolateInterBarcodeData(
      IsolateOnImageInterBarcodeData interBarcodeData, int creationTimestamp) {
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

    double startBarcodeMMperPX =
        interBarcodeData.startBarcode.onImageDiagonalLength /
            interBarcodeData.startBarcode.barcodeDiagonalLength;

    double endBarcodeMMperPX =
        interBarcodeData.endBarcode.onImageDiagonalLength /
            interBarcodeData.endBarcode.barcodeDiagonalLength;

    Offset realOffsetStartBarcode = interBarcodeOffset / startBarcodeMMperPX;
    Offset realOffsetEndBarcode = interBarcodeOffset / endBarcodeMMperPX;

    //Calculate the average distance of the two offsets.
    Offset averageRealInterBarcodeOffset =
        (realOffsetStartBarcode + realOffsetEndBarcode) / 2;

    return IsolateRealInterBarcodeVector(
        startBarcodeUID: interBarcodeData.startBarcode.barcodeUID,
        endBarcodeUID: interBarcodeData.endBarcode.barcodeUID,
        vector: Vector3(averageRealInterBarcodeOffset.dx,
            averageRealInterBarcodeOffset.dy, 0));
  }
}
