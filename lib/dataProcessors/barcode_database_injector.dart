// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/database/qrcodes.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:vector_math/vector_math.dart';

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

class BarcodeDatabaseInjector {
  BarcodeDatabaseInjector(this.barcodes, this.absoluteImageSize, this.rotation);

  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
}

void injectBarcode(
  BuildContext context,
  List<Barcode> barcodes,
  Size absoluteImageSize,
  InputImageRotation rotation,
  Box<dynamic> qrCodesBox,
) {
  //print('Hello @049er');
  //print('Hi @Spodeo');

  var barcodeCenterPoints = []; // Centre co-ordinates of scanned QR codes
  var milimeterOffsetXY = []; //Offset With the mm value of X and Y
  var qrCodeData = [];

  var qrCodeVectors = [];

  //Method to round double values
  double dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  Size size = Size(
      MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

  for (final Barcode barcode in barcodes) {
    final barcodeBoundingBoxLeft = translateX(
        barcode.value.boundingBox!.left, rotation, size, absoluteImageSize);
    final barcodeBoundingBoxRight = translateX(
        barcode.value.boundingBox!.right, rotation, size, absoluteImageSize);
    final barcodeBoundingBoxTop = translateY(
        barcode.value.boundingBox!.top, rotation, size, absoluteImageSize);
    final barcodeBoundingBoxBottom = translateY(
        barcode.value.boundingBox!.bottom, rotation, size, absoluteImageSize);

    var barcodePixelDistanceX =
        (barcodeBoundingBoxLeft + barcodeBoundingBoxRight) / 2;
    var barcodePixelDistanceY =
        (barcodeBoundingBoxTop + barcodeBoundingBoxBottom) / 2;
    barcodeCenterPoints
        .add(Offset(barcodePixelDistanceX, barcodePixelDistanceY));

    var barcodeCenterPoint =
        ((barcodeBoundingBoxLeft - barcodeBoundingBoxRight).abs() +
                (barcodeBoundingBoxTop - barcodeBoundingBoxBottom).abs()) /
            2;

    var distanceFromCamera =
        (4341 / barcodeCenterPoint) - 15.75; //Specifically for redmi Note10S

    var barcodeCenterVector = [
      ((barcodeBoundingBoxLeft + barcodeBoundingBoxRight) / 2),
      ((barcodeBoundingBoxTop + barcodeBoundingBoxBottom) / 2)
    ];

    double mmX = 70 / (barcodeBoundingBoxLeft - barcodeBoundingBoxRight).abs();
    double mmY = 70 / (barcodeBoundingBoxTop - barcodeBoundingBoxBottom).abs();

    qrCodeData.add([
      barcode.value.displayValue,
      barcodeCenterVector,
      distanceFromCamera,
      mmX,
      mmY
    ]);
  }

  //print(qrCodeData);

  if (qrCodeData.length >= 2) {
    for (var i = 0; i < qrCodeData.length; i++) {
      var vectorBetweenBarcodesX, vectorBetweenBarcodesY, disX, disY;
      double;
      int _now = DateTime.now().millisecondsSinceEpoch;

      if (i < 1) {
        vectorBetweenBarcodesX = qrCodeData[i][1][0] - qrCodeData[i + 1][1][0];
        vectorBetweenBarcodesY = qrCodeData[i][1][1] - qrCodeData[i + 1][1][1];
        print(vectorBetweenBarcodesX);
        print(vectorBetweenBarcodesY);

        var x = ((qrCodeData[i][3] + qrCodeData[i + 1][3]) / 2);
        var y = ((qrCodeData[i][4] + qrCodeData[i + 1][4]) / 2);

        disX = dp((x * vectorBetweenBarcodesX), 4);
        disY = dp((y * vectorBetweenBarcodesY), 4);

        print('$disX, $disY');

        var uid = "${qrCodeData[i][0]}_${qrCodeData[i + 1][0]}";

        var qrCodesVector =
            QrCodes(uid: uid, vector: [disX, disY], createdDated: _now);

        qrCodesBox.put(uid, qrCodesVector);
      }
    }
  }
}

 // for (var i = 0; i < qrCodeData.length; i++) {
    //   var vectorBetweenBarcodes;
    //   double disX, disY;
    //   int _now = DateTime.now().millisecondsSinceEpoch;

    //   if (qrCodeData.length - 1 == i) {
    //     vectorBetweenBarcodes = barcodeCenterPoints[i] - barcodeCenterPoints[0];
    //     print(vectorBetweenBarcodes);

    //     disX = dp(
    //         (vectorBetweenBarcodes.dx *
    //             ((milimeterOffsetXY[i].dx + milimeterOffsetXY[0].dx) /
    //                 milimeterOffsetXY.length)),
    //         4);
    //     disY = dp(
    //         (vectorBetweenBarcodes.dy *
    //             ((milimeterOffsetXY[i].dy + milimeterOffsetXY[0].dy) /
    //                 milimeterOffsetXY.length)),
    //         4);
    //     var uid = "${qrCodeData[i][0]}_${qrCodeData[0][0]}";
    //     var qrCodesVector =
    //         QrCodes(uid: uid, vector: [disX, disY], createdDated: _now);
    //     qrCodesBox.put(uid, qrCodesVector);
    //   } else {
    //     vectorBetweenBarcodes =
    //         barcodeCenterPoints[i] - barcodeCenterPoints[i + 1];
    //     disX = dp(
    //         (vectorBetweenBarcodes.dx *
    //             ((milimeterOffsetXY[i].dx + milimeterOffsetXY[0].dx) /
    //                 milimeterOffsetXY.length)),
    //         4);
    //     disY = dp(
    //         (vectorBetweenBarcodes.dy *
    //             ((milimeterOffsetXY[i].dy + milimeterOffsetXY[0].dy) /
    //                 milimeterOffsetXY.length)),
    //         4);
    //     var uid = "${qrCodeData[i][0]}_${qrCodeData[i + 1][0]}";

    //     var qrCodesVector =
    //         QrCodes(uid: uid, vector: [disX, disY], createdDated: _now);

    //     qrCodesBox.put(uid, qrCodesVector);
    //   }
    // }