import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart' as vm;
import 'coordinates_translator.dart';

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
      ..strokeWidth = 8.0
      ..color = Colors.red;

    final Paint pointer = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red;

    final Paint background = Paint()..color = const Color(0x99000000);
    for (final Barcode barcode in barcodes) {
      Offset endPoint = Offset(0, 0);

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
      final boundingBoxTop = translateY(
          barcode.value.boundingBox!.top, rotation, size, absoluteImageSize);
      final boundingBoxRight = translateX(
          barcode.value.boundingBox!.right, rotation, size, absoluteImageSize);
      final boundingBoxBottom = translateY(
          barcode.value.boundingBox!.bottom, rotation, size, absoluteImageSize);

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: boundingBoxRight - boundingBoxLeft,
          )),
        Offset(boundingBoxLeft, boundingBoxTop),
      );

      var barcodeCentreX = (boundingBoxLeft + boundingBoxRight) / 2;
      var barcodeCentreY = (boundingBoxTop + boundingBoxBottom) / 2;

      var pointsOfIntrest = [
        Offset(barcodeCentreX, barcodeCentreY),
        Offset(boundingBoxLeft, boundingBoxTop),
        Offset(boundingBoxRight, boundingBoxTop),
        Offset(boundingBoxLeft, boundingBoxBottom),
        Offset(boundingBoxRight, boundingBoxBottom)
      ];

      if (consolidatedData.containsKey(barcode.value.displayValue.toString()) &&
          barcode.value.displayValue != qrcodeID) {
        var vector1 = consolidatedData[barcode.value.displayValue];
        var vector2 = consolidatedData[qrcodeID];
        vm.Vector2 guideVector = vector2! - vector1!;
        double gradient = guideVector.y / -guideVector.x;
        double unitVectorQ = sqrt(pow(vector2.x, 2) + pow(vector2.y, 2));
        vm.Vector2 unitVector = vector2 / unitVectorQ;
        print('guideVector: $unitVector');

        Offset p1 = Offset(barcodeCentreX, barcodeCentreY);
        Offset p2 = Offset(barcodeCentreX, barcodeCentreY);

        if (guideVector.x < 0 && guideVector.y < 0) {
          p2 = Offset((barcodeCentreX + (50 / gradient)),
              (barcodeCentreY + -gradient * 50));
        } else if (guideVector.x < 0 && guideVector.y > 0) {
          p2 = Offset((barcodeCentreX + (50 / -gradient)),
              (barcodeCentreY + -gradient * 50));
        } else if (guideVector.x > 0 && guideVector.y > 0) {
          p2 = Offset((barcodeCentreX + (50 / -gradient)),
              (barcodeCentreY + gradient * 50));
        } else if (guideVector.x > 0 && guideVector.y < 0) {
          p2 = Offset((barcodeCentreX + (50 / gradient)),
              (barcodeCentreY + gradient * 50));
        }
        canvas.drawLine(p1, p2, pointer);
      } else if (barcode.value.displayValue == qrcodeID) {
        canvas.drawRect(
          Rect.fromLTRB(boundingBoxLeft, boundingBoxTop, boundingBoxRight,
              boundingBoxBottom),
          pointer,
        );
      }

      canvas.drawPoints(PointMode.points, pointsOfIntrest, paintRed);
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainterNavigation oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
