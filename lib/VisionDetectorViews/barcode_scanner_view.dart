import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/dataProcessors/barcode_database_injector.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'camera_view.dart';
import 'painters/barcode_detector_painter.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({Key? key}) : super(key: key);

  @override
  _BarcodeScannerViewState createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;
  late Box<dynamic> box;

  @override
  void initState() async {
     box = await Hive.openBox('qrCodes');
  }

  @override
  void dispose() 
  {
    box.close();
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
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
    //print('Found ${barcodes.length} barcodes');

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      // var isPortrait =
      //     MediaQuery.of(context).orientation == Orientation.portrait;
      // InputImageRotation rotation;

      // if (isPortrait == true) {
      //   rotation = InputImageRotation.Rotation_90deg;
      // } else {
      //   rotation = InputImageRotation.Rotation_180deg;
      // }
      //print(inputImage.inputImageData!.size);

      final painter = BarcodeDetectorPainter(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);

      

      injectBarcode(barcodes,inputImage.inputImageData!.size,inputImage.inputImageData!.imageRotation,box);

      if (barcodes.isNotEmpty) {
        // print(painter.absoluteImageSize);
        // print(painter.rotation);
        // print(painter.barcodes);
      }

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
