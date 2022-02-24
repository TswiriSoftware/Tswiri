import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/camera_view_stock.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'painters/barcode_detector_painter.dart';

class BarcodeScannerStockView extends StatefulWidget {
  const BarcodeScannerStockView({Key? key}) : super(key: key);

  @override
  _BarcodeScannerStockViewState createState() =>
      _BarcodeScannerStockViewState();
}

class _BarcodeScannerStockViewState extends State<BarcodeScannerStockView> {
  BarcodeScanner barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraViewStock(
      title: 'Barcode Scanner',
      customPaint: customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final barcodes = await barcodeScanner.processImage(inputImage);
    print('Found ${barcodes.length} barcodes');
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeDetectorPainter(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
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
