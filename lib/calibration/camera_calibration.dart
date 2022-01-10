import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/camera_view.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/barcode_detector_painter_calibration.dart';
import 'package:flutter_google_ml_kit/dataProcessors/barcode_calibration_data_injector.dart';
import 'package:flutter_google_ml_kit/database/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CameraCalibration extends StatefulWidget {
  const CameraCalibration({Key? key}) : super(key: key);

  @override
  _CameraCalibrationState createState() => _CameraCalibrationState();
}

class _CameraCalibrationState extends State<CameraCalibration> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  var calibrationDataBox =
                      await Hive.openBox('calibrationDataBox');
                  calibrationDataBox.clear();
                  showMyAboutDialog(context, "Deleted Hive Database");
                },
                child: const Icon(Icons.delete),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  setState(() {});
                },
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
        ),
        body: CameraView(
          title: 'Camera Calibration',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
        ));
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final barcodes = await barcodeScanner.processImage(inputImage);
    var calibrationDataBox = await Hive.openBox('calibrationDataBox');
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeDetectorPainterCalibration(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);

      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {
        injectCalibrationData(
            context,
            barcodes,
            inputImage.inputImageData!.size,
            inputImage.inputImageData!.imageRotation,
            calibrationDataBox);
      });
    }
  }
}
