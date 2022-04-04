import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/objects/display_point.dart';

class BarcodePositionVisualizerPainter extends CustomPainter {
  BarcodePositionVisualizerPainter({
    required this.myPoints,
  });

  List<DisplayPoint> myPoints;

  @override
  paint(Canvas canvas, Size size) {
    List<Offset> markers = [];
    List<Offset> boxes = [];

    for (DisplayPoint point in myPoints) {
      //log(point.isMarker.toString());
      if (point.isMarker) {
        markers.add(point.barcodePosition);
      } else {
        boxes.add(point.barcodePosition);
      }
    }

    canvas.drawPoints(
        PointMode.points, boxes, paintSimple(Colors.greenAccent, 4));
    canvas.drawPoints(
        PointMode.points, markers, paintSimple(Colors.blueAccent, 4));

    for (DisplayPoint point in myPoints) {
      final textSpan = TextSpan(
          text: point.barcodeID +
              '\n x: ' +
              point.realBarcodePosition[0].toString() +
              '\n y: ' +
              point.realBarcodePosition[1].toString() +
              '\n z: ' +
              point.realBarcodePosition[2].toString(),
          style: TextStyle(
              color: Colors.red[500],
              fontSize: 1.5,
              fontWeight: FontWeight.bold));
      final textPainter = TextPainter(
        textAlign: TextAlign.justify,
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      textPainter.paint(canvas, (point.barcodePosition));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
