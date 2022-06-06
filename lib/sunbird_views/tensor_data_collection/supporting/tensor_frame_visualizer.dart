// import 'dart:developer';
import 'dart:math' as m;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_data.dart';

import '../../../functions/simple_paint/simple_paint.dart';

class TensorVisualizerPainter extends CustomPainter {
  TensorVisualizerPainter({
    required this.tensorData,
  });

  TensorData tensorData;
  double f = 40;
  @override
  paint(Canvas canvas, Size size) async {
    List<Offset> cornerPoints = [];
    List<Offset> scaledPoints = [];
    int xMax = 0;
    int xMin = 0;
    int yMax = 0;
    int yMin = 0;
    for (m.Point<int> point in tensorData.cornerPoints) {
      if (point.x > xMax) {
        xMax = point.x;
      }
      if (point.x < xMin) {
        xMin = point.x;
      }
      if (point.y > yMax) {
        yMax = point.y;
      }
      if (point.y > yMin) {
        yMin = point.y;
      }
      cornerPoints.add(Offset(point.x.toDouble(), point.y.toDouble()));
    }

    int ySize = yMax - yMin;
    int xSize = xMax - xMin;

    if (xSize > f) {
      double unit = xSize / f;
      double scale = f / unit;

      for (Offset offset in cornerPoints) {
        scaledPoints.add(Offset(
            ((offset.dx / f) * scale) + 25, ((offset.dy / f) * scale) + 25));
      }
    } else if (ySize > f) {
      double unit = ySize / f;
      double scale = f / unit;

      for (Offset offset in cornerPoints) {
        scaledPoints.add(Offset(((offset.dx / f) * scale) + xMin.abs(),
            ((offset.dy / f) * scale) + yMin.abs()));
      }
    } else {
      scaledPoints = cornerPoints;
    }
    scaledPoints.add(scaledPoints[0]);

    canvas.drawPoints(
        PointMode.polygon, scaledPoints, paintEasy(sunbirdOrange, 2));
    canvas.drawPoints(
        PointMode.points, scaledPoints, paintEasy(Colors.blueAccent, 6));
    // canvas.drawPoints(PointMode.points, markerPositions,
    //     paintEasy(barcodeMarkerColor.withOpacity(0.8), 4));

    // canvas.drawPoints(PointMode.points, unknownPositions,
    //     paintEasy(barcodeUnkownColor.withOpacity(0.8), 4));

    // //Draw Text to Canvas.
    // for (DisplayPoint point in displayPoints) {
    //   final textSpan = TextSpan(
    //       text:
    //           '${point.barcodeUID}\n x: ${point.realPosition[0]}\n y: ${point.realPosition[1]}\n z: ${point.realPosition[2]}',
    //       style: TextStyle(
    //           color: Colors.red[500],
    //           fontSize: 1.5,
    //           fontWeight: FontWeight.bold));
    //   final textPainter = TextPainter(
    //     textAlign: TextAlign.justify,
    //     text: textSpan,
    //     textDirection: TextDirection.ltr,
    //   );
    //   textPainter.layout(
    //     minWidth: 0,
    //     maxWidth: size.width,
    //   );

    //   textPainter.paint(canvas, (point.screenPosition));
    // }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
