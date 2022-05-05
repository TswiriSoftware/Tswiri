import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/global_values/barcode_colors.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_object.dart';
import 'package:flutter_google_ml_kit/objects/navigation/message_objects/painter_message.dart';

class NavigatorPainter extends CustomPainter {
  NavigatorPainter({
    required this.message,
    required this.containerEntry,
  });
  // ignore: prefer_typing_uninitialized_variables
  final message;
  final ContainerEntry containerEntry;

  @override
  void paint(Canvas canvas, Size size) {
    PainterMesssage painterMesssage = PainterMesssage.fromMessage(message);

    Offset screenCenter = Offset(
      size.width / 2,
      size.height / 2,
    );

    //1. Decode and draw all barcodeBorders.
    for (int i = 0; i < painterMesssage.painterData.length; i++) {
      //i. Add offset to screen center to list.

      // //ii. decode message to OffsetPoints
      // List<Offset> offsetPoints = <Offset>[
      //   Offset(painterMesssage.painterData[i][1][0],
      //       painterMesssage.painterData[i][1][1]),
      //   Offset(painterMesssage.painterData[i][1][2],
      //       painterMesssage.painterData[i][1][3]),
      //   Offset(painterMesssage.painterData[i][1][4],
      //       painterMesssage.painterData[i][1][5]),
      //   Offset(painterMesssage.painterData[i][1][6],
      //       painterMesssage.painterData[i][1][7]),
      //   Offset(painterMesssage.painterData[i][1][0],
      //       painterMesssage.painterData[i][1][1]),
      // ];

      canvas.drawPoints(
          PointMode.points,
          [
            Offset(painterMesssage.painterData[i][1][0],
                painterMesssage.painterData[i][1][1])
          ],
          paintEasy(barcodeDefaultColor, 3.0));
      // //Draw borders.
      // canvas.drawPoints(
      //     PointMode.polygon, offsetPoints, paintEasy(barcodeDefaultColor, 3.0));
      // if (containerEntry.barcodeUID == painterMesssage.painterData[i][0]) {
      //   canvas.drawPoints(
      //       PointMode.polygon, offsetPoints, paintEasy(barcodeFocusColor, 3.0));
      // }
    }

    double finderCircleRadius = painterMesssage.averageDiagonalLength / 3;

    //Draw Finder Circle
    canvas.drawCircle(
        screenCenter,
        finderCircleRadius,
        paintSimple(
            color: Colors.black,
            strokeWidth: 2.0,
            style: PaintingStyle.stroke));

    if (painterMesssage.averageOffsetToBarcode != const Offset(0, 0) &&
        painterMesssage.averageOffsetToBarcode.distance >= finderCircleRadius) {
      //Draw arrow
      //Start position of the arrow line.
      Offset arrowLineStart =
          Offset(screenCenter.dx + finderCircleRadius, screenCenter.dy);

      //End position of the arrow line
      Offset arrowLineHead = Offset(
          arrowLineStart.dx +
              painterMesssage.averageOffsetToBarcode.distance -
              finderCircleRadius,
          screenCenter.dy);

      //ArrowHeadtop
      Offset arrowHeadtop =
          Offset(arrowLineHead.dx - 30, arrowLineHead.dy + 20);

      //ArrowHeadBottom
      Offset arrowHeadbottom =
          Offset(arrowLineHead.dx - 30, arrowLineHead.dy - 20);

      //Translate canvas to screen center.
      canvas.translate(screenCenter.dx, screenCenter.dy);
      //Rotate the canvas.
      canvas.rotate(painterMesssage.averageOffsetToBarcode.direction);
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
