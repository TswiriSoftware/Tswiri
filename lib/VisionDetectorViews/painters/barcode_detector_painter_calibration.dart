import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'coordinates_translator.dart';

class BarcodeDetectorPainterCalibration extends CustomPainter {
  BarcodeDetectorPainterCalibration(
      this.barcodes, this.absoluteImageSize, this.rotation);
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint paintRed = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..color = Colors.red;

    final Paint background = Paint()..color = const Color(0x99000000);

    for (final Barcode barcode in barcodes) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));
      builder.addText('${barcode.value.displayValue}');
      builder.pop();

      final boundingBoxLeft = translateX(
          barcode.value.boundingBox!.left, rotation, size, absoluteImageSize);
      final boundingBoxTop = translateY(
          barcode.value.boundingBox!.top, rotation, size, absoluteImageSize);
      final boundingBoxRight = translateX(
          barcode.value.boundingBox!.right, rotation, size, absoluteImageSize);
      final boundingBoxBottom = translateY(
          barcode.value.boundingBox!.bottom, rotation, size, absoluteImageSize);

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: boundingBoxRight - boundingBoxLeft,
          )),
        Offset(boundingBoxLeft, boundingBoxTop),
      );

      canvas.drawRect(
        Rect.fromLTRB(boundingBoxLeft, boundingBoxTop, boundingBoxRight,
            boundingBoxBottom),
        paint,
      );

      var barcodeCentreX = (boundingBoxLeft + boundingBoxRight) / 2;
      var barcodeCentreY = (boundingBoxTop + boundingBoxBottom) / 2;

      var pointsOfIntrest = [
        Offset(barcodeCentreX, barcodeCentreY),
        Offset(boundingBoxLeft, boundingBoxTop),
        Offset(boundingBoxRight, boundingBoxTop),
        Offset(boundingBoxLeft, boundingBoxBottom),
        Offset(boundingBoxRight, boundingBoxBottom)
      ];

      canvas.drawPoints(PointMode.points, pointsOfIntrest, paintRed);
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainterCalibration oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
