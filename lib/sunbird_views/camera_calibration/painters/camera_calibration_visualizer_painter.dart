import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';

class CameraCalibrationVisualizerPainter extends CustomPainter {
  CameraCalibrationVisualizerPainter({
    required this.dataPoints,
  });

  // ignore: prefer_typing_uninitialized_variables
  var dataPoints;

  @override
  paint(Canvas canvas, Size size) {
    canvas.drawPoints(
        PointMode.points, dataPoints[1], paintSimple(Colors.red, 3));
    canvas.drawPoints(
        PointMode.points, dataPoints[0], paintSimple(Colors.blue, 3));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
