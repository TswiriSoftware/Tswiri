// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/views/scanning/multiple/multiple_camera_view.dart';
import 'package:flutter_google_ml_kit/views/scanning/multiple/multiple_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class MultipleScannerView extends StatefulWidget {
  const MultipleScannerView({Key? key}) : super(key: key);

  @override
  _MultipleScannerViewState createState() => _MultipleScannerViewState();
}

class _MultipleScannerViewState extends State<MultipleScannerView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;

  Set<String> scannedBarcodes = {};
  bool showList = false;

  @override
  void dispose() {
    barcodeScanner.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  if (scannedBarcodes.length >= 2) {
                    ///Pop and return selectedBarcodeUID.
                    Navigator.pop(context, scannedBarcodes);
                  } else if (scannedBarcodes.isEmpty) {
                    Navigator.pop(context);
                  }
                },
                child: const Icon(Icons.check_circle_outline_rounded),
              ),
            ],
          ),
        ),
        body: MultipleCameraView(
          title: 'Barcode Scanner',
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

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      //Dont bother if we haven't detected more than one barcode on a image.
      for (Barcode barcode in barcodes) {
        scannedBarcodes.add(barcode.displayValue!);
      }
      //Paint square on screen around barcode.
      final painter = MultiplePainter(barcodes, inputImage.inputImageData!.size,
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
