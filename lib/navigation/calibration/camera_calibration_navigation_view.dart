import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/HiveDatabaseViews/CalibrationRelated/hive_accelerometer_database_view.dart';
import 'package:flutter_google_ml_kit/HiveDatabaseViews/CalibrationRelated/hive_calibration_database_view.dart';
import 'package:flutter_google_ml_kit/HiveDatabaseViews/CalibrationRelated/hive_linear_regression_database_view.dart';
import 'package:flutter_google_ml_kit/HiveDatabaseViews/CalibrationRelated/hive_prosessed_calibration_database_view%20.dart';
import '../../main.dart';
import 'camera_calibration.dart';

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
            CustomCard(
              'Processed Data Viewer',
              HiveLinearRegressionDatabaseView(),
              Icons.calculate,
              featureCompleted: true,
            ),
          ],
        ),
      ),
    );
  }
}
