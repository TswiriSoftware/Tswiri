import 'package:flutter/material.dart';
import 'HiveDatabaseViews/hive_accelerometer_database_view.dart';
import 'HiveDatabaseViews/hive_calibration_database_view.dart';
import 'HiveDatabaseViews/hive_prosessed_calibration_database_view .dart';
import 'calibration/camera_calibration.dart';
import 'main.dart';

class CameraCalibrationView extends StatefulWidget {
  const CameraCalibrationView({Key? key}) : super(key: key);

  @override
  _CameraCalibrationViewState createState() => _CameraCalibrationViewState();
}

class _CameraCalibrationViewState extends State<CameraCalibrationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sunbird',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: GridView.count(
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            CustomCard(
              'Camera Calibration',
              CameraCalibration(),
              Icons.camera,
              featureCompleted: true,
            ),
            CustomCard(
              'Calibration Data Viewer',
              HiveCalibrationDatabaseView(),
              Icons.view_array,
              featureCompleted: true,
            ),
            CustomCard(
              'Accelerometer Data Viewer',
              HiveAccelerometerDatabaseView(),
              Icons.view_array,
              featureCompleted: true,
            ),
            CustomCard(
              'Processed Data Viewer',
              HiveProsessedCalibrationDatabaseView(),
              Icons.calculate,
              featureCompleted: true,
            ),
          ],
        ),
      ),
    );
  }
}
