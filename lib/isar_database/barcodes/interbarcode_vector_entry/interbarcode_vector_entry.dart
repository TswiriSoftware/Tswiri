import 'dart:ui';
import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:flutter_google_ml_kit/functions/translating/distance_from_camera.dart';
import 'package:flutter_google_ml_kit/functions/translating/offset_rotation.dart';
import 'package:flutter_google_ml_kit/functions/translating/real_unit_calculator.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';
import 'package:isar/isar.dart';
part 'interbarcode_vector_entry.g.dart';

@Collection()
class InterBarcodeVectorEntry {
  int id = Isar.autoIncrement;

  //Start barcodeUID.
  late String startBarcodeUID;
  //End barcodeUID.
  late String endBarcodeUID;

  //Timestamp.
  late int timestamp;

  //Creation Timestamp
  late int creationTimestamp;

  //X vector.
  late double x; //Make nullale ?
  //Y vector.
  late double y; //Make nullable ?
  //Z vector.
  late double z; //Make nullable ?

  late bool outDated; //Outdated InterBarcodeVectors.

  //Returns the UID of the interBarcodeVectorEntry
  String get uid {
    return '${startBarcodeUID}_$endBarcodeUID';
  }

  vm.Vector3 get vector3 {
    return vm.Vector3(x, y, z);
  }

  //Comparison
  @override
  bool operator ==(Object other) {
    return other is InterBarcodeVectorEntry &&
        other.startBarcodeUID == startBarcodeUID &&
        other.endBarcodeUID == endBarcodeUID;
  }

  @override
  int get hashCode => ('${startBarcodeUID}_$endBarcodeUID').hashCode;

  @override
  String toString() {
    return '\nStart: ${startBarcodeUID.split('_').first}, End: ${endBarcodeUID.split('_').first}, X: ${roundDouble(x, 2)}, Y: ${roundDouble(y, 2)}, Z: ${roundDouble(z, 2)}, time: $timestamp, hascode: $hashCode';
  }

  Map toJson() => {
        'id': id,
        'startBarcodeUID': startBarcodeUID,
        'endBarcodeUID': endBarcodeUID,
        'x': x,
        'y': y,
        'z': z,
        'timestamp': timestamp,
        'creationTimestamp': creationTimestamp,
        'outDated': outDated
      };

  InterBarcodeVectorEntry fromJson(Map<String, dynamic> json) {
    return InterBarcodeVectorEntry()
      ..id = json['id']
      ..startBarcodeUID = json['startBarcodeUID']
      ..endBarcodeUID = json['endBarcodeUID']
      ..x = json['z'] as double
      ..y = json['y'] as double
      ..z = json['z'] as double
      ..timestamp = json['timestamp'] as int
      ..creationTimestamp = json['creationTimestamp'] as int
      ..outDated = json['outDated'];
  }

  ///Create from RawInterBarcodeData.
  InterBarcodeVectorEntry fromRawInterBarcodeData({
    required OnImageInterBarcodeData interBarcodeData,
    required int creationTimestamp,
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
    return InterBarcodeVectorEntry()
      ..startBarcodeUID = interBarcodeData.startBarcode.barcodeUID
      ..endBarcodeUID = interBarcodeData.endBarcode.barcodeUID
      ..creationTimestamp = creationTimestamp
      ..timestamp = interBarcodeData.startBarcode.timestamp
      ..x = averageRealInterBarcodeOffset.dx
      ..y = averageRealInterBarcodeOffset.dy
      ..z = zOffset
      ..outDated = false;
  }
}
