import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/objects/barcode_positional_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'coordinates_translator.dart';
import 'package:vector_math/vector_math.dart' as vm;

class BarcodeDetectorPainterNavigation extends CustomPainter {
  BarcodeDetectorPainterNavigation(this.barcodes, this.absoluteImageSize,
      this.rotation, this.consolidatedData, this.qrcodeID);
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final Map<String, vm.Vector2> consolidatedData;
  final String qrcodeID;

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

      Offset selectedBarcodeStoredPosition =
          Offset(consolidatedData[qrcodeID]!.x, consolidatedData[qrcodeID]!.y);

      if (consolidatedData.containsKey(barcode.value.displayValue.toString()) &&
          barcode.value.displayValue != qrcodeID) {
        String barcodeID = barcode.value.displayValue.toString();

        Offset storedBarcodePosition = Offset(
            consolidatedData[barcode.value.displayValue]!.x,
            consolidatedData[barcode.value.displayValue]!.y);

        Offset directionalOffset =
            (selectedBarcodeStoredPosition - storedBarcodePosition) * 100;

        canvas.drawLine(positionalData.center,
            directionalOffset + positionalData.center, paint);

        // Rect rect =
        //     Rect.fromCenter(center: screenCenterPoint, width: 200, height: 200);
        // double startAngle = a.direction - (pi / 3);
        // double sweepAngle = pi / 2;
        // canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

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

  Offset calculateRelativeBarcodePosition(
      String barcodeID, double barcodePixelSize) {
    return (Offset(
            consolidatedData[barcodeID]!.x, consolidatedData[barcodeID]!.y) *
        barcodePixelSize);
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainterNavigation oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
