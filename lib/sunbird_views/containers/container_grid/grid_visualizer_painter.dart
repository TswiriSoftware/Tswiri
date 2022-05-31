import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/global_values/barcode_colors.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/objects/display/display_point.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';

class GridVisualizerPainter extends CustomPainter {
  GridVisualizerPainter({
    required this.containerEntry,
  });

  ContainerEntry containerEntry;

  @override
  paint(Canvas canvas, Size size) async {
    //Spwan MasterGrid.
    MasterGrid masterGrid = MasterGrid(isarDatabase: isarDatabase!);

    //Generate displayPoints
    List<DisplayPoint> displayPoints =
        masterGrid.createDisplayPoints(containerEntry.barcodeUID!, size);

    //Convert to Offsets.
    List<Offset> points = displayPoints.map((e) => e.screenPosition).toList();

    //Draw points to Canvas.
    canvas.drawPoints(PointMode.points, points,
        paintEasy(barcodeChildren.withOpacity(0.8), 4));

    //Draw Text to Canvas.
    for (DisplayPoint point in displayPoints) {
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
