import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/coordinates_translator.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:vector_math/vector_math.dart' as math;

class BarcodeDatabaseInjector {
  BarcodeDatabaseInjector(this.barcodes, this.absoluteImageSize, this.rotation);

  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
}

void injectBarcode(List<Barcode> barcodes, Size absoluteImageSize,
    InputImageRotation rotation, var box) {
  print('Hello @049er');
  print('Hi @Spodeo');

  var centerOfBarcode = []; // Centre co-ordinates of scanned QR codes
  var milimeterXYOfbarcode = []; //Offset With the mm value of X and Y
  var absVectors = [];
  var summary = [];

  @override
  void data(Size size) {
    var centers = []; // Centre co-ordinates of scanned QR codes
    var mmXY = []; //Offset With the mm value of X and Y
    var absVectors = [];
    var summary = [];

//TODO@049er: implement functionality
    for (final Barcode barcode in barcodes) {
      final barcodeLeft = translateX(
          barcode.value.boundingBox!.left, rotation, size, absoluteImageSize);
      final barcodeTop = translateY(
          barcode.value.boundingBox!.top, rotation, size, absoluteImageSize);
      final barcodeRight = translateX(
          barcode.value.boundingBox!.right, rotation, size, absoluteImageSize);
      final barcodeBottom = translateY(
          barcode.value.boundingBox!.bottom, rotation, size, absoluteImageSize);

      var barcodeCentreX = (barcodeLeft + barcodeRight) / 2;
      var barcodeCentreY = (barcodeTop + barcodeBottom) / 2;

      centers.add(Offset(barcodeCentreX, barcodeCentreY));

      // Distance from camera calculation
      if (barcodes.length >= 2) {
        var mmBarcodeCentreX = 70 / (barcodeLeft - barcodeRight).abs();
        var mmBarcodeCentreY = 70 / (barcodeTop - barcodeBottom).abs();
        mmXY.add(Offset(mmBarcodeCentreX, mmBarcodeCentreY));
      }

      var pxXY = ((barcodeLeft - barcodeRight).abs() +
              (barcodeTop - barcodeBottom).abs()) /
          2;
      var distanceFromCamera =
          (4341 / pxXY) - 15.75; //Specifically for redmi Note10S

      int _now = DateTime.now().millisecondsSinceEpoch;
      summary.add([
        barcode.value.displayValue, //Barcode Value
        math.Vector2(barcodeCentreX, barcodeCentreY), //Barcode Centre
        distanceFromCamera, //Distance from Camera in mm
        _now //Timestamp
      ]);
    }

    if (centers.length >= 2) {
      print("Summary: ${summary}");
      for (var i = 0; i < summary.length; i++) {
        var dXY, disX, disY;
        int _now = DateTime.now().millisecondsSinceEpoch;

        if (summary.length - 1 == i) {
          dXY = centers[i] - centers[0];
          disX = (dXY.dx * ((mmXY[i].dx + mmXY[0].dx) / mmXY.length));
          disY = (dXY.dy * ((mmXY[i].dy + mmXY[0].dy) / mmXY.length));
          var uid = "${i}_${0}";
          if (absVectors.contains(uid)) {
            absVectors.remove(uid);
            absVectors.add([uid, math.Vector2(disX, disY), _now]);
          } else {
            absVectors.add([uid, math.Vector2(disX, disY), _now]);
          }
        } else {
          dXY = centers[i] - centers[i + 1];
          disX = (dXY.dx * ((mmXY[i].dx + mmXY[i + 1].dx) / mmXY.length));
          disY = (dXY.dy * ((mmXY[i].dy + mmXY[i + 1].dy) / mmXY.length));
          var uid = "${i}_${i + 1}";

          if (absVectors.contains(uid)) {
            absVectors.remove(uid);
            absVectors.add([uid, math.Vector2(disX, disY), _now]);
          } else {
            absVectors.add([uid, math.Vector2(disX, disY), _now]);
          }
        }
      }
      print(absVectors);
    }
  }
}
