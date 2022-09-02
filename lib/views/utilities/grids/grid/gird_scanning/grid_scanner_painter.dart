import 'dart:ui';
import 'package:flutter/material.dart';

class GridScannerPainter extends CustomPainter {
  GridScannerPainter({
    required this.message,
  });
  final List message;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    for (int i = 0; i < message.length; i++) {
      List<Offset> offsetPoints = <Offset>[
        Offset(message[i][1][0], message[i][1][1]),
        Offset(message[i][1][2], message[i][1][3]),
        Offset(message[i][1][4], message[i][1][5]),
        Offset(message[i][1][6], message[i][1][7]),
        Offset(message[i][1][0], message[i][1][1]),
      ];

      canvas.drawPoints(PointMode.polygon, offsetPoints, paint);
    }
  }

  @override
  bool shouldRepaint(GridScannerPainter oldDelegate) {
    return oldDelegate.message != message;
  }
}
