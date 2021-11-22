// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/database/raw_data_adapter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

class BarcodeDatabaseInjector {
  BarcodeDatabaseInjector(this.barcodes, this.absoluteImageSize, this.rotation);

  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
}

injectBarcode(
  BuildContext context,
  List<Barcode> barcodes,
  Size absoluteImageSize,
  InputImageRotation rotation,
  Box<dynamic> rawDataBox,
) {
  //print('Hello @049er');
  //print('Hi @Spodeo');

  var barcodeCenterPoints = []; // Centre co-ordinates of scanned QR codes
  var qrCodeData = [];

  //Method to round double values
  double roundDouble(double val, int places) {
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
    // debugPrint(
    //     'qrCodeData: ${barcode.value.displayValue}, ${barcodeCenterVector}, ${distanceFromCamera}, ${mmX}, ${mmY}');
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
      var vectorBetweenBarcodesX, vectorBetweenBarcodesY;
      double disX, disY;
      int _now = DateTime.now().millisecondsSinceEpoch;

      if (i < qrCodeData.length - 1) {
        vectorBetweenBarcodesX = qrCodeData[i][1][0] - qrCodeData[i + 1][1][0];
        vectorBetweenBarcodesY = qrCodeData[i][1][1] - qrCodeData[i + 1][1][1];

        var x = ((qrCodeData[i][3] + qrCodeData[i + 1][3]) / 2);
        var y = ((qrCodeData[i][4] + qrCodeData[i + 1][4]) / 2);

        disX = -roundDouble((x * vectorBetweenBarcodesX), 1);
        disY = -roundDouble((y * vectorBetweenBarcodesY), 1);

        var uid = "${qrCodeData[i][0]}_${qrCodeData[i + 1][0]}";
        uid.replaceAll(' ', '');

        var qrCodesVector =
            QrCodes(uid: uid, X: disX, Y: disY, createdDated: _now);

        rawDataBox.put(uid, qrCodesVector);
      } else {
        vectorBetweenBarcodesX = qrCodeData[i][1][0] - qrCodeData[0][1][0];
        vectorBetweenBarcodesY = qrCodeData[i][1][1] - qrCodeData[0][1][1];

        var x = ((qrCodeData[i][3] + qrCodeData[0][3]) / 2);
        var y = ((qrCodeData[i][4] + qrCodeData[0][4]) / 2);

        disX = -roundDouble((x * vectorBetweenBarcodesX), 1);
        disY = -roundDouble((y * vectorBetweenBarcodesY), 1);

        var uid = "${qrCodeData[i][0]}_${qrCodeData[0][0]}";
        uid.replaceAll(' ', '');
        var qrCodesVector =
            QrCodes(uid: uid, X: disX, Y: disY, createdDated: _now);

        rawDataBox.put(uid, qrCodesVector);
      }
    }
  }
}
