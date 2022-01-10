import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/database/consolidated_data_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CameraCalibration extends StatefulWidget {
  const CameraCalibration({Key? key}) : super(key: key);

  @override
  _CameraCalibrationState createState() => _CameraCalibrationState();
}

class _CameraCalibrationState extends State<CameraCalibration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  setState(() {});
                },
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Camera Calibration',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container());
  }
}
