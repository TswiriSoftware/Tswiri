import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcode_scanning/barcode_value_scanning/scanned_barcodes_selection_view.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../../../VisionDetectorViews/camera_view.dart';
import '../painters/barcode_painter.dart';

class SingleBarcodeScanViewOLD extends StatefulWidget {
  const SingleBarcodeScanViewOLD({Key? key}) : super(key: key);

  @override
  _SingleBarcodeScanViewState createState() => _SingleBarcodeScanViewState();
}

class _SingleBarcodeScanViewState extends State<SingleBarcodeScanViewOLD> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;
  Set<String> scannedBarcodes = {};

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
                onPressed: () async {
                  if (scannedBarcodes.length >= 2) {
                    ///Await selected barcodeUID.
                    String selectedBarcodeUID = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScannedBarcodesSelectionView(
                            scannedBarcodes: scannedBarcodes),
                      ),
                    );

                    ///Pop and return selectedBarcodeUID.
                    Navigator.pop(context, selectedBarcodeUID);
                  } else if (scannedBarcodes.length == 1) {
                    ///Pop and return selectedBarcodeUID.
                    Navigator.pop(context, scannedBarcodes.first);
                  } else if (scannedBarcodes.isEmpty) {
                    Navigator.pop(context, 'clear');
                  }
                },
                child: const Icon(Icons.check_circle_outline_rounded),
              ),
            ],
          ),
        ),
        body: CameraView(
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
        scannedBarcodes.add(barcode.value.displayValue!);
      }
      //Paint square on screen around barcode.
      final painter = BarcodePainter(barcodes, inputImage.inputImageData!.size,
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
