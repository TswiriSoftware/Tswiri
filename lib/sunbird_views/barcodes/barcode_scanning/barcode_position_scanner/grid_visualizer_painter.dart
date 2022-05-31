import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/functions/translating/unit_vectors.dart';
import 'package:flutter_google_ml_kit/global_values/barcode_colors.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/objects/display/display_point.dart';

class GridVisualizerPainter extends CustomPainter {
  GridVisualizerPainter({
    required this.coordinates,
    required this.parentBarcodeUID,
  });

  List<CoordinateEntry> coordinates;
  String parentBarcodeUID;

  @override
  paint(Canvas canvas, Size size) async {
    List<double> unitVector = calculateUnitVectors(
      coordinateEntries: coordinates,
      width: size.width,
      height: size.height,
    );

    List<DisplayPoint> myPoints = [];

    for (var i = 0; i < coordinates.length; i++) {
      CoordinateEntry coordinate = coordinates.elementAt(i);
      if (coordinate.vector() != null) {
        Offset barcodePosition = Offset(
            (coordinate.vector()!.x * unitVector[0]) +
                (size.width / 2) -
                (size.width / 8),
            (coordinate.vector()!.y * unitVector[1]) +
                (size.height / 2) -
                (size.height / 8));

        List<double> barcodeRealPosition = [
          roundDouble(coordinate.vector()!.x, 5),
          roundDouble(coordinate.vector()!.y, 5),
          roundDouble(coordinate.vector()!.z, 5),
        ];

        myPoints.add(DisplayPoint(
            barcodeUID: coordinate.barcodeUID,
            screenPosition: barcodePosition,
            realPosition: barcodeRealPosition));
      }
    }

    List<Offset> points = [];

    for (DisplayPoint point in myPoints) {
      points.add(point.screenPosition);
    }

    canvas.drawPoints(PointMode.points, points,
        paintEasy(barcodeChildren.withOpacity(0.8), 4));

    for (DisplayPoint point in myPoints) {
      final textSpan = TextSpan(
          text: point.barcodeUID +
              '\n x: ' +
              point.realPosition[0].toString() +
              '\n y: ' +
              point.realPosition[1].toString() +
              '\n z: ' +
              point.realPosition[2].toString(),
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

      textPainter.paint(canvas, (point.screenPosition));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
