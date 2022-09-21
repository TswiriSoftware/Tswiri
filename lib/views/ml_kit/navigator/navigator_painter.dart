import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tswiri_widgets/colors/colors.dart';

Offset? averageOffsetToBarcode;
int? lastActivity;

class NavigatorPainter extends CustomPainter {
  NavigatorPainter({
    required this.message,
  });
  final List message;

  final Paint barcodePaint = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 2
    ..color = Colors.lightGreenAccent.withOpacity(0.5);

  final Paint finderCircleGreen = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..color = Colors.lightGreenAccent;

  final Paint finderCircleRed = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..color = Colors.red;

  final Paint arrowPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0
    ..color = Colors.blue;

  final Paint textBackground = Paint()
    ..style = PaintingStyle.fill
    ..color = background;

  @override
  void paint(Canvas canvas, Size size) {
    Offset screenCenter = Offset(
      size.width / 2,
      size.height / 2,
    );

    if ((message[3] as List).isNotEmpty) {
      List<Offset> offsetPoints = <Offset>[
        Offset(message[3][1][0], message[3][1][1]),
        Offset(message[3][1][2], message[3][1][3]),
        Offset(message[3][1][4], message[3][1][5]),
        Offset(message[3][1][6], message[3][1][7]),
        Offset(message[3][1][0], message[3][1][1]),
      ];

      // canvas.drawPoints(PointMode.polygon, offsetPoints, barcodePaint);
      Path path = Path();
      path.addPolygon(offsetPoints, true);
      canvas.drawPath(path, barcodePaint);

      if (message[4] == true) {
        final textSpan = TextSpan(
          text: 'Open Me',
          style: TextStyle(
            color: Colors.red[500],
            fontSize: 12,
            fontWeight: FontWeight.bold,
            background: textBackground,
          ),
        );
        final textPainter = TextPainter(
          textAlign: TextAlign.justify,
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: size.width,
        );

        textPainter.paint(canvas, offsetPoints[0]);
      }
    }

    double finderCircleRadius = message[1] / 3;
    Offset offsetToBarcode = Offset(message[2][0], message[2][1]);

    if (offsetToBarcode.distance <= finderCircleRadius) {
      canvas.drawCircle(screenCenter, finderCircleRadius, finderCircleGreen);
    } else {
      canvas.drawCircle(screenCenter, finderCircleRadius, finderCircleRed);
    }

    if (offsetToBarcode.dx != 0 &&
        offsetToBarcode.dy != 0 &&
        offsetToBarcode.distance >= finderCircleRadius - 25) {
      averageOffsetToBarcode = offsetToBarcode;
      lastActivity = DateTime.now().millisecondsSinceEpoch;
      drawArrow(
        screenCenter,
        finderCircleRadius,
        offsetToBarcode,
        size,
        canvas,
      );
    } else {
      if (averageOffsetToBarcode != null) {
        drawArrow(
          screenCenter,
          finderCircleRadius,
          averageOffsetToBarcode!,
          size,
          canvas,
        );
      }

      ///Reset average offset to barcode.
      if (lastActivity != null &&
          lastActivity! + 2000 < DateTime.now().millisecondsSinceEpoch) {
        averageOffsetToBarcode = null;
      }
    }
  }

  void drawArrow(Offset screenCenter, double finderCircleRadius,
      Offset averageOffsetToBarcode, Size size, Canvas canvas) {
    if (averageOffsetToBarcode.distance > finderCircleRadius) {
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
      canvas.drawLine(arrowLineStart, arrowLineHead, arrowPaint);
      canvas.drawLine(arrowLineHead, arrowHeadtop, arrowPaint);
      canvas.drawLine(arrowLineHead, arrowHeadbottom, arrowPaint);
    }
  }

  @override
  bool shouldRepaint(NavigatorPainter oldDelegate) {
    return oldDelegate.message != message;
  }
}
