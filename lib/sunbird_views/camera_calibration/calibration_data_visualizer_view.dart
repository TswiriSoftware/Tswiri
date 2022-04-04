import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/calibration_functions/calibration_functions.dart';

import 'package:flutter_google_ml_kit/globalValues/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_size_distance_entry/barcode_size_distance_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:flutter_google_ml_kit/widgets/orange_text_button_widget.dart';

import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'painters/camera_calibration_visualizer_painter.dart';

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
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: _deleteButton(),
        body: FutureBuilder<List<List<Offset>>>(
            future: _getPoints(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<List<Offset>> dataPoints = snapshot.data!;

                return Center(
                  child: InteractiveViewer(
                    maxScale: 6,
                    minScale: 0.3,
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: CameraCalibrationVisualizerPainter(
                        dataPoints: dataPoints,
                      ),
                    ),
                  ),
                );
              }
            }));
  }

  Future<List<List<Offset>>> _getPoints(BuildContext context) async {
    List<BarcodeSizeDistanceEntry> sizeDistanceEntry =
        isarDatabase!.barcodeSizeDistanceEntrys.where().findAllSync();

    Size size = Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    List<Offset> points = listOfPoints(sizeDistanceEntry, size);

    final prefs = await SharedPreferences.getInstance();
    double focalLength = prefs.getDouble(focalLengthPreference) ?? 0;
    List<Offset> equationPoints = [];

    for (var i = 50; i < 2000; i++) {
      double distanceFromCamera =
          focalLength * defaultBarcodeDiagonalLength! / i.toDouble();
      Offset dataPoint = Offset(i.toDouble(), distanceFromCamera);

      equationPoints.add(Offset(
          ((dataPoint.dx + size.width / 2) / (size.width / 50)),
          ((dataPoint.dy + size.height / 2) / (size.height / 50))));
    }

    List<List<Offset>> allPoints = [];
    allPoints.add(points);
    allPoints.add(equationPoints);
    return allPoints;
  }

  Widget _deleteButton() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () async {
        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Delete all calibration data?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                OrangeTextButton(
                  text: 'yes',
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setDouble(focalLengthPreference, 0);
                    isarDatabase!.writeTxnSync((isar) =>
                        isar.barcodeSizeDistanceEntrys.where().deleteAllSync());
                    Navigator.pop(context);
                  },
                ),
                OrangeTextButton(
                  text: 'no',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
        setState(() {});
      },
      child: const Icon(Icons.delete),
    );
  }
}
