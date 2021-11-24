import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../databaseAdapters/consolidated_data_adapter.dart';

class databaseVisualization extends StatefulWidget {
  const databaseVisualization({Key? key}) : super(key: key);

  @override
  _databaseVisualizationState createState() => _databaseVisualizationState();
}

class _databaseVisualizationState extends State<databaseVisualization> {
  List pointNames = [];
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
            future: _getPoints(context, pointNames),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var dataPoints = snapshot.data;
                print(dataPoints.runtimeType);
                print(dataPoints);
                return Center(
                  child: InteractiveViewer(
                    maxScale: 6,
                    minScale: 0.3,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: OpenPainter(
                          dataPoints: dataPoints, pointNames: pointNames),
                    ),
                  ),
                );
              }
            }));
  }
}

class OpenPainter extends CustomPainter {
  OpenPainter({required this.dataPoints, required this.pointNames});
  var dataPoints;
  var pointNames;

  @override
  paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 6;

    canvas.drawPoints(PointMode.points, dataPoints, paint1);
    for (var i = 0; i < dataPoints.length; i++) {
      final textSpan = TextSpan(
          text: pointNames[i], style: TextStyle(color: Colors.deepOrange[800]));
      final textPainter = TextPainter(
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

_getPoints(BuildContext context, List pointNames) async {
  List<Offset> points = [];
  pointNames.clear();
  points.clear();

  var consolidatedDataBox = await Hive.openBox('consolidatedDataBox');
  for (var i = 0; i < consolidatedDataBox.length; i++) {
    ConsolidatedData data = consolidatedDataBox.getAt(i);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    points.add(Offset((data.X / 2) + (width / 2), (data.Y / 2) + (height / 2)));
    pointNames.add(data.uid);
  }
  print(points);
  return points;
}
