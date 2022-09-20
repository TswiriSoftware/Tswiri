import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tswiri/views/ml_kit/camera_calibration/camera_calibration_view.dart';
import 'package:flutter/material.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/models/camera/camera_calibration.dart';
import 'package:tswiri_database/models/camera/camera_calibration_painter.dart';
import 'package:tswiri_database/models/settings/app_settings.dart';
import 'package:tswiri_widgets/colors/colors.dart';
import 'package:tswiri_widgets/widgets/general/custom_text_field.dart';

class CalibrationView extends StatefulWidget {
  const CalibrationView({Key? key}) : super(key: key);

  @override
  State<CalibrationView> createState() => _CalibrationViewState();
}

class _CalibrationViewState extends State<CalibrationView> {
  late bool isCalibrated = true;

  @override
  void initState() {
    if (isar!.cameraCalibrationEntrys.where().findAllSync().isEmpty &&
        focalLength == 1) {
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
    return isCalibrated ? _calibrated() : _unCalibratedV2();
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
                  (focalLength / 1000).toStringAsFixed(2),
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

  Widget _unCalibratedV2() {
    return Column(
      children: [
        Card(
          child: ExpansionTile(
            title: const Text('Manual Calibration'),
            children: [
              CustomTextField(
                backgroundColor: background,
                borderColor: tswiriOrange,
                onSubmitted: (value) async {
                  if (value.isNotEmpty) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    double apeture = (double.tryParse(value) ?? 1.79) * 1000;

                    prefs.setDouble(focalLengthPref, apeture);

                    focalLength = apeture;

                    setState(() {
                      isCalibrated = true;
                    });
                  }
                },
                label: 'Apeture f/',
                textInputType: TextInputType.number,
                initialValue: (focalLength / 1000).toStringAsFixed(2),
              ),
            ],
          ),
        ),
        Card(
          child: ExpansionTile(
            title: const Text('Auto Calibration'),
            children: [
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
                  'Calibrate Camera',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ],
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
