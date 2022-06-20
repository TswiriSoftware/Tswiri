// ignore_for_file: library_private_types_in_public_api

// import 'dart:developer';
import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_data.dart';

import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart' as vm;

class TensorDataCapturingView extends StatefulWidget {
  const TensorDataCapturingView({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  _TensorDataCapturingViewState createState() =>
      _TensorDataCapturingViewState();
}

class _TensorDataCapturingViewState extends State<TensorDataCapturingView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;

  List<TensorData> tensorData = [];
  bool isCapturing = false;

  vm.Vector3 accelerometerEvent = vm.Vector3(0, 0, 0);
  vm.Vector3 zeroY = vm.Vector3(0, 1, 0);
  vm.Vector3 zeroX = vm.Vector3(1, 0, 0);

  double angleX = 0;
  double angleY = 0;
  double angleZ = 0;

  @override
  void initState() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      accelerometerEvent = vm.Vector3(event.x, event.y, event.z);
      double dotY = vm.dot3(zeroY, vm.Vector3(0, event.y, 0));
      double magAccY = accelerometerEvent.length;
      double magZeroY = zeroY.length;

      angleY = roundDouble(
          (90 - m.acos((dotY) / (magAccY * magZeroY)) * (180 / m.pi)), 2);

      double dotX = vm.dot3(zeroX, vm.Vector3(event.x, 0, 0));
      double magAccX = accelerometerEvent.length;
      double magZeroX = zeroX.length;

      angleX = roundDouble(
          (90 - m.acos((dotX) / (magAccX * magZeroX)) * (180 / m.pi)), 2);
    });

    super.initState();
  }

  @override
  void dispose() {
    barcodeScanner.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'x: $angleX',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'y: $angleY',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 50,
            ),
            FloatingActionButton(
              backgroundColor: widget.color,
              heroTag: null,
              onPressed: () {
                if (isCapturing) {
                  Navigator.pop(context, tensorData);
                } else {
                  setState(() {
                    isCapturing = true;
                  });
                }
              },
              child: isCapturing
                  ? Text(tensorData.length.toString())
                  : const Icon(Icons.start),
            ),
          ],
        ),
        body: TensorCameraView(
          color: widget.color ?? sunbirdOrange,
          title: 'Scanner',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
        ));
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    List<TensorData> data = [];

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      for (Barcode barcode in barcodes) {
        if (isCapturing) {
          List<m.Point<int>> cornerPoints = [];
          for (m.Point<int> point in barcode.cornerPoints!) {
            cornerPoints.add(point - barcode.cornerPoints![0]);
          }
          if (isCapturing) {
            data.add(
                TensorData(cp: cornerPoints, angle: [angleX, angleY, angleZ]));
          }
        }
      }

      if (tensorData.isEmpty) {
        tensorData = data;
      }

      final painter = TensorPainter(
        barcodes: barcodes,
        absoluteImageSize: inputImage.inputImageData!.size,
        rotation: inputImage.inputImageData!.imageRotation,
      );

      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
