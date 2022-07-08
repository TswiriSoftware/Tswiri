// ignore: must_be_immutable
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/global_values/all_globals.dart';
import 'package:flutter_google_ml_kit/isar_database/isar_export.dart';
import 'package:flutter_google_ml_kit/objects/display/display_point.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';

import '../../../functions/isar_functions/isar_functions.dart';

// ignore: must_be_immutable
class GridViewer extends StatelessWidget {
  GridViewer({Key? key, required this.girdUID, this.highlightBarcode})
      : super(key: key);
  String girdUID;
  String? highlightBarcode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: sunbirdOrange, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            height: MediaQuery.of(context).size.width,
            child: InteractiveViewer(
              scaleFactor: 5,
              maxScale: 10,
              minScale: 1,
              child: CustomPaint(
                size: Size.infinite,
                painter: GridVisualizerPainter(
                  gridUID: girdUID,
                  highlightBarcode: highlightBarcode,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridVisualizerPainter extends CustomPainter {
  GridVisualizerPainter({
    required this.gridUID,
    this.highlightBarcode,
  });

  String gridUID;
  String? highlightBarcode;

  @override
  paint(Canvas canvas, Size size) async {
    //Spwan MasterGrid.
    MasterGrid masterGrid = MasterGrid(isarDatabase: isarDatabase!);

    //Generate displayPoints
    List<DisplayPoint> displayPoints =
        masterGrid.createDisplayPoints(gridUID, size);

    List<String> markers = isarDatabase!.markers
        .where()
        .findAllSync()
        .map((e) => e.barcodeUID)
        .toList();

    List<String> children = isarDatabase!.containerEntrys
        .where()
        .findAllSync()
        .map((e) => e.barcodeUID!)
        .toList();

    List<Offset> markerPositions = [];
    List<Offset> unknownPositions = [];
    List<Offset> childrenPositions = [];
    List<Offset> highlitedBarcodes = [];

    for (DisplayPoint displayPoint in displayPoints) {
      if (markers.contains(displayPoint.barcodeUID)) {
        markerPositions.add(displayPoint.screenPosition);
      } else if (children.contains(displayPoint.barcodeUID)) {
        childrenPositions.add(displayPoint.screenPosition);
      } else {
        unknownPositions.add(displayPoint.screenPosition);
      }
      if (displayPoint.barcodeUID == highlightBarcode) {
        highlitedBarcodes.add(displayPoint.screenPosition);
      }
    }

    //Draw points to Canvas.
    canvas.drawPoints(PointMode.points, childrenPositions,
        paintEasy(barcodeChildren.withOpacity(0.8), 4));

    canvas.drawPoints(PointMode.points, markerPositions,
        paintEasy(barcodeMarkerColor.withOpacity(0.8), 4));

    canvas.drawPoints(PointMode.points, unknownPositions,
        paintEasy(barcodeUnkownColor.withOpacity(0.8), 4));

    canvas.drawPoints(PointMode.points, highlitedBarcodes,
        paintEasy(barcodeDefaultColor.withOpacity(0.8), 4));

    //Draw Text to Canvas.
    for (DisplayPoint point in displayPoints) {
      final textSpan = TextSpan(
          text:
              '${point.barcodeUID}\n x: ${point.realPosition[0]}\n y: ${point.realPosition[1]}\n z: ${point.realPosition[2]}',
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
