import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/global_values/barcode_colors.dart';

class PositionPainter extends CustomPainter {
  PositionPainter({
    required this.message,
  });
  final List message;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < message.length; i++) {
      List<Offset> offsetPoints = <Offset>[
        Offset(message[i][1][0], message[i][1][1]),
        Offset(message[i][1][2], message[i][1][3]),
        Offset(message[i][1][4], message[i][1][5]),
        Offset(message[i][1][6], message[i][1][7]),
        Offset(message[i][1][0], message[i][1][1]),
      ];

      canvas.drawPoints(
          PointMode.polygon, offsetPoints, paintEasy(barcodeDefaultColor, 3.0));
    }
  }

  @override
  bool shouldRepaint(PositionPainter oldDelegate) {
    return oldDelegate.message != message;
  }
}
