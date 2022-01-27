import 'package:flutter/material.dart';
import '../../../main.dart';
import '../accelerometer_database_view.dart';
import '../camera_calibration_view.dart';
import '../calibration_database_view.dart';
import '../calibration_lookup_table_database_view.dart';
import '../calibration_prosessed_database_view.dart';

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
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const CustomCard(
              'Camera Calibration',
              CameraCalibration(),
              Icons.camera,
              featureCompleted: true,
            ),
            const CustomCard(
              'Calibration Data Viewer',
              CalibrationDatabaseView(),
              Icons.view_array,
              featureCompleted: true,
            ),
            const CustomCard(
              'Accelerometer Data Viewer',
              AccelerometerDatabaseView(),
              Icons.view_array,
              featureCompleted: true,
            ),
            const CustomCard(
              'Processed Data Viewer',
              CalibrationProsessedDatabaseView(),
              Icons.calculate,
              featureCompleted: true,
            ),
            const CustomCard(
              'Processed Data Viewer',
              CalibrationLookupTableDatabaseView(),
              Icons.calculate,
              featureCompleted: true,
            ),
          ],
        ),
      ),
    );
  }
}
