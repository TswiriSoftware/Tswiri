import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcode_calculations/calculate_barcode_center_from_corner_points.dart';
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

    // Offset topCenter = Offset(centerX, 0);
    // Offset botCenter = Offset(centerX, size.height);

    // Offset leftCenter = Offset(0, centerY);
    // Offset rightCenter = Offset(size.width, centerY);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.lightGreenAccent;
    final Paint paint5 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..color = Colors.lightGreenAccent;

    final Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = sunbirdOrange;

    final Paint paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.blue;

    // Offset imageCenter = Offset(size.width / 2, size.height / 2);

    // canvas.drawCircle(imageCenter, centerX / 2, paint);

    // drawMyLinesHorizontal(canvas, topCenter, botCenter, 4, gridPaint);
    // drawMyLinesVertical(canvas, leftCenter, rightCenter, 8, gridPaint);

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
        canvas.drawPoints(PointMode.polygon, offsetPoints, paint);
        canvas.drawPoints(PointMode.points,
            [calculateCenterFromCornerPoints(offsetPoints)], paint5);
      }
    }

    // double xCenter = size.width / 2;
    // double yCenter = size.height / 2;

    Offset centerTop = Offset(centerX, 0);
    Offset centerBot = Offset(centerX, size.height);
    canvas.drawLine(centerTop, centerBot, paint3);

    Offset centerLeft = Offset(0, centerY);
    Offset centerRight = Offset(size.width, centerY);
    canvas.drawLine(centerLeft, centerRight, paint3);

    for (var i = 1; i < 4; i++) {
      Offset top = centerTop + Offset((50 * i).toDouble(), 0);
      Offset bot = centerBot + Offset((50 * i).toDouble(), 0);
      canvas.drawLine(top, bot, paint2);
      Offset ntop = centerTop + Offset((-50 * i).toDouble(), 0);
      Offset nbot = centerBot + Offset((-50 * i).toDouble(), 0);
      canvas.drawLine(ntop, nbot, paint2);
    }

    for (var i = 1; i < 8; i++) {
      Offset top = centerLeft + Offset(0, (50 * i).toDouble());
      Offset bot = centerRight + Offset(0, (50 * i).toDouble());
      canvas.drawLine(top, bot, paint2);
      Offset ntop = centerLeft + Offset(0, (-50 * i).toDouble());
      Offset nbot = centerRight + Offset(0, (-50 * i).toDouble());
      canvas.drawLine(ntop, nbot, paint2);
    }
  }

  @override
  bool shouldRepaint(TensorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
