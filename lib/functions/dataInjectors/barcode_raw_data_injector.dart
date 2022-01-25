// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/raw_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_pixel_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_relative_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataInjectorFunctions/raw_data_functions.dart';
import 'package:flutter_google_ml_kit/objects/barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/objects/qr_code.dart';
import 'package:flutter_google_ml_kit/objects/qr_code_vectors.dart';
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
  InputImageData inputImageData,
  Box<dynamic> rawDataBox,
  Box<dynamic> lookupTableBox,
) {
  // Size absoluteImageSize = sv.size;
  // InputImageRotation rotation = inputImageData.imageRotation;
  //var barcodeCenterPoints = []; // Centre co-ordinates of scanned QR codes

  Map<String, QrCode> scannedBarcodes = {};
  Map<String, QrCodesOffset> QrCodeVectorsList = {};
  Map lookupTableMap = lookupTableBox.toMap();
  List<double> imageSizesLookupTable = getImageSizes(lookupTableMap);
  //print(imageSizesLookupTable);
  Size size = Size(
      MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

  for (final Barcode barcode in barcodes) {
    if (barcode.value.displayValue != null &&
        barcode.value.boundingBox != null) {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      double barcodePixelSize = getBarcodePixelSize(barcode);
      Offset barcodeCenterOffset =
          calculateBarcodeCenterPoint(barcode, inputImageData, size);
      String displayValue = barcode.value.displayValue!;

      Rect barcodeBoundingBox = Rect.fromLTRB(
          barcode.value.boundingBox!.left,
          barcode.value.boundingBox!.top,
          barcode.value.boundingBox!.right,
          barcode.value.boundingBox!.bottom);

      double distanceFromCamera = calaculateDistanceFormCamera(
          barcodeBoundingBox,
          barcodeCenterOffset,
          lookupTableMap,
          imageSizesLookupTable);

      QrCode qrcode = QrCode(
          displayValue: displayValue,
          barcodeCenterOffset: barcodeCenterOffset,
          barcodePixelSize: barcodePixelSize,
          distanceFromCamera: distanceFromCamera,
          timestamp: timestamp);

      scannedBarcodes.putIfAbsent(qrcode.displayValue, () => qrcode);
    } else {
      throw Exception(
          'Barcode with null displayvalue or boundingbox detected ');
    }
  }

  //print(qrCodeData);
  if (scannedBarcodes.length >= 2) {
    for (var i = 0; i < scannedBarcodes.length; i++) {
      QrCode qrCodeStart = scannedBarcodes.values.elementAt(i);

      for (var k = 0; k < scannedBarcodes.length; k++) {
        if (qrCodeStart.displayValue != i.toString()) {
          QrCode qrCodeEnd = determineEndQrcode(i, scannedBarcodes);
          String startQrCodeDisplayValue = qrCodeStart.displayValue;
          String endQrCodeDisplayValue = qrCodeEnd.displayValue;
          int timestamp = qrCodeStart.timestamp;

          double aveDistanceFromCamera = calcAveDisFromCamera(
              qrCodeStart.distanceFromCamera, qrCodeEnd.distanceFromCamera);

          double avePixelSizeOfBarcodes =
              calculateAvePixelSizeOfBarcodes(qrCodeEnd, qrCodeStart);

          Offset pixelOffsetBetweenPoints =
              calculatePixelOffsetBetweenPoints(qrCodeEnd, qrCodeStart);

          Offset relativeOffsetBetweenPoints =
              calculateRelativeOffsetBetweenBarcodes(
                  pixelOffsetBetweenPoints, avePixelSizeOfBarcodes);
          //print('$qrCodeStart , $qrCodeEnd, $relativeOffsetBetweenPoints');

          QrCodesOffset qrCodeVector = QrCodesOffset(
              startQrCode: startQrCodeDisplayValue,
              endQrCode: endQrCodeDisplayValue,
              relativeOffset: relativeOffsetBetweenPoints,
              distanceFromCamera: aveDistanceFromCamera,
              timestamp: timestamp);

          QrCodeVectorsList.putIfAbsent(
              '${qrCodeStart.displayValue}_${qrCodeEnd.displayValue}',
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
          x: value.relativeOffset.dx,
          y: value.relativeOffset.dy,
          timestamp: value.timestamp);
      rawDataBox.put(key, _qrCodeVectors);
    });
  }
}
