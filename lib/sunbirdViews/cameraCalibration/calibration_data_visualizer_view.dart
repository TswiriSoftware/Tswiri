import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/distance_from_camera_lookup_entry.dart';
import 'package:flutter_google_ml_kit/functions/calibrationFunctions/calibration_functions.dart';
import 'package:flutter_google_ml_kit/functions/paintFunctions/simple_paint.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';

import 'package:hive/hive.dart';

import '../../main.dart';
import 'calibrationToolsView/camera_calibration_tools_view.dart';

class CalibrationDataVisualizerView extends StatefulWidget {
  const CalibrationDataVisualizerView({Key? key}) : super(key: key);

  @override
  _CalibrationDataVisualizerViewState createState() =>
      _CalibrationDataVisualizerViewState();
}

class _CalibrationDataVisualizerViewState
    extends State<CalibrationDataVisualizerView> {
  var displayList = [];

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
                  Box<DistanceFromCameraLookupEntry> matchedDataBox =
                      await Hive.openBox(matchedDataHiveBoxName);
                  matchedDataBox.clear();
                  setState(() {});
                },
                child: const Icon(Icons.delete),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          const CameraCalibrationToolsView()));
                },
                child: const Icon(Icons.check_circle_outline_rounded),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: _getPoints(context),
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
  });

  // ignore: prefer_typing_uninitialized_variables
  var dataPoints;

  @override
  paint(Canvas canvas, Size size) {
    canvas.drawPoints(
        PointMode.points, dataPoints, paintSimple(Colors.blue, 3));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

_getPoints(BuildContext context) async {
  Box<DistanceFromCameraLookupEntry> matchedDataBox =
      await Hive.openBox(matchedDataHiveBoxName);

  Size size = Size(
      MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  List<Offset> points = listOfPoints(matchedDataBox, size);

  return points;
}
