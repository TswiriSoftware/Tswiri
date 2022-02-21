import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../main.dart';
import '../camera_calibration_view.dart';
import '../calibration_data_visualizer_view.dart';

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
        backgroundColor: skyBlue80,
        title: const Text(
          'Camera Calibration Tools',
          style: TextStyle(fontSize: 25),
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
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const CustomCard(
                'Camera Calibration', CameraCalibration(), Icons.camera,
                featureCompleted: true, tileColor: skyBlue80),
            const CustomCard('Processed Data Visualizer',
                CalibrationDataVisualizerView(), Icons.calculate,
                featureCompleted: true, tileColor: skyBlue80),
          ],
        ),
      ),
    );
  }
}
