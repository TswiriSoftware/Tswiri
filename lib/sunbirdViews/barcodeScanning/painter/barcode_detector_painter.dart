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

      final boundingBoxLeft = translateX(
          barcode.value.boundingBox!.left, rotation, size, absoluteImageSize);
      final top = translateY(
          barcode.value.boundingBox!.top, rotation, size, absoluteImageSize);
      final right = translateX(
          barcode.value.boundingBox!.right, rotation, size, absoluteImageSize);
      final bottom = translateY(
          barcode.value.boundingBox!.bottom, rotation, size, absoluteImageSize);

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: right - boundingBoxLeft,
          )),
        Offset(boundingBoxLeft, top),
      );

      canvas.drawRect(
        Rect.fromLTRB(boundingBoxLeft, top, right, bottom),
        paint,
      );

      var barcodeCentreX = (boundingBoxLeft + right) / 2;
      var barcodeCentreY = (top + bottom) / 2;

      var pointsOfIntrest = [
        Offset(barcodeCentreX, barcodeCentreY),
        Offset(boundingBoxLeft, top),
        Offset(right, top),
        Offset(boundingBoxLeft, bottom),
        Offset(right, bottom)
      ];

      canvas.drawPoints(PointMode.points, pointsOfIntrest, paintRed);

      // var pxXY = ((boundingBoxLeft - right).abs() + (top - bottom).abs()) / 2;
      //   double distanceFromCamera = calaculateDistanceFormCamera(Rect.fromLTRB(boundingBoxLeft, top, right, bottom),
      //     Offset(barcodeCentreX, barcodeCentreY), lookupTableMap, imageSizesLookupTable);
      // var disZ = (4341 / pxXY) - 15.75;

      // final ParagraphBuilder distanceBuilder = ParagraphBuilder(
      //   ParagraphStyle(
      //       textAlign: TextAlign.left,
      //       fontSize: 16,
      //       textDirection: TextDirection.ltr),
      // );
      // distanceBuilder
      //     .pushStyle(ui.TextStyle(color: Colors.blue, background: background));
      // distanceBuilder.addText('$disZ');
      // distanceBuilder.pop();

      // canvas.drawParagraph(
      //   distanceBuilder.build()
      //     ..layout(const ParagraphConstraints(
      //       width: 1000,
      //     )),
      //   Offset(right, bottom),
      // );
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
