// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';
import 'package:fast_immutable_collections/src/base/iterable_extension.dart';
import 'package:fast_immutable_collections/src/imap/map_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/database/raw_data_adapter.dart';
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
) {
  //var barcodeCenterPoints = []; // Centre co-ordinates of scanned QR codes
  Map<String, QrCode> qrCodes = {};
  Map<String, QrCodeVectors> QrCodeVectorsList = {};
  //Method to round double values

  for (final Barcode barcode in barcodes) {
    if (barcode.value.displayValue != null &&
        barcode.value.boundingBox != null) {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      Point barcodeCenterPoint = Point(
          (barcode.value.boundingBox!.left + barcode.value.boundingBox!.right) /
              2,
          (barcode.value.boundingBox!.top + barcode.value.boundingBox!.bottom) /
              2);

      QrCode qrCode =
          QrCode(barcode.value.displayValue!, barcodeCenterPoint, timestamp);

      qrCode.distanceFromCamera = calaculateDistanceFormCamera(
          barcode.value.boundingBox!,
          barcodeCenterPoint); //Specifically for redmi Note10S

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

          Point point = Point(
              QrCodeStart.barcodeCenterVector.x * -1 -
                  QrCodeEnd.barcodeCenterVector.x * -1,
              QrCodeStart.barcodeCenterVector.y -
                  QrCodeEnd.barcodeCenterVector.y);

          var aveDistanceFromCamera =
              (QrCodeStart.distanceFromCamera + QrCodeEnd.distanceFromCamera) /
                  2;
          QrCodeVectors qrCodeVector = QrCodeVectors(
              QrCodeStart.displayValue,
              QrCodeEnd.displayValue,
              point,
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
          x: value.vector.x.toDouble(),
          y: value.vector.y.toDouble(),
          timestamp: value.timestamp);
      rawDataBox.put(key, _qrCodeVectors);
    });
    print('rawDataBox: ${rawDataBox.toMap().toIMap()}');
  }
}

double calaculateDistanceFormCamera(
    Rect boundingBox, Point barcodeCenterPoint) {
  var barcodeCenterPoint = ((boundingBox.left - boundingBox.right).abs() +
          (boundingBox.top - boundingBox.bottom).abs()) /
      2;

  var distanceFromCamera =
      (4341 / barcodeCenterPoint) - 15.75; //Specifically for redmi Note10S

  //TODO: implement calibration lookup table

  return distanceFromCamera;
}

double roundDouble(double val, int places) {
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}
