import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/objects/barcode_positional_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
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

      double selectedBarcodeDisFromCenter =
          calculateDistanceBetweenOffsets(screenCenterPoint, positionalData);

      if (barcode.value.displayValue == qrcodeID &&
          selectedBarcodeDisFromCenter <= 100) {
        canvas.drawCircle(screenCenterPoint, 100, paintBlue);
      }

      Offset selectedBarcodeVirtualPosition =
          Offset(consolidatedData[qrcodeID]!.x, consolidatedData[qrcodeID]!.y);

      if (consolidatedData.containsKey(barcode.value.displayValue.toString()) &&
          barcode.value.displayValue != qrcodeID) {
        String barcodeID = barcode.value.displayValue.toString();

        Offset virtualScreenCenterPoint =
            (positionalData.center - screenCenterPoint) /
                positionalData.barcodePixelSize;

        Offset virtualBarcodePosition =
            getBarcodeVirtualPosition(barcodeID, consolidatedData);

        Offset virtualOffsetBetweenBarcodes =
            (selectedBarcodeVirtualPosition - virtualBarcodePosition)
                .scale(50, -50);

        Offset centerPointVirtualOffset =
            virtualBarcodePosition - virtualScreenCenterPoint;

        Offset centerToSelectedBarcodeVirtualOffset =
            centerPointVirtualOffset + virtualOffsetBetweenBarcodes;

        canvas.drawLine(screenCenterPoint,
            screenCenterPoint + centerToSelectedBarcodeVirtualOffset, paint);

        Rect rect =
            Rect.fromCenter(center: screenCenterPoint, width: 200, height: 200);
        double startAngle =
            centerToSelectedBarcodeVirtualOffset.direction - (pi / 6);
        double sweepAngle = pi / 3;
        canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

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

  Offset getBarcodeVirtualPosition(
      String barcodeID, Map<String, vm.Vector2> consolidatedData) {
    return Offset(
        consolidatedData[barcodeID]!.x, consolidatedData[barcodeID]!.y);
  }

  double calculateDistanceBetweenOffsets(
          Offset offset1, BarcodePositionalData offset2) =>
      (offset1 - offset2.center).distance;

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
