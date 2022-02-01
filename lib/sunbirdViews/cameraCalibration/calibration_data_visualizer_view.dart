import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/calibrationFunctions/calibration_functions.dart';
import 'package:flutter_google_ml_kit/functions/paintFunctions/simple_paint.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/globalValues/global_paints.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'matched_calibration_database_view.dart';

class CalibrationDataVisualizerView extends StatefulWidget {
  const CalibrationDataVisualizerView({Key? key}) : super(key: key);

  @override
  _CalibrationDataVisualizerViewState createState() =>
      _CalibrationDataVisualizerViewState();
}

class _CalibrationDataVisualizerViewState
    extends State<CalibrationDataVisualizerView> {
  var displayList = [];

  List<StraightLine> straightLineEquation = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calibration Data Visualizer'),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  var matchedDataBox = await Hive.openBox(matchedDataHiveBox);
                  matchedDataBox.clear();
                  setState(() {});
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: _getPoints(context, straightLineEquation),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var dataPoints = snapshot.data;

                //print(dataPoints.runtimeType);
                //print(dataPoints);
                return Center(
                  child: InteractiveViewer(
                    maxScale: 6,
                    minScale: 0.3,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: OpenPainter(
                        dataPoints: dataPoints,
                        straightLineEquation: straightLineEquation,
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}

class OpenPainter extends CustomPainter {
  OpenPainter({required this.dataPoints, required this.straightLineEquation});

  // ignore: prefer_typing_uninitialized_variables
  var dataPoints;
  List<StraightLine> straightLineEquation;

  @override
  paint(Canvas canvas, Size size) {
    canvas.drawPoints(
        PointMode.points, dataPoints, paintSimple(Colors.blue, 3));

    StraightLine a = straightLineEquation[0];

    Offset first = Offset((5000 + size.width / 2) / (size.width / 50),
        ((5000 * a.m + a.c + size.height / 2) / (size.height / 200)));
    Offset last = Offset((100 + size.width / 2) / (size.width / 50),
        ((100 * a.m + a.c + size.height / 2) / (size.height / 200)));

    canvas.drawLine(first, last, paintRed3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

_getPoints(BuildContext context, List<StraightLine> straightLine) async {
  var matchedDataBox = await Hive.openBox(matchedDataHiveBox);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  straightLine.add(
      StraightLine(m: prefs.getDouble('m') ?? 0, c: prefs.getDouble('c') ?? 0));

  Size size = Size(
      MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  List<Offset> points = listOfPoints(matchedDataBox, size);

  return points;
}
