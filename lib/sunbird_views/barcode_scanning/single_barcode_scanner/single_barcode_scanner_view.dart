import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/single_barcode_scanner/single_barcode_scanner_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/single_barcode_scanner/single_barcode_scanner_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///Will return a String? BarcodeUID
class SingleBarcodeScannerView extends StatefulWidget {
  const SingleBarcodeScannerView({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  _SingleBarcodeScannerViewState createState() =>
      _SingleBarcodeScannerViewState();
}

class _SingleBarcodeScannerViewState extends State<SingleBarcodeScannerView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;
  String? barcodeID;

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
                Navigator.pop(context, barcodeID);
              },
              child: const Icon(Icons.check_circle_outline_rounded),
            ),
          ],
        ),
        body: SingleBarcodeScannerCameraView(
          color: widget.color ?? sunbirdOrange,
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

    //Closest barcode to center distance.
    double? clostesBarcodeDistance;

    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      ///Code for barcode Closets to center.
      Offset imageCenter = Offset(inputImage.inputImageData!.size.height / 2,
          inputImage.inputImageData!.size.width / 2);

      //Run through all barcodes.
      for (Barcode barcode in barcodes) {
        if (barcodes.isNotEmpty &&
            barcodes.first.value.displayValue != null &&
            mounted) {
          //Calculate distance from screen center
          double distanceFromCenter =
              (imageCenter - calculateBarcodeCenterOffset(barcode)).distance;

          //If it is the closest it will update the button value.
          if (clostesBarcodeDistance == null) {
            clostesBarcodeDistance = distanceFromCenter;
            barcodeID = barcode.value.displayValue;
            setState(() {});
          } else if (clostesBarcodeDistance > distanceFromCenter) {
            clostesBarcodeDistance = distanceFromCenter;
            barcodeID = barcode.value.displayValue;
            setState(() {});
          }
        }
      }

      final painter = SingleBarcodeScannerPainter(
          barcodes: barcodes,
          absoluteImageSize: inputImage.inputImageData!.size,
          rotation: inputImage.inputImageData!.imageRotation,
          barcodeID: barcodeID);

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

Offset calculateBarcodeCenterOffset(Barcode barcode) {
  double top = barcode.value.boundingBox!.top;
  double bottom = barcode.value.boundingBox!.bottom;
  double left = barcode.value.boundingBox!.left;
  double right = barcode.value.boundingBox!.right;

  Rect boundingBox = Rect.fromLTRB(left, top, right, bottom);
  return boundingBox.center;
}
