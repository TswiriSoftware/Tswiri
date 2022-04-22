import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcode_position_calulation/barcode_position_calculator.dart';
import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';

import 'package:flutter_google_ml_kit/functions/simple_paint/simple_paint.dart';
import 'package:flutter_google_ml_kit/global_values/barcode_colors.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/objects/display/display_point.dart';
import 'package:flutter_google_ml_kit/objects/display/real_barcode_position.dart';
import 'package:isar/isar.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';

class GridVisualizerPainter extends CustomPainter {
  GridVisualizerPainter({
    required this.containerUID,
    required this.barcodesToDraw,
    required this.markersToDraw,
  });

  String containerUID;
  List<String> barcodesToDraw;
  List<String> markersToDraw;

  @override
  paint(Canvas canvas, Size size) {
    List<DisplayPoint> myPoints = calculateDisplaypoints(size);
    List<Offset> markers = [];
    List<Offset> boxes = [];
    List<Offset> other = [];
    Offset? parent;
    Offset? currentBarcode;

    ContainerEntry currentContainer = isarDatabase!.containerEntrys
        .filter()
        .containerUIDMatches(containerUID)
        .findFirstSync()!;
    //log(currentContainer.toString());

    ContainerEntry? parentContainerEntry;
    ContainerRelationship? relationship;
    relationship = isarDatabase!.containerRelationships
        .filter()
        .containerUIDMatches(containerUID)
        .findFirstSync();
    if (relationship != null) {
      parentContainerEntry = isarDatabase!.containerEntrys
          .filter()
          .containerUIDMatches(relationship.parentUID!)
          .findFirstSync();
    }

    markersToDraw = [];
    markersToDraw.addAll(isarDatabase!.markers
        .filter()
        .parentContainerUIDMatches(containerUID)
        .barcodeUIDProperty()
        .findAllSync());

    List<ContainerRelationship> relationships = [];
    relationships.addAll(isarDatabase!.containerRelationships
        .filter()
        .parentUIDMatches(containerUID)
        .findAllSync());

    List<ContainerEntry> children = [];
    if (relationships.isNotEmpty) {
      children.addAll(isarDatabase!.containerEntrys
          .filter()
          .repeat(
              relationships,
              (q, ContainerRelationship element) =>
                  q.containerUIDMatches(element.containerUID))
          .findAllSync());
    }

    barcodesToDraw = [];
    barcodesToDraw.addAll(children.map((e) => e.barcodeUID!));

    //log('Children: ' + children.toString());
    for (DisplayPoint point in myPoints) {
      if (barcodesToDraw.contains(point.barcodeID)) {
        boxes.add(point.barcodePosition);
      } else if (markersToDraw.contains(point.barcodeID)) {
        markers.add(point.barcodePosition);
      } else if (parentContainerEntry != null &&
          point.barcodeID == parentContainerEntry.barcodeUID) {
        parent = point.barcodePosition;
      } else {
        other.add(point.barcodePosition);
      }
      if (point.barcodeID == currentContainer.barcodeUID) {
        currentBarcode = point.barcodePosition;
      }
    }

    canvas.drawPoints(PointMode.points, boxes,
        paintSimple(barcodeChildren.withOpacity(0.8), 4));

    canvas.drawPoints(PointMode.points, markers,
        paintSimple(barcodeMarkerColor.withOpacity(0.8), 4));

    canvas.drawPoints(PointMode.points, other,
        paintSimple(barcodeUnkownColor.withOpacity(0.25), 4));

    if (currentBarcode != null) {
      canvas.drawPoints(PointMode.points, [currentBarcode],
          paintSimple(barcodeFocusColor.withOpacity(1), 2));
    }
    if (parent != null) {
      canvas.drawPoints(PointMode.points, [parent],
          paintSimple(barcodeParentColor.withOpacity(1), 2));
    }

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

  List<DisplayPoint> calculateDisplaypoints(Size size) {
    //Calculate realBarcodePositions.
    List<RealBarcodePosition> realBarcodePositions =
        calculateRealBarcodePositions(parentUID: containerUID);

    //log(realBarcodePositions.toString());

    if (realBarcodePositions.isEmpty) {
      return [];
    }

    List<String>? markers = isarDatabase?.markers
        .filter()
        .parentContainerUIDMatches(containerUID)
        .barcodeUIDProperty()
        .findAllSync();

    //Get Screen width and height.
    double width = size.width;
    double height = size.height;

    //Calculate unitVectors.
    List<double> unitVector = unitVectors(
      realBarcodePositions: realBarcodePositions,
      width: width,
      height: height,
    );

    List<DisplayPoint> myPoints = [];

    for (var i = 0; i < realBarcodePositions.length; i++) {
      RealBarcodePosition realBarcodePosition =
          realBarcodePositions.elementAt(i);
      if (realBarcodePosition.offset != null) {
        Offset barcodePosition = Offset(
            (realBarcodePosition.offset!.dx * unitVector[0]) +
                (width / 2) -
                (width / 8),
            (realBarcodePosition.offset!.dy * unitVector[1]) +
                (height / 2) -
                (height / 8));

        List<double> barcodeRealPosition = [
          roundDouble(realBarcodePosition.offset!.dx, 5),
          roundDouble(realBarcodePosition.offset!.dy, 5),
          roundDouble(realBarcodePosition.zOffset!, 5),
        ];

        if (markers != null && markers.contains(realBarcodePosition.uid)) {
          myPoints.add(DisplayPoint(
              isMarker: true,
              barcodeID: realBarcodePosition.uid,
              barcodePosition: barcodePosition,
              realBarcodePosition: barcodeRealPosition));
        } else {
          myPoints.add(DisplayPoint(
              isMarker: false,
              barcodeID: realBarcodePosition.uid,
              barcodePosition: barcodePosition,
              realBarcodePosition: barcodeRealPosition));
        }
      }
    }

    //log(myPoints.toString());
    return myPoints;
  }

  List<double> unitVectors(
      {required List<RealBarcodePosition> realBarcodePositions,
      required double width,
      required double height}) {
    double sX = 0;
    double bX = 0;
    double sY = 0;
    double bY = 0;

    for (var i = 0; i < realBarcodePositions.length; i++) {
      RealBarcodePosition realBarcodePosition =
          realBarcodePositions.elementAt(i);
      if (realBarcodePosition.offset != null) {
        if (realBarcodePosition.offset != null) {
          double xDistance = realBarcodePosition.offset!.dx;
          double yDistance = realBarcodePosition.offset!.dy;
          if (xDistance < sX) {
            sX = xDistance;
          }
          if (xDistance > bX) {
            bX = xDistance;
          }
          if (yDistance < sY) {
            sY = yDistance;
          }
          if (yDistance > bY) {
            bY = yDistance;
          }
        } else {
          //log('[0,0]');
          return [0, 0];
        }
      }
    }

    double totalXdistance = (sX - bX).abs() + 500;
    double totalYdistance = (sY - bY).abs() + 500;

    double unitX = width / 2 / totalXdistance;
    double unitY = height / 2 / totalYdistance;

    return [unitX, unitY];
  }
}
