import 'dart:developer';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcode_calculations/calculate_barcode_center_from_corner_points.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
// import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
// import 'package:flutter_google_ml_kit/global_values/global_colours.dart';

import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../../../functions/translating/coordinates_translator.dart';

class TensorPainter extends CustomPainter {
  TensorPainter({
    required this.barcodes,
    required this.absoluteImageSize,
    required this.rotation,
  });
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    Offset topCenter = Offset(centerX, 0);
    Offset botCenter = Offset(centerX, size.height);

    Offset leftCenter = Offset(0, centerY);
    Offset rightCenter = Offset(size.width, centerY);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.lightGreenAccent;

    final Paint gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = sunbirdOrange;

    Offset imageCenter = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(imageCenter, centerX / 2, paint);

    drawMyLinesHorizontal(canvas, topCenter, botCenter, 4, gridPaint);
    drawMyLinesVertical(canvas, leftCenter, rightCenter, 8, gridPaint);

    for (final Barcode barcode in barcodes) {
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

        canvas.drawPoints(
            PointMode.points,
            [calculateCenterFromCornerPoints(offsetPoints)],
            paintSimple(
                color: Colors.lightGreenAccent,
                strokeWidth: 5,
                style: PaintingStyle.stroke));

        canvas.drawPoints(PointMode.polygon, offsetPoints, paint);
      }
    }
  }

  void drawMyLinesHorizontal(
      Canvas canvas, Offset a, Offset b, int k, Paint gridPaint) {
    for (var i = 0; i < k; i++) {
      if (i == 0) {
        canvas.drawLine(
            a,
            b,
            paintSimple(
                color: Colors.blueAccent,
                strokeWidth: 1,
                style: PaintingStyle.stroke));
      } else {
        Offset aOffset = Offset(i * 50, 0) + a;
        Offset bOffset = Offset(i * 50, 0) + b;
        canvas.drawLine(aOffset, bOffset, gridPaint);

        Offset naOffset = Offset(i * -50, 0) + a;
        Offset nbOffset = Offset(i * -50, 0) + b;

        canvas.drawLine(naOffset, nbOffset, gridPaint);
      }
    }
  }

  void drawMyLinesVertical(
      Canvas canvas, Offset a, Offset b, int k, Paint gridPaint) {
    for (var i = 0; i < k; i++) {
      if (i == 0) {
        canvas.drawLine(
            a,
            b,
            paintSimple(
                color: Colors.blueAccent,
                strokeWidth: 1,
                style: PaintingStyle.stroke));
      } else {
        Offset aOffset = Offset(0, i * 50) + a;
        Offset bOffset = Offset(0, i * 50) + b;
        canvas.drawLine(aOffset, bOffset, gridPaint);

        Offset naOffset = Offset(0, i * -50) + a;
        Offset nbOffset = Offset(0, i * -50) + b;

        canvas.drawLine(naOffset, nbOffset, gridPaint);
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
  bool shouldRepaint(TensorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
