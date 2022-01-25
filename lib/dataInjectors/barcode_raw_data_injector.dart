// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/raw_data_adapter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

import 'objects.dart';

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
  Box<dynamic> lookuptable,
) {
  //var barcodeCenterPoints = []; // Centre co-ordinates of scanned QR codes
  rotation = InputImageRotation.Rotation_180deg;
  Map<String, QrCode> qrCodes = {};
  Map<String, QrCodeVectors> QrCodeVectorsList = {};
  List<double> imageSizes = [];
  var lookupTable = lookuptable.toMap();

  lookupTable.forEach((key, value) {
    double test = double.parse(key);
    imageSizes.add(test);
  });

  //Method to round double values

  for (final Barcode barcode in barcodes) {
    if (barcode.value.displayValue != null &&
        barcode.value.boundingBox != null) {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      double barcodePixelSize =
          ((barcode.value.boundingBox!.left - barcode.value.boundingBox!.right)
                      .abs() +
                  (barcode.value.boundingBox!.top -
                          barcode.value.boundingBox!.bottom)
                      .abs()) /
              2;
      Offset barcodeCenterPoint = Offset(
          (barcode.value.boundingBox!.left + barcode.value.boundingBox!.right) /
              2,
          (barcode.value.boundingBox!.top + barcode.value.boundingBox!.bottom) /
              2);

      QrCode qrCode = QrCode(barcode.value.displayValue!, barcodeCenterPoint,
          barcodePixelSize, timestamp);

      qrCode.distanceFromCamera = calaculateDistanceFormCamera(
          barcode.value.boundingBox!,
          barcodeCenterPoint,
          lookupTable,
          imageSizes); //Specifically for redmi Note10S

      qrCodes.putIfAbsent(qrCode.displayValue, () => qrCode);
    } else {
      throw Exception(
          'Barcode with null displayvalue or boundingbox detected ');
    }
  }
  //print(qrCodeData);
  if (qrCodes.length >= 2) {
    for (var i = 0; i < qrCodes.length; i++) {
      QrCode QrCodeEnd;
      QrCode QrCodeStart = qrCodes.values.elementAt(i);
      //print(QrCodeStart);
      for (var k = 0; k < qrCodes.length; k++) {
        if (QrCodeStart.displayValue != i.toString()) {
          if (i != qrCodes.length - 1) {
            QrCodeEnd = qrCodes.values.elementAt(i + 1);
          } else {
            QrCodeEnd = qrCodes.values.elementAt(0);
          }

          var aveDistanceFromCamera =
              (QrCodeStart.distanceFromCamera + QrCodeEnd.distanceFromCamera) /
                  2;

          double actualOffsetDistanceQuotient = 1 /
              ((QrCodeEnd.barcodePixelSize + QrCodeStart.barcodePixelSize) /
                  2); //70mm assumed barcode size

          Offset offsetBetweenBarcodes = (QrCodeEnd.barcodeCenterVector -
                  QrCodeStart.barcodeCenterVector) *
              actualOffsetDistanceQuotient;

          QrCodeVectors qrCodeVector = QrCodeVectors(
              QrCodeStart.displayValue,
              QrCodeEnd.displayValue,
              Offset(offsetBetweenBarcodes.dx, offsetBetweenBarcodes.dy),
              aveDistanceFromCamera,
              QrCodeStart.timestamp);

          QrCodeVectorsList.putIfAbsent(
              '${QrCodeStart.displayValue}_${QrCodeEnd.displayValue}',
              () => qrCodeVector);
        }
      }
    }
    //print(QrCodeVectorsList.values.toIList());
    QrCodeVectorsList.forEach((key, value) {
      RelativeQrCodes _qrCodeVectors = RelativeQrCodes(
          uid: key,
          uidStart: value.startQrCode,
          uidEnd: value.endQrCode,
          x: value.vector.dx,
          y: value.vector.dy,
          timestamp: value.timestamp);
      rawDataBox.put(key, _qrCodeVectors);
    });
    print('rawDataBox: ${rawDataBox.toMap()}');
  }
}

double calaculateDistanceFormCamera(Rect boundingBox, Offset barcodeCenterPoint,
    var lookupTable, List<double> imageSizes) {
  double imageSize = (((boundingBox.left - boundingBox.right).abs() +
          (boundingBox.top - boundingBox.bottom).abs()) /
      2);

  var greaterThan = imageSizes.where((element) => element >= imageSize).toList()
    ..sort();

  String imageSizeKey = greaterThan.first.toString();

  double distanceFromCamera =
      double.parse(lookupTable[imageSizeKey].toString().split(',').last);

  //print(distanceFromCamera);
  return distanceFromCamera;
}

double roundDouble(double val, int places) {
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}
