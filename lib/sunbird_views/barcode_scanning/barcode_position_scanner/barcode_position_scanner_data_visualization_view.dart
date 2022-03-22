import 'dart:developer';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcode_position_calulation/barcode_position_calculator.dart';
import 'package:flutter_google_ml_kit/functions/mathfunctions/round_to_double.dart';
import 'package:flutter_google_ml_kit/functions/paintFunctions/simple_paint.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:isar/isar.dart';
import '../../../isar_database/marker/marker.dart';
import '../../../objects/display_point.dart';

// ignore: todo
//TODO: Refactor this @049er

class BarcodePositionScannerDataVisualizationView extends StatefulWidget {
  const BarcodePositionScannerDataVisualizationView({
    Key? key,
    required this.database,
    required this.parentContainerUID,
  }) : super(key: key);

  final Isar database;
  final String parentContainerUID;

  @override
  _BarcodePositionScannerDataVisualizationViewState createState() =>
      _BarcodePositionScannerDataVisualizationViewState();
}

class _BarcodePositionScannerDataVisualizationViewState
    extends State<BarcodePositionScannerDataVisualizationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.check_circle_outline_rounded),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Position Visualizer',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<DisplayPoint>>(
        future: calculateDisplaypoints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<DisplayPoint> myPoints = snapshot.data!;
            return Center(
              child: InteractiveViewer(
                maxScale: 25,
                minScale: 0.01,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: OpenPainter(myPoints: myPoints),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<DisplayPoint>> calculateDisplaypoints() async {
    //Calculate realBarcodePositions.
    List<RealBarcodePosition> realBarcodePositions =
        calculateRealBarcodePositions(
            database: widget.database, parentUID: widget.parentContainerUID);

    log(realBarcodePositions.toString());

    List<String> markers = widget.database.markers
        .filter()
        .parentContainerUIDMatches(widget.parentContainerUID)
        .barcodeUIDProperty()
        .findAllSync();

    //Get Screen width and height.
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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

      if (markers.contains(realBarcodePosition.uid)) {
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
      RealBarcodePosition data = realBarcodePositions.elementAt(i);
      double xDistance = data.offset!.dx;
      double yDistance = data.offset!.dy;
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
    }

    double totalXdistance = (sX - bX).abs() + 500;
    double totalYdistance = (sY - bY).abs() + 500;

    double unitX = width / 2 / totalXdistance;
    double unitY = height / 2 / totalYdistance;

    return [unitX, unitY];
  }
}

class OpenPainter extends CustomPainter {
  OpenPainter({
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