import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/global_values/barcode_colors.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/objects/navigation/painter_message.dart';

Offset? averageOffsetToBarcode;

class NavigatorPainter extends CustomPainter {
  NavigatorPainter({
    required this.message,
    required this.containerEntry,
  });
  // ignore: prefer_typing_uninitialized_variables
  final message;
  final ContainerEntry containerEntry;
  Paint selectedBarcodeColor = paintEasy(barcodeFocusColor, 3.0);
  Paint defaultarcodeColor = paintEasy(barcodeDefaultColor, 3.0);

  @override
  void paint(Canvas canvas, Size size) {
    PainterMesssage painterMesssage = PainterMesssage.fromMessage(message);

    Offset screenCenter = Offset(
      size.width / 2,
      size.height / 2,
    );

    for (PainterBarcodeObject barcodeCornerPoints
        in painterMesssage.painterData) {
      if (barcodeCornerPoints.barcodeUID == containerEntry.barcodeUID) {
        canvas.drawPoints(
          PointMode.polygon,
          barcodeCornerPoints.conrnerPoints,
          selectedBarcodeColor,
        );
      }
    }

    double finderCircleRadius = painterMesssage.averageDiagonalLength / 3;
    //log('averageOffsetToBarcode ' + averageOffsetToBarcode.toString());
    if (painterMesssage.averageOffsetToBarcode.distance <= finderCircleRadius) {
      //Draw Finder Circle
      canvas.drawCircle(
          screenCenter,
          finderCircleRadius,
          paintSimple(
              color: Colors.greenAccent,
              strokeWidth: 2.0,
              style: PaintingStyle.stroke));
    } else {
      //Draw Finder Circle
      canvas.drawCircle(
          screenCenter,
          finderCircleRadius,
          paintSimple(
              color: Colors.redAccent,
              strokeWidth: 2.0,
              style: PaintingStyle.stroke));
    }

    if (painterMesssage.averageOffsetToBarcode != const Offset(0, 0) &&
        painterMesssage.averageOffsetToBarcode.distance >= finderCircleRadius) {
      averageOffsetToBarcode = painterMesssage.averageOffsetToBarcode;
      //log('averageOffsetToBarcode Set ' + averageOffsetToBarcode.toString());
      drawArrow(screenCenter, finderCircleRadius,
          painterMesssage.averageOffsetToBarcode, size, canvas);
    } else {
      if (averageOffsetToBarcode != null) {
        drawArrow(screenCenter, finderCircleRadius, averageOffsetToBarcode!,
            size, canvas);
      }
    }
  }

  void drawArrow(Offset screenCenter, double finderCircleRadius,
      Offset averageOffsetToBarcode, Size size, Canvas canvas) {
    if (averageOffsetToBarcode.dx > finderCircleRadius) {
      //Draw arrow
      //Start position of the arrow line.
      Offset arrowLineStart =
          Offset(screenCenter.dx + finderCircleRadius, screenCenter.dy);

      //End position of the arrow line
      Offset arrowLineHead = Offset(
          arrowLineStart.dx +
              averageOffsetToBarcode.distance -
              finderCircleRadius,
          screenCenter.dy);

      //Confine arrow to screen size.
      if (arrowLineHead.dx > (size.width)) {
        arrowLineHead = Offset(
            arrowLineStart.dx + (size.width / 2) - finderCircleRadius,
            screenCenter.dy);
      }

      //ArrowHeadtop
      Offset arrowHeadtop =
          Offset(arrowLineHead.dx - 30, arrowLineHead.dy + 20);

      //ArrowHeadBottom
      Offset arrowHeadbottom =
          Offset(arrowLineHead.dx - 30, arrowLineHead.dy - 20);

      //Translate canvas to screen center.
      canvas.translate(screenCenter.dx, screenCenter.dy);
      //Rotate the canvas.
      canvas.rotate(averageOffsetToBarcode.direction);
      //Translate the canvas back to original position
      canvas.translate(-screenCenter.dx, -screenCenter.dy);

      //Draw the arrow
      canvas.drawLine(
          arrowLineStart, arrowLineHead, paintEasy(Colors.blue, 3.0));
      canvas.drawLine(arrowLineHead, arrowHeadtop, paintEasy(Colors.blue, 3.0));
      canvas.drawLine(
          arrowLineHead, arrowHeadbottom, paintEasy(Colors.blue, 3.0));
    }
  }

  @override
  bool shouldRepaint(NavigatorPainter oldDelegate) {
    return oldDelegate.message != message;
  }
}
