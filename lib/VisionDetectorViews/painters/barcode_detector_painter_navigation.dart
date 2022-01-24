import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/data_manipulation/calculate_barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/objects/barcode_positional_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'coordinates_translator.dart';
import 'package:vector_math/vector_math.dart' as vm;

class BarcodeDetectorPainterNavigation extends CustomPainter {
  BarcodeDetectorPainterNavigation(this.barcodes, this.absoluteImageSize,
      this.rotation, this.consolidatedData, this.qrcodeID, this.context);
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final Map<String, vm.Vector2> consolidatedData;
  final String qrcodeID;
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint paintRed = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red;

    final Paint pointer = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red;

    final Paint paintBlue = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.blue;

    final Paint background = Paint()..color = const Color(0x99000000);
    double width = MediaQuery.of(context).size.width / 2;
    double height = MediaQuery.of(context).size.height / 2.5;
    Offset screenCenterPoint = Offset(size.width / 2, size.height / 2);

    final ParagraphBuilder builder = ParagraphBuilder(
      ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 20,
          textDirection: TextDirection.ltr),
    );
    canvas.drawCircle(screenCenterPoint, 100, paintRed);

    for (final Barcode barcode in barcodes) {
      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));
      builder.addText('${barcode.value.displayValue}');
      builder.pop();

      BarcodePositionalData positionalData = calculateBarcodePositionalData(
          barcode, rotation, size, absoluteImageSize);

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
              width: positionalData.topRight.dx - positionalData.topLeft.dx)),
        positionalData.center,
      );

      var pointsOfIntrest = [
        positionalData.topLeft,
        positionalData.topRight,
        positionalData.bottomLeft,
        positionalData.bottomRight,
      ];

      double selectedBarcodeDisFromCenter =
          (screenCenterPoint - positionalData.center).distance;
      if (barcode.value.displayValue == qrcodeID &&
          selectedBarcodeDisFromCenter <= 100) {
        canvas.drawCircle(screenCenterPoint, 100, paintBlue);
      }

      Offset selectedBarcodePosition = (Offset(
              consolidatedData[qrcodeID]!.x, consolidatedData[qrcodeID]!.y) *
          positionalData.barcodePixelSize);

      if (consolidatedData.containsKey(barcode.value.displayValue.toString()) &&
          barcode.value.displayValue != qrcodeID) {
        Offset barcodeCenterPoint = Offset(
                consolidatedData[barcode.value.displayValue]!.x,
                consolidatedData[barcode.value.displayValue]!.y) *
            positionalData.barcodePixelSize /
            10;

        print('screen center: $screenCenterPoint');

        canvas.drawLine(
            positionalData.center,
            (selectedBarcodePosition - barcodeCenterPoint) +
                positionalData.center,
            paintBlue);

        //Code Here
      } else if (barcode.value.displayValue == qrcodeID) {
        canvas.drawPath(
            Path()
              ..addPolygon([
                positionalData.topLeft,
                positionalData.topRight,
                positionalData.bottomRight,
                positionalData.bottomLeft
              ], true),
            paint);
      }
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainterNavigation oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}

 // var vector1 = consolidatedData[barcode.value.displayValue];
        // var vector2 = consolidatedData[qrcodeID];
        // vm.Vector2 guideVector = vector2! - vector1!;
        // double gradient = guideVector.y / -guideVector.x;
        // double unitVectorQ = sqrt(pow(vector2.x, 2) + pow(vector2.y, 2));
        // vm.Vector2 unitVector = vector2 / unitVectorQ;
        // print('guideVector: $unitVector');

        // Offset p1 = Offset(barcodeCentreX, barcodeCentreY);
        // Offset p2 = Offset(barcodeCentreX, barcodeCentreY);

        // if (guideVector.x < 0 && guideVector.y < 0) {
        //   p2 = Offset((barcodeCentreX + (50 / gradient)),
        //       (barcodeCentreY + -gradient * 50));
        // } else if (guideVector.x < 0 && guideVector.y > 0) {
        //   p2 = Offset((barcodeCentreX + (50 / -gradient)),
        //       (barcodeCentreY + -gradient * 50));
        // } else if (guideVector.x > 0 && guideVector.y > 0) {
        //   p2 = Offset((barcodeCentreX + (50 / -gradient)),
        //       (barcodeCentreY + gradient * 50));
        // } else if (guideVector.x > 0 && guideVector.y < 0) {
        //   p2 = Offset((barcodeCentreX + (50 / gradient)),
        //       (barcodeCentreY + gradient * 50));
        // }
        // canvas.drawLine(p1, p2, pointer);