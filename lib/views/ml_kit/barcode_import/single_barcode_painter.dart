import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:tswiri_database/functions/other/coordinate_translator.dart';

class BarcodeImportPainter extends CustomPainter {
  BarcodeImportPainter({
    required this.barcodes,
    required this.absoluteImageSize,
    required this.rotation,
  });
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint background = Paint()..color = const Color(0x99000000);

    for (final Barcode barcode in barcodes) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );

      builder.pushStyle(ui.TextStyle(
          color: Colors.lightGreenAccent, background: background, fontSize: 9));
      builder.addText('${barcode.displayValue}');
      builder.pop();

      var cornerPoints = barcode.cornerPoints;
      if (cornerPoints != null) {
        List<Offset> offsetPoints = <Offset>[];

        for (var point in cornerPoints) {
          double x =
              translateX(point.x.toDouble(), rotation, size, absoluteImageSize);
          double y =
              translateY(point.y.toDouble(), rotation, size, absoluteImageSize);

          offsetPoints.add(Offset(x, y));
        }
        offsetPoints.add(offsetPoints.first);

        canvas.drawParagraph(
          builder.build()..layout(const ParagraphConstraints(width: 100)),
          offsetPoints.first,
        );

        canvas.drawPoints(PointMode.polygon, offsetPoints, paint);
      }
    }
  }

  TextPainter text(String text) {
    TextSpan span = TextSpan(
        style: const TextStyle(color: Colors.red, fontSize: 5), text: text);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    return tp;
  }

  @override
  bool shouldRepaint(BarcodeImportPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}

Offset calculateBarcodeCenter(List<Offset> offsetPoints) {
  return (offsetPoints[0] +
          offsetPoints[1] +
          offsetPoints[2] +
          offsetPoints[3]) /
      4;
}
