import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/distance_from_camera_lookup_entry.dart';
import 'package:flutter_google_ml_kit/functions/calibrationFunctions/calibration_functions.dart';
import 'package:flutter_google_ml_kit/functions/paintFunctions/simple_paint.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/main.dart';

import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../databaseAdapters/allBarcodes/barcode_entry.dart';
import '../../functions/dataProccessing/barcode_scanner_data_processing_functions.dart';
import '../../globalValues/global_colours.dart';

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
          backgroundColor: skyBlue80,
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
                      await Hive.openBox(distanceLookupTableBoxName);
                  matchedDataBox.clear();
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setDouble('focalLength', 0);
                  setState(() {});
                },
                child: const Icon(Icons.delete),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                child: const Icon(Icons.check_circle_outline_rounded),
              ),
            ],
          ),
        ),
        body: FutureBuilder<List<List<Offset>>>(
            future: _getPoints(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<List<Offset>> dataPoints = snapshot.data!;

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
        PointMode.points, dataPoints[1], paintSimple(Colors.red, 3));
    canvas.drawPoints(
        PointMode.points, dataPoints[0], paintSimple(Colors.blue, 3));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

Future<List<List<Offset>>> _getPoints(BuildContext context) async {
  Box<DistanceFromCameraLookupEntry> matchedDataBox =
      await Hive.openBox(distanceLookupTableBoxName);

  Size size = Size(
      MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
  List<Offset> points = listOfPoints(matchedDataBox, size);

  //Plot equation using focal length
  List<BarcodeDataEntry> allBarcodes = await getAllExistingBarcodes();
  int index = allBarcodes.indexWhere((element) => element.barcodeID == 1);
  final prefs = await SharedPreferences.getInstance();
  double focalLength = prefs.getDouble('focalLength') ?? 1;
  List<Offset> equationPoints = [];
  if (index != -1) {
    double barcodeSize = allBarcodes[index].barcodeSize;
    for (var i = 50; i < 2000; i++) {
      double distanceFromCamera = focalLength * barcodeSize / i.toDouble();
      Offset dataPoint = Offset(i.toDouble(), distanceFromCamera);

      equationPoints.add(Offset(
          ((dataPoint.dx + size.width / 2) / (size.width / 50)),
          ((dataPoint.dy + size.height / 2) / (size.height / 50))));
    }
  }

  List<List<Offset>> allPoints = [];
  allPoints.add(points);
  allPoints.add(equationPoints);
  return allPoints;
}
