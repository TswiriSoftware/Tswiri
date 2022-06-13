// ignore_for_file: library_private_types_in_public_api

// import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_data.dart';

import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///Will return a String? BarcodeUID
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
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

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

  // FloatingActionButton _startRecording() {
  //   return FloatingActionButton(
  //     backgroundColor: widget.color,
  //     heroTag: null,
  //     onPressed: () {
  //       setState(() {
  //         isCapturing = true;
  //       });
  //     },
  //     child: const Icon(Icons.start),
  //   );
  // }

  // FloatingActionButton _endRecording() {
  //   return FloatingActionButton(
  //     backgroundColor: widget.color,
  //     heroTag: null,
  //     onPressed: () {
  //       Navigator.pop(context, tensorData);
  //     },
  //     child: Text(tensorData.length.toString()),
  //   );
  // }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      for (Barcode barcode in barcodes) {
        if (isCapturing) {
          List<m.Point<int>> cornerPoints = [];
          for (m.Point<int> point in barcode.cornerPoints!) {
            cornerPoints.add(point - barcode.cornerPoints![0]);
          }
          if (isCapturing) {
            tensorData.add(TensorData(cp: cornerPoints));
          }
        }
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
