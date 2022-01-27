// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataInjectorFunctions/raw_data_functions.dart';
import 'package:hive_flutter/hive_flutter.dart';

//TODO: Refactor this @049er

class DatabaseVisualization extends StatefulWidget {
  const DatabaseVisualization({Key? key}) : super(key: key);

  @override
  _DatabaseVisualizationState createState() => _DatabaseVisualizationState();
}

class _DatabaseVisualizationState extends State<DatabaseVisualization> {
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
                  var consolidatedDataBox =
                      await Hive.openBox('consolidatedDataBox');
                  consolidatedDataBox.clear();
                  setState(() {});
                },
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Hive Database Tools',
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
                    maxScale: 6,
                    minScale: 0.3,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: OpenPainter(
                          dataPoints: dataPoints,
                          pointNames: pointNames,
                          pointRelativePositions: pointRelativePositions),
                    ),
                  ),
                );
              }
            }));
  }
}

class OpenPainter extends CustomPainter {
  OpenPainter(
      {required this.dataPoints,
      required this.pointNames,
      required this.pointRelativePositions});
  var dataPoints;
  var pointRelativePositions;
  var pointNames = [];

  @override
  paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 6;

    canvas.drawPoints(PointMode.points, dataPoints, paint1);
    for (var i = 0; i < dataPoints.length; i++) {
      final textSpan = TextSpan(
          text: pointNames[i] + ': ' + pointRelativePositions[i],
          style: TextStyle(color: Colors.deepOrange[800], fontSize: 2));
      final textPainter = TextPainter(
        textAlign: TextAlign.start,
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      //print(dataPoints[i]);
      textPainter.paint(canvas, dataPoints[i]);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

_getPoints(
    BuildContext context, List pointNames, List pointRelativePositions) async {
  List<Offset> points = [];

  var consolidatedDataBox = await Hive.openBox('consolidatedDataBox');
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  for (var i = 0; i < consolidatedDataBox.length; i++) {
    ConsolidatedData data = consolidatedDataBox.getAt(i);
    points.add(Offset(
        (data.X * 10000) + (width / 2), (-data.Y * 10000) + (height / 2)));
    pointRelativePositions
        .add('(${roundDouble(data.X, 10)}, ${roundDouble(data.Y, 10)})');
    pointNames.add(data.uid);
  }
  return points;
}
