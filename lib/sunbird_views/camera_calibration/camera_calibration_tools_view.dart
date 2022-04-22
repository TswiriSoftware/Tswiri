import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/main.dart';
import 'package:flutter_google_ml_kit/sunbird_views/camera_calibration/camera_calibration_view.dart';

import 'calibration_data_visualizer_view.dart';

///Shows camera calibration tools.
class CameraCalibrationToolsView extends StatefulWidget {
  const CameraCalibrationToolsView({Key? key}) : super(key: key);

  @override
  _CameraCalibrationToolsViewState createState() =>
      _CameraCalibrationToolsViewState();
}

class _CameraCalibrationToolsViewState
    extends State<CameraCalibrationToolsView> {
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
      appBar: AppBar(
        title: Text(
          'Camera Calibration Tools',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: GridView.count(
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          children: const [
            CustomCard(
              'Camera Calibration',
              CameraCalibrationView(),
              Icons.camera,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Processed Data Visualizer',
              CalibrationDataVisualizerView(),
              Icons.calculate,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
          ],
        ),
      ),
    );
  }
}
