import 'package:flutter/material.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/utilities/calibration/camera_calibration/camera_calibration.dart';
import 'package:sunbird/views/utilities/calibration/camera_calibration_painter.dart';
import 'package:sunbird_base/colors/colors.dart';

import 'camera_calibration/camera_calibration_view.dart';

class CalibrationView extends StatefulWidget {
  const CalibrationView({Key? key}) : super(key: key);

  @override
  State<CalibrationView> createState() => _CalibrationViewState();
}

class _CalibrationViewState extends State<CalibrationView> {
  late bool isCalibrated = true;

  @override
  void initState() {
    if (isar!.cameraCalibrationEntrys.where().findAllSync().isEmpty) {
      isCalibrated = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Camera Calibration',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      actions: [
        isCalibrated
            ? IconButton(
                onPressed: () {
                  isar!.writeTxnSync(
                    (isar) => isar.cameraCalibrationEntrys.clearSync(),
                  );
                  _updatePage();
                },
                icon: const Icon(
                  Icons.delete_sharp,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _body() {
    return isCalibrated ? _calibrated() : _unCalibrated();
  }

  Widget _calibrated() {
    return Column(
      children: [
        Card(
          color: background[400],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  focalLength.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: InteractiveViewer(
                    child: CustomPaint(
                      painter: CameraCalibrationVisualizerPainter(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            CameraCalibration? cameraCalibration = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CameraCalibrationView(),
              ),
            );

            if (cameraCalibration != null) {
              //Calibrate the camera.
              await cameraCalibration.calibrateCamera();
              _updatePage();
            }
          },
          child: Text(
            'Calebrate Again',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _unCalibrated() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          CameraCalibration? cameraCalibration = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CameraCalibrationView(),
            ),
          );

          if (cameraCalibration != null) {
            //Calibrate the camera.
            await cameraCalibration.calibrateCamera();
            _updatePage();
          }
        },
        child: Text(
          'Calibrate Camera',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  void _updatePage() {
    setState(() {
      if (isar!.cameraCalibrationEntrys.where().findAllSync().isNotEmpty) {
        isCalibrated = true;
      } else {
        isCalibrated = false;
      }
    });
  }
}
