import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/mathfunctions/round_to_double.dart';
import 'package:flutter_google_ml_kit/functions/paintFunctions/simple_paint.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../databaseAdapters/scanningAdapter/real_barocode_position_entry.dart';

// ignore: todo
//TODO: Refactor this @049er

class RealBarcodePositionDatabaseVisualizationView extends StatefulWidget {
  const RealBarcodePositionDatabaseVisualizationView({Key? key})
      : super(key: key);

  @override
  _RealBarcodePositionDatabaseVisualizationViewState createState() =>
      _RealBarcodePositionDatabaseVisualizationViewState();
}

class _RealBarcodePositionDatabaseVisualizationViewState
    extends State<RealBarcodePositionDatabaseVisualizationView> {
  List pointNames = [];
  List pointRelativePositions = [];

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
                onPressed: () async {
                  pointNames.clear();
                  Box<RealBarcodePostionEntry> consolidatedDataBox =
                      await Hive.openBox(realPositionsBoxName);
                  consolidatedDataBox.clear();
                  setState(() {});
                },
                child: const Icon(Icons.refresh),
              ),
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
            'Consolidated Data Visualizer',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: _getPoints(context, pointNames, pointRelativePositions),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var dataPoints = snapshot.data;
                return Center(
                  child: InteractiveViewer(
                    maxScale: 10,
                    minScale: 0.1,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: OpenPainter(
                        dataPoints: dataPoints,
                        pointNames: pointNames,
                        pointRelativePositions: pointRelativePositions,
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}

class OpenPainter extends CustomPainter {
  OpenPainter({
    required this.dataPoints,
    required this.pointNames,
    required this.pointRelativePositions,
  });
  var dataPoints;
  var pointRelativePositions;
  var pointNames = [];

  @override
  paint(Canvas canvas, Size size) {
    canvas.drawPoints(
        PointMode.points, dataPoints, paintSimple(Colors.blueAccent, 3));

    for (var i = 0; i < dataPoints.length; i++) {
      List pointData = pointRelativePositions[i]
          .toString()
          .replaceAll(RegExp(r'\[|\]'), '')
          .split(',')
          .toList();
      final textSpan = TextSpan(
          text: pointNames[i] +
              '\n x: ' +
              pointData[0] +
              '\n y: ' +
              pointData[1] +
              '\n z: ' +
              pointData[2],
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
      Offset offset = dataPoints[i];
      textPainter.paint(canvas, (offset));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

//Get all points that should be plotted.
_getPoints(BuildContext context, List pointNames, List pointData) async {
  List<Offset> points = [];

  //Open realPositionBox.
  Box<RealBarcodePostionEntry> realPositionsBox =
      await Hive.openBox(realPositionsBoxName);

  //Get Screen width and height.
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  //Calculate the unit vectors for the screen.
  List<double> unitVector = unitVectors(
      realPositionsBox: realPositionsBox, width: width, height: height);

  for (var i = 0; i < realPositionsBox.length; i++) {
    RealBarcodePostionEntry data = realPositionsBox.getAt(i)!;

    //Scale points so they fit on screen.
    points.add(Offset((data.offset.x / unitVector[0]) + (width / 2),
        (data.offset.y / unitVector[1]) + (height / 2)));
    pointData.add([
      roundDouble(data.offset.x, 5),
      roundDouble(data.offset.y, 5),
      roundDouble(data.zOffset, 5),
    ]);
    pointNames.add(data.uid);
  }

  return points;
}

List<double> unitVectors(
    {required Box<RealBarcodePostionEntry> realPositionsBox,
    required double width,
    required double height}) {
  double sX = 0;
  double bX = 0;
  double sY = 0;
  double bY = 0;

  for (var i = 0; i < realPositionsBox.length; i++) {
    RealBarcodePostionEntry data = realPositionsBox.getAt(i)!;
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

  double totalXdistance = (sX - bX).abs();
  double totalYdistance = (sY - bY).abs();

  double unitX = width / totalXdistance;
  double unitY = width / totalYdistance;

  return [unitX, unitY];
}
