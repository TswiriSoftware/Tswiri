import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/paintFunctions/simple_paint.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../VisionDetectorViews/painters/coordinates_translator.dart';
import '../../../databaseAdapters/allBarcodes/barcode_data_entry.dart';

class FixedBarcodeDetectorPainter extends CustomPainter {
  FixedBarcodeDetectorPainter(
      this.barcodes, this.absoluteImageSize, this.rotation, this.allBarcodes);
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  List<BarcodeDataEntry> allBarcodes;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

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

        int index = allBarcodes.indexWhere(
            (element) => element.uid.toString() == barcode.value.displayValue);

        canvas.drawPoints(PointMode.polygon, offsetPoints, paint);
        if (index != -1) {
          BarcodeDataEntry currentBarcode = allBarcodes[index];
          if (currentBarcode.isFixed) {
            canvas.drawPoints(PointMode.polygon, offsetPoints,
                paintSimple(Colors.blueAccent, 3));
          }
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
  bool shouldRepaint(FixedBarcodeDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
