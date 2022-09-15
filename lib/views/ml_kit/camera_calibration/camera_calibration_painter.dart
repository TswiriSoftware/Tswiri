import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:tswiri_database/functions/other/coordinate_translator.dart';

class CameraCalibrationPainter extends CustomPainter {
  CameraCalibrationPainter({
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
      }
    }
  }

  @override
  bool shouldRepaint(CameraCalibrationPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
