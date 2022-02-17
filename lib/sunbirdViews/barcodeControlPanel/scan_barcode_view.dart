import 'dart:async';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/barcode_control_panel.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/scanned_barcodes_selection.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../../VisionDetectorViews/camera_view.dart';
import '../barcodeScanning/painter/barcode_detector_painter.dart';

class ScanBarcodeView extends StatefulWidget {
  const ScanBarcodeView({Key? key}) : super(key: key);

  @override
  _ScanBarcodeViewState createState() => _ScanBarcodeViewState();
}

class _ScanBarcodeViewState extends State<ScanBarcodeView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;

  Set<int> scannedBarcodes = {};

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  if (scannedBarcodes.length >= 2) {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ScannedBarcodesView(
                            scannedBarcodes: scannedBarcodes)));
                  } else if (scannedBarcodes.length == 1) {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BarcodeControlPanelView(
                            barcodeID: scannedBarcodes.first)));
                  }
                },
                child: const Icon(Icons.check_circle_outline_rounded),
              ),
            ],
          ),
        ),
        body: CameraView(
          color: brightOrange,
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
        scannedBarcodes.add(int.parse(barcode.value.displayValue!));
      }
      //Paint square on screen around barcode.
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
