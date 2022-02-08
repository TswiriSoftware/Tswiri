import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../VisionDetectorViews/painters/coordinates_translator.dart';

class BarcodeDetectorPainter extends CustomPainter {
  BarcodeDetectorPainter(this.barcodes, this.absoluteImageSize, this.rotation);
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

      // final boundingBoxLeft = translateX(
      //     barcode.value.boundingBox!.left, rotation, size, absoluteImageSize);
      // final top = translateY(
      //     barcode.value.boundingBox!.top, rotation, size, absoluteImageSize);
      // final right = translateX(
      //     barcode.value.boundingBox!.right, rotation, size, absoluteImageSize);
      // final bottom = translateY(
      //     barcode.value.boundingBox!.bottom, rotation, size, absoluteImageSize);

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

          // Due to possible rotations we need to find the smallest and largest
          top = min(top, y);
          bottom = max(bottom, y);
          left = min(left, x);
          right = max(right, x);
        }
        // Add the first point to close the polygon
        offsetPoints.add(offsetPoints.first);
        canvas.drawPoints(PointMode.polygon, offsetPoints, paint);
      }

      // canvas.drawParagraph(
      //   builder.build()
      //     ..layout(ParagraphConstraints(
      //       width: right - boundingBoxLeft,
      //     )),
      //   Offset(boundingBoxLeft, top),
      // );

      // canvas.drawRect(
      //   Rect.fromLTRB(boundingBoxLeft, top, right, bottom),
      //   paint,
      // );

      // var barcodeCentreX = (boundingBoxLeft + right) / 2;
      // var barcodeCentreY = (top + bottom) / 2;

      // var pointsOfIntrest = [
      //   Offset(barcodeCentreX, barcodeCentreY),
      //   Offset(boundingBoxLeft, top),
      //   Offset(right, top),
      //   Offset(boundingBoxLeft, bottom),
      //   Offset(right, bottom)
      // ];

      //canvas.drawPoints(PointMode.points, pointsOfIntrest, paintRed);
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
