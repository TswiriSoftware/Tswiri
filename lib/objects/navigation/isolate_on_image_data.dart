import 'dart:ui';

import 'package:flutter_google_ml_kit/objects/reworked/accelerometer_data.dart';
import 'package:vector_math/vector_math.dart' as vm;

class IsolateOnImageBarcodeData {
  IsolateOnImageBarcodeData({
    required this.barcodeUID,
    required this.onImageCornerPoints,
    required this.timestamp,
    required this.accelerometerData,
    required this.onImageDiagonalLength,
    required this.barcodeDiagonalLength,
    required this.barcodeMMperPX,
  });

  ///BarcodeUID.
  final String barcodeUID;

  final List<Offset> onImageCornerPoints;

  ///Timestamp.
  final int timestamp;

  ///Accelerometer Data.
  final AccelerometerData accelerometerData;

  final double barcodeMMperPX;

  final double barcodeDiagonalLength;

  final double onImageDiagonalLength;

  ///Create a Isolate Barcode from a List.
  factory IsolateOnImageBarcodeData.fromMessage(List<dynamic> item) {
    AccelerometerData accelerometerData = AccelerometerData(
        accelerometerEvent: vm.Vector3(
          item[3][0] as double,
          item[3][1] as double,
          item[3][2] as double,
        ),
        userAccelerometerEvent: vm.Vector3(
          item[3][3] as double,
          item[3][4] as double,
          item[3][5] as double,
        ));

    List<Offset> onImageCornerPoints = [
      Offset(item[2][0] as double, item[2][1] as double),
      Offset(item[2][2] as double, item[2][3] as double),
      Offset(item[2][4] as double, item[2][5] as double),
      Offset(item[2][6] as double, item[2][7] as double),
    ];

    return IsolateOnImageBarcodeData(
      barcodeUID: item[0],
      onImageCornerPoints: onImageCornerPoints,
      timestamp: item[8],
      accelerometerData: accelerometerData,
      onImageDiagonalLength: item[5],
      barcodeDiagonalLength: item[6],
      barcodeMMperPX: item[7],
    );
  }

  ///Calculate barcode centerPoint.
  Offset get barcodeCenterPoint {
    //Center of X coordinates.
    double centerX = (onImageCornerPoints[0].dx +
            onImageCornerPoints[1].dx +
            onImageCornerPoints[2].dx +
            onImageCornerPoints[3].dx) /
        4;

    //Center of Y coordinates.
    double centerY = (onImageCornerPoints[0].dy +
            onImageCornerPoints[1].dy +
            onImageCornerPoints[2].dy +
            onImageCornerPoints[3].dy) /
        4;
    return Offset(centerX, centerY);
  }

  @override
  String toString() {
    return '\nUID: $barcodeUID, timestamp: $timestamp, centerPoint: (${barcodeCenterPoint.dx}, ${barcodeCenterPoint.dy}), diagonalLength: $barcodeDiagonalLength), diag: $barcodeDiagonalLength, diagO: $onImageDiagonalLength, mmX: $barcodeMMperPX';
  }
}
