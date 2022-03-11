import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/mathfunctions/round_to_double.dart';
import 'package:flutter_google_ml_kit/functions/paintFunctions/simple_paint.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../databaseAdapters/allBarcodes/barcode_data_entry.dart';
import '../../databaseAdapters/scanningAdapter/real_barcode_position_entry.dart';
import '../../objects/display_point.dart';

// ignore: todo
//TODO: Refactor this @049er

class RealBarcodePositionDatabaseVisualizationView extends StatefulWidget {
  const RealBarcodePositionDatabaseVisualizationView(
      {Key? key, required this.shelfUID})
      : super(key: key);

  final int? shelfUID;

  @override
  _RealBarcodePositionDatabaseVisualizationViewState createState() =>
      _RealBarcodePositionDatabaseVisualizationViewState();
}

class _RealBarcodePositionDatabaseVisualizationViewState
    extends State<RealBarcodePositionDatabaseVisualizationView> {
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
            future: _getPoints(context, widget.shelfUID ?? 0),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<DisplayPoint> myPoints = snapshot.data!;

                return Center(
                  child: InteractiveViewer(
                    maxScale: 10,
                    minScale: 0.1,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: OpenPainter(myPoints: myPoints),
                    ),
                  ),
                );
              }
            }));
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
      log(point.isMarker.toString());
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

//Get all points that should be plotted.
Future<List<DisplayPoint>> _getPoints(
    BuildContext context, int shelfUID) async {
  List<DisplayPoint> myPoints = [];

  //Open realPositionBox.
  Box<RealBarcodePositionEntry> realPositionsBox =
      await Hive.openBox(realPositionsBoxName);

  //Open generatedBarcodeData.
  Box<BarcodeDataEntry> generatedBarcodeData =
      await Hive.openBox(allBarcodesBoxName);

  List<BarcodeDataEntry> generatedBarcodeDataList =
      generatedBarcodeData.values.toList();

  //Set isMarker in position data.
  for (BarcodeDataEntry barcodeDataEntry in generatedBarcodeDataList) {
    if (barcodeDataEntry.isMarker) {
      realPositionsBox.get(barcodeDataEntry.uid)!.isMarker = true;
    }
  }

  List<RealBarcodePositionEntry> realPositionsShelf = [];

  if (shelfUID != 0) {
    realPositionsShelf = realPositionsBox.values
        .toList()
        .where((element) => element.shelfUID == shelfUID)
        .toList();
  } else {
    realPositionsShelf = realPositionsBox.values.toList();
  }

  //Get Screen width and height.
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  //Calculate the unit vectors for the screen so that everything fits on it.
  List<double> unitVector = unitVectors(
      realPositionsBox: realPositionsBox, width: width, height: height);

  for (var i = 0; i < realPositionsShelf.length; i++) {
    RealBarcodePositionEntry realBarcodePosition = realPositionsBox.getAt(i)!;

    Offset barcodePosition = Offset(
        (realBarcodePosition.offset.x * unitVector[0]) +
            (width / 2) -
            (width / 8),
        (realBarcodePosition.offset.y * unitVector[1]) +
            (height / 2) -
            (height / 8));

    List<double> barcodeRealPosition = [
      roundDouble(realBarcodePosition.offset.x, 5),
      roundDouble(realBarcodePosition.offset.y, 5),
      roundDouble(realBarcodePosition.zOffset, 5),
    ];

    myPoints.add(DisplayPoint(
        isMarker: realBarcodePosition.isMarker,
        barcodeID: realBarcodePosition.uid,
        barcodePosition: barcodePosition,
        realBarcodePosition: barcodeRealPosition));
  }

  return myPoints;
}

List<double> unitVectors(
    {required Box<RealBarcodePositionEntry> realPositionsBox,
    required double width,
    required double height}) {
  double sX = 0;
  double bX = 0;
  double sY = 0;
  double bY = 0;

  for (var i = 0; i < realPositionsBox.length; i++) {
    RealBarcodePositionEntry data = realPositionsBox.getAt(i)!;
    double xDistance = data.offset.x;
    double yDistance = data.offset.y;
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
