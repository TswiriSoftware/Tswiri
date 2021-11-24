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

  //var barcodeCenterPoints = []; // Centre co-ordinates of scanned QR codes
  List<QrCode> qrCodes = [];

  //Method to round double values
  double roundDouble(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  for (final Barcode barcode in barcodes) {

    
    if (barcode.value.displayValue != null && barcode.value.boundingBox != null) {

    Point barcodeCenterPoint = Point(
      (barcode.value.boundingBox!.left + barcode.value.boundingBox!.right)/2,
      (barcode.value.boundingBox!.top + barcode.value.boundingBox!.bottom)/2
    );

    QrCode qrCode = QrCode(barcode.value.displayValue!,barcodeCenterPoint);

    
    qrCode.distanceFromCamera = calaculateDistanceFormCamera(barcode.value.boundingBox!,barcodeCenterPoint); //Specifically for redmi Note10S

    qrCodes.add(qrCode);
    }

    else {
      throw Exception('Barcode with null displayvalue or boundingbox detected ');
    }


  }
  //print(qrCodeData);
  if (qrCodes.length >= 2) {

    // for (List<dynamic> qrCode in qrCodes) {
    //   //qrCode
    // };

    // qrCodes.forEach((element) { print(element.);});


    for (var i = 0; i < qrCodes.length; i++) {
      var vectorBetweenBarcodesX, vectorBetweenBarcodesY;
      double disX, disY;
      int _now = DateTime.now().millisecondsSinceEpoch;

      if (i < qrCodes.length - 1) {
        vectorBetweenBarcodesX = qrCodes[i][1][0] - qrCodes[i + 1][1][0];
        vectorBetweenBarcodesY = qrCodes[i][1][1] - qrCodes[i + 1][1][1];

        var x = ((qrCodes[i][3] + qrCodes[i + 1][3]) / 2);
        var y = ((qrCodes[i][4] + qrCodes[i + 1][4]) / 2);

        disX = -roundDouble((x * vectorBetweenBarcodesX), 1);
        disY = -roundDouble((y * vectorBetweenBarcodesY), 1);

        var uid = "${qrCodes[i][0]}_${qrCodes[i + 1][0]}";
        uid.replaceAll(' ', '');

        var qrCodesVector =
            QrCodes(uid: uid, X: disX, Y: disY, createdDated: _now);

        rawDataBox.put(uid, qrCodesVector);
      } else {
        vectorBetweenBarcodesX = qrCodes[i][1][0] - qrCodes[0][1][0];
        vectorBetweenBarcodesY = qrCodes[i][1][1] - qrCodes[0][1][1];

        var x = ((qrCodes[i][3] + qrCodes[0][3]) / 2);
        var y = ((qrCodes[i][4] + qrCodes[0][4]) / 2);

        disX = -roundDouble((x * vectorBetweenBarcodesX), 1);
        disY = -roundDouble((y * vectorBetweenBarcodesY), 1);

        var uid = "${qrCodes[i][0]}_${qrCodes[0][0]}";
        uid.replaceAll(' ', '');
        var qrCodesVector =
            QrCodes(uid: uid, X: disX, Y: disY, createdDated: _now);
            //UID 1_2 , 

        rawDataBox.put(uid, qrCodesVector);
      }
    }
  }
}

double calaculateDistanceFormCamera(Rect boundingBox,Point barcodeCenterPoint) {
   var barcodeCenterPoint =
       ((boundingBox.left - boundingBox.right).abs() +
               (boundingBox.top - boundingBox.bottom).abs()) /
           2;
  
  var distanceFromCamera =
      (4341 / barcodeCenterPoint) - 15.75; //Specifically for redmi Note10S

  //TODO: implement calibration lookup table 

  return distanceFromCamera;
}

class QrCode {
  QrCode(@required this.displayValue,@required this.barcodeCenterVector);

  final String displayValue;
  final Point barcodeCenterVector; //TODO: Pixels ??
  late double distanceFromCamera; //Unit: millimetres
  late Point relativePositionalDifference; //Unit: millimetres
}
