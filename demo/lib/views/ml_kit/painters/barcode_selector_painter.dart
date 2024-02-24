import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:tswiri/views/ml_kit/painters/coordinates_translator.dart';

import 'painter_utils.dart';

class BarcodeSelectorPainter extends CustomPainter {
  BarcodeSelectorPainter({
    required this.barcodes,
    required this.imageSize,
    required this.rotation,
    required this.cameraLensDirection,
    required this.callback,
  });
  final List<Barcode> barcodes;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;
  final void Function(String?) callback;

  final Paint circlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0
    ..color = Colors.lightGreenAccent;

  final Paint barcodeBorder = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0
    ..color = Colors.blue;

  final Paint centerBarcodeColor = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 3.0
    ..color = Colors.greenAccent.withOpacity(0.5);

  @override
  void paint(Canvas canvas, Size size) {
    const circleRadius = 100.0;
    final center = size.center(Offset.zero);
    canvas.drawCircle(center, circleRadius, circlePaint);

    double? distance;
    Barcode? closestBarcode;
    List<Offset>? closestCornerPoints;

    for (var barcode in barcodes) {
      final cornerPoints = <Offset>[];
      for (final point in barcode.cornerPoints) {
        final x = translateX(
          point.x.toDouble(),
          size,
          imageSize,
          rotation,
          cameraLensDirection,
        );
        final y = translateY(
          point.y.toDouble(),
          size,
          imageSize,
          rotation,
          cameraLensDirection,
        );

        cornerPoints.add(Offset(x, y));
      }

      final barcodeCenter = calculateBarcodeCenter(cornerPoints);
      final distanceToCenter = (center - barcodeCenter).distance;

      if (distance == null) {
        distance = distanceToCenter;
        closestBarcode = barcode;
        closestCornerPoints = cornerPoints;
      } else if (distanceToCenter < distance) {
        distance = distanceToCenter;
        closestBarcode = barcode;
        closestCornerPoints = cornerPoints;
      }
    }

    if (closestBarcode == null) return;
    if (closestCornerPoints == null) return;
    if (distance == null) return;

    late final left = translateX(
      closestBarcode!.boundingBox.left,
      size,
      imageSize,
      rotation,
      cameraLensDirection,
    );
    late final top = translateY(
      closestBarcode!.boundingBox.top,
      size,
      imageSize,
      rotation,
      cameraLensDirection,
    );
    late final right = translateX(
      closestBarcode!.boundingBox.right,
      size,
      imageSize,
      rotation,
      cameraLensDirection,
    );

    // Add the first point to close the polygon
    closestCornerPoints.add(closestCornerPoints.first);
    canvas.drawPoints(
      PointMode.polygon,
      closestCornerPoints,
      barcodeBorder,
    );

    final background = Paint()..color = const Color(0x99000000);
    TextSpan span = TextSpan(
      text: closestBarcode.displayValue,
      style: TextStyle(
        color: Colors.lightGreenAccent,
        background: background,
      ),
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
      canvas,
      Offset(
          Platform.isAndroid && cameraLensDirection == CameraLensDirection.front
              ? right
              : left,
          top),
    );

    if (distance >= circleRadius) {
      callback(null);
      return;
    }

    callback(closestBarcode.displayValue);
    Path path = Path();
    path.addPolygon(closestCornerPoints, true);
    canvas.drawPath(path, centerBarcodeColor);
  }

  @override
  bool shouldRepaint(BarcodeSelectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
