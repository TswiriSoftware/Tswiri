import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sunbird_2/classes/display_point.dart';

class GridVisualizerPainter extends CustomPainter {
  GridVisualizerPainter({
    required this.displayPoints,
  });

  List<DisplayPoint> displayPoints;

  @override
  paint(Canvas canvas, Size size) async {
    final Paint normalPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.green;

    final Paint markerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.blue;

    final Paint selectedPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint unkownPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red.withOpacity(0.2);

    // if (gridUID != null) {
    //   List<DisplayPoint> displayPoints = gridController.calculateDisplayPoints(
    //     gridUID!,
    //     size,
    //     selectedBarcodeUID,
    //   );

    List<Offset> normalPoints = [];
    List<Offset> markerPoints = [];
    List<Offset> selectedPoints = [];
    List<Offset> unkownPoints = [];

    for (var displayPoint in displayPoints) {
      switch (displayPoint.type) {
        case DisplayPointType.marker:
          markerPoints.add(displayPoint.screenPosition);
          break;
        case DisplayPointType.selected:
          selectedPoints.add(displayPoint.screenPosition);
          break;
        case DisplayPointType.unkown:
          unkownPoints.add(displayPoint.screenPosition);
          break;
        case DisplayPointType.normal:
          normalPoints.add(displayPoint.screenPosition);
          break;
      }
    }

    //Draw points to Canvas.
    canvas.drawPoints(PointMode.points, normalPoints, normalPaint);
    canvas.drawPoints(PointMode.points, markerPoints, markerPaint);
    canvas.drawPoints(PointMode.points, selectedPoints, selectedPaint);
    canvas.drawPoints(PointMode.points, unkownPoints, unkownPaint);

    //Draw Text to Canvas.
    for (DisplayPoint point in displayPoints) {
      final textSpan = TextSpan(
          text:
              '${point.barcodeUID}\n x: ${point.realPosition[0]}\n y: ${point.realPosition[1]}\n z: ${point.realPosition[2]}',
          style: TextStyle(
              color: Colors.red[500],
              fontSize: 1,
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

      textPainter.paint(canvas, (point.screenPosition));
    }
  }
  // }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
