import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcode_calculations/calculate_barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';

import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../functions/translating/coordinates_translator.dart';

class SingleBarcodeScannerPainter extends CustomPainter {
  SingleBarcodeScannerPainter({
    required this.barcodes,
    required this.absoluteImageSize,
    required this.rotation,
    //required this.allBarcodes,
    this.barcodeID,
  });
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  // List<BarcodeDataEntry> allBarcodes;
  final String? barcodeID;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint background = Paint()..color = const Color(0x99000000);

    Offset imageCenter = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(imageCenter, 100, paint);

    for (final Barcode barcode in barcodes) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(ui.TextStyle(
          color: Colors.lightGreenAccent, background: background, fontSize: 9));
      builder.addText('${barcode.value.displayValue}');
      builder.pop();

      var cornerPoints = barcode.value.cornerPoints;
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

        //Offset centerPoint = calculateCenterFromCornerPoints(offsetPoints);

        canvas.drawParagraph(
          builder.build()..layout(const ParagraphConstraints(width: 100)),
          offsetPoints.first,
        );

        canvas.drawPoints(PointMode.polygon, offsetPoints, paint);
        if (barcodeID == barcode.value.displayValue) {
          canvas.drawPoints(
              PointMode.polygon, offsetPoints, paintEasy(Colors.blueAccent, 3));
        } else {
          canvas.drawPoints(
              PointMode.polygon, offsetPoints, paintEasy(springGreen, 3));
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
  bool shouldRepaint(SingleBarcodeScannerPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
