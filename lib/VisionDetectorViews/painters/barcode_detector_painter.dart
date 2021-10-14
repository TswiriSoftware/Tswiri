import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'coordinates_translator.dart';

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

    final Paint background = Paint()..color = Color(0x99000000);

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

      final left = translateX(
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
            width: right - left,
          )),
        Offset(left, top),
      );

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );

      var X = (left + right) / 2;
      var Y = (top + bottom) / 2;

      var centre = [
        new Offset(X, Y),
        new Offset(left, top),
        new Offset(right, top),
        new Offset(left, bottom),
        new Offset(right, bottom)
      ];

      canvas.drawPoints(PointMode.points, centre, paintRed);

      //Builder for Centre text
      final ParagraphBuilder builder2 = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );
      builder2
          .pushStyle(ui.TextStyle(color: Colors.red, background: background));
      builder2.addText('${X} , ${Y}');
      builder2.pop();

      canvas.drawParagraph(
        builder2.build()
          ..layout(ParagraphConstraints(
            width: right - left,
          )),
        Offset(X, Y),
      );

      if (barcodes.length >= 2) {
        print('QRCode Value: ${barcode.value.displayValue}');
        print('QR Left: ${left}');
        print('QR Top:${top}');
        print('QR Right:${right}');
        print('QR Bottom:${bottom}');
      }
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
