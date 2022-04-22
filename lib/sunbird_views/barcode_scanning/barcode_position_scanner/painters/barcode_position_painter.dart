import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';

import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../../functions/coordinate_translator/coordinates_translator.dart';

class BarcodePositionPainter extends CustomPainter {
  BarcodePositionPainter({
    required this.barcodes,
    required this.absoluteImageSize,
    required this.rotation,
    required this.barcodesToScan,
    required this.gridMarkers,
  });
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final List<String> barcodesToScan;
  final List<String> gridMarkers;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint background = Paint()..color = const Color(0x99000000);

    for (final Barcode barcode in barcodes) {
      //Text to display barcode display value.
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

      double left = double.infinity;
      double top = double.infinity;
      double right = double.negativeInfinity;
      double bottom = double.negativeInfinity;

      var cornerPoints = barcode.value.cornerPoints;
      if (cornerPoints == null) {
        left = translateX(
            barcode.value.boundingBox!.left, rotation, size, absoluteImageSize);
        top = translateY(
            barcode.value.boundingBox!.top, rotation, size, absoluteImageSize);
        right = translateX(barcode.value.boundingBox!.right, rotation, size,
            absoluteImageSize);
        bottom = translateY(barcode.value.boundingBox!.bottom, rotation, size,
            absoluteImageSize);

        // Draw a bounding rectangle around the barcode
        canvas.drawRect(
          Rect.fromLTRB(left, top, right, bottom),
          paint,
        );
      } else {
        List<Offset> offsetPoints = <Offset>[];

        for (var point in cornerPoints) {
          double x =
              translateX(point.x.toDouble(), rotation, size, absoluteImageSize);
          double y =
              translateY(point.y.toDouble(), rotation, size, absoluteImageSize);

          offsetPoints.add(Offset(x, y));
        }
        // Add the first point to close the polygon.
        offsetPoints.add(offsetPoints.first);

        //Draw red outline if barcode is not in scan list.
        canvas.drawPoints(
            PointMode.polygon, offsetPoints, paintSimple(Colors.redAccent, 1));
        String barcodeValue = barcode.value.displayValue ?? '';

        if (barcodesToScan.contains(barcodeValue) &&
            !gridMarkers.contains(barcodeValue)) {
          //Draw green line for a normal barcode.
          canvas.drawPoints(PointMode.polygon, offsetPoints,
              paintSimple(Colors.lightGreenAccent, 2));
        } else if (gridMarkers.contains(barcodeValue)) {
          //Draw a blue line for markers.
          canvas.drawPoints(
              PointMode.polygon, offsetPoints, paintSimple(Colors.blue, 2));
        }
      }
    }
  }

  TextPainter text(String text) {
    TextSpan span =
        TextSpan(style: const TextStyle(color: Colors.red), text: text);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    return tp;
  }

  @override
  bool shouldRepaint(BarcodePositionPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
