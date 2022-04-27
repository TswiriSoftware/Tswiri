import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/global_values/barcode_colors.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_object.dart';
import 'package:flutter_google_ml_kit/objects/navigation/navigator_data.dart';

class NavigatorPainterIsolate extends CustomPainter {
  NavigatorPainterIsolate({
    required this.message,
    required this.containerEntry,
    required this.knownGrids,
  });
  final List message;
  final ContainerEntry containerEntry;
  final List<GridObject> knownGrids;
  //final GridObject workingGrid;

  @override
  void paint(Canvas canvas, Size size) {
    List<NavigatorData> navigatorData = [];
    //NavigatorData? selectedBarcode;
    List<double> diagonalLengths = [];
    double barcodeDiagonalLength = 200;
    Offset screenCenter = Offset(
      size.width / 2,
      size.height / 2,
    );

    //1. Decode and draw all barcodeBorders.
    for (int i = 0; i < message.length; i++) {
      //i. Add offset to screen center to list.

      NavigatorData currentNavigatorData = NavigatorData(
        barcodeUID: message[i][0],
        offsetToScreenCenter: Offset(
          message[i][5][0],
          message[i][5][1],
        ),
      );

      navigatorData.add(currentNavigatorData);

      // if (message[i][0] == containerEntry.barcodeUID) {
      //   selectedBarcode = currentNavigatorData;
      // }

      diagonalLengths.add(message[i][6]);

      //ii. decode message to OffsetPoints
      List<Offset> offsetPoints = <Offset>[
        Offset(message[i][1][0], message[i][1][1]),
        Offset(message[i][1][2], message[i][1][3]),
        Offset(message[i][1][4], message[i][1][5]),
        Offset(message[i][1][6], message[i][1][7]),
        Offset(message[i][1][0], message[i][1][1]),
      ];

      //Draw borders.
      canvas.drawPoints(
          PointMode.polygon, offsetPoints, paintEasy(barcodeDefaultColor, 3.0));
      if (containerEntry.barcodeUID == message[i][0]) {
        canvas.drawPoints(
            PointMode.polygon, offsetPoints, paintEasy(barcodeFocusColor, 3.0));
      }
    }

    //Calcualte average diagonal length.
    if (diagonalLengths.isNotEmpty) {
      barcodeDiagonalLength =
          diagonalLengths.reduce((value, element) => value + element) /
              diagonalLengths.length;
    }

    //Select applicable grid.
    GridObject workingGrid = knownGrids
        .where(
            (element) => element.barcodes.contains(containerEntry.barcodeUID))
        .first;

    double finderCircleRadius = barcodeDiagonalLength / 3;

    //Draw Finder Circle
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        finderCircleRadius,
        paintSimple(
            color: Colors.black,
            strokeWidth: 2.0,
            style: PaintingStyle.stroke));

    //Calcualte position.
    if (navigatorData.isNotEmpty) {
      Offset offsetToBarcode = workingGrid.calculateOffsetToBarcde(
          navigatorData: navigatorData, barcodeUID: containerEntry.barcodeUID!);
      if (offsetToBarcode.distance >= finderCircleRadius) {
        //Draw arrow
        //Start position of the arrow line.
        Offset arrowLineStart =
            Offset(screenCenter.dx + finderCircleRadius, screenCenter.dy);

        //End position of the arrow line
        Offset arrowLineHead = Offset(
            arrowLineStart.dx + offsetToBarcode.distance - finderCircleRadius,
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
        canvas.rotate(offsetToBarcode.direction);
        //Translate the canvas back to original position
        canvas.translate(-screenCenter.dx, -screenCenter.dy);

        //Draw the arrow
        canvas.drawLine(
            arrowLineStart, arrowLineHead, paintEasy(Colors.blue, 3.0));
        canvas.drawLine(
            arrowLineHead, arrowHeadtop, paintEasy(Colors.blue, 3.0));
        canvas.drawLine(
            arrowLineHead, arrowHeadbottom, paintEasy(Colors.blue, 3.0));
      }
    }
  }

  @override
  bool shouldRepaint(NavigatorPainterIsolate oldDelegate) {
    return oldDelegate.message != message;
  }
}
