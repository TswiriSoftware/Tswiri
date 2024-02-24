import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:tswiri/views/ml_kit/painters/coordinates_translator.dart';

class BarcodeScannerPainter extends CustomPainter {
  BarcodeScannerPainter({
    required this.barcodes,
    required this.imageSize,
    required this.rotation,
    required this.cameraLensDirection,
  });
  final List<Barcode> barcodes;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

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

      cornerPoints.add(cornerPoints.first);
      canvas.drawPoints(
        PointMode.polygon,
        cornerPoints,
        barcodeBorder,
      );

      final left = translateX(
        barcode.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        barcode.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        barcode.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      final background = Paint()..color = const Color(0x99000000);
      TextSpan span = TextSpan(
        text: barcode.displayValue,
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

      final offset = Offset(
        Platform.isAndroid && cameraLensDirection == CameraLensDirection.front
            ? right
            : left,
        top,
      );
      tp.paint(
        canvas,
        offset,
      );
    }
  }

  @override
  bool shouldRepaint(BarcodeScannerPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
