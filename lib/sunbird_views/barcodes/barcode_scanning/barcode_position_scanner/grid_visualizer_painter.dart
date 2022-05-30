import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';

import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/functions/translating/unit_vectors.dart';
import 'package:flutter_google_ml_kit/global_values/barcode_colors.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/objects/display/display_point.dart';
import 'package:isar/isar.dart';

class GridVisualizerPainter extends CustomPainter {
  GridVisualizerPainter({
    required this.coordinates,
    required this.parentBarcodeUID,
  });

  List<CoordinateEntry> coordinates;
  String parentBarcodeUID;

  @override
  paint(Canvas canvas, Size size) async {
    List<String> markers = isarDatabase!.markers
        .where()
        .findAllSync()
        .map((e) => e.barcodeUID)
        .toList();

    List<String> boxes = isarDatabase!.containerEntrys
        .filter()
        .containerTypeMatches('Box')
        .findAllSync()
        .map((e) => e.barcodeUID!)
        .toList();

    List<double> unitVector = unitVectorsCoordinates(
      coordinateEntries: coordinates,
      width: size.width,
      height: size.height,
    );

    List<DisplayPoint> myPoints = [];

    for (var i = 0; i < coordinates.length; i++) {
      CoordinateEntry coordinate = coordinates.elementAt(i);

      Offset barcodePosition = Offset(
          (coordinate.vector().x * unitVector[0]) +
              (size.width / 2) -
              (size.width / 8),
          (coordinate.vector().y * unitVector[1]) +
              (size.height / 2) -
              (size.height / 8));

      List<double> barcodeRealPosition = [
        roundDouble(coordinate.vector().x, 5),
        roundDouble(coordinate.vector().y, 5),
        roundDouble(coordinate.vector().z, 5),
      ];

      myPoints.add(DisplayPoint(
          isMarker: false,
          barcodeUID: coordinate.barcodeUID,
          barcodePosition: barcodePosition,
          realBarcodePosition: barcodeRealPosition));
    }

    List<Offset> points = [];

    for (DisplayPoint point in myPoints) {
      points.add(point.barcodePosition);
    }

    canvas.drawPoints(PointMode.points, points,
        paintEasy(barcodeChildren.withOpacity(0.8), 4));

    for (DisplayPoint point in myPoints) {
      final textSpan = TextSpan(
          text: point.barcodeUID +
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
