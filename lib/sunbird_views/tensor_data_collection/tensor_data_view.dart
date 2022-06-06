// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/single_barcode_scanner/single_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/single_barcode_scanner/single_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../../functions/barcode_calculations/calculate_barcode_center_from_bounding_box.dart';

///Will return a String? BarcodeUID
class TensorDataView extends StatefulWidget {
  const TensorDataView({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  _TensorDataViewState createState() => _TensorDataViewState();
}

class _TensorDataViewState extends State<TensorDataView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;
  String? barcodeID;
  int? timestamp;
  bool isBusy2 = false;

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
        body: SingleCameraView(
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
    double? closestBarcodeDistance;
    String? closestBarcodeID;
    final List<Barcode> barcodes =
        await barcodeScanner.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      ///Code for barcode Closets to center.
      Offset imageCenter = Offset(inputImage.inputImageData!.size.height / 2,
          inputImage.inputImageData!.size.width / 2);

      //Run through all barcodes.
      for (Barcode barcode in barcodes) {
        if (barcodes.isNotEmpty && mounted) {
          //Calculate distance from screen center
          double distanceFromCenter =
              (imageCenter - calculateBarcodeCenterFromBoundingBox(barcode))
                  .distance;

          if (closestBarcodeDistance == null) {
            closestBarcodeDistance = distanceFromCenter;
            closestBarcodeID = barcode.displayValue;
          } else if (closestBarcodeDistance > distanceFromCenter) {
            closestBarcodeID = barcode.displayValue;
          }
        } else if (mounted) {
          barcodeID = null;
        }
      }

      barcodeID = closestBarcodeID;
      if (timestamp == null) {
        timestamp = DateTime.now().millisecondsSinceEpoch;
      } else if (barcodeID != closestBarcodeID || barcodeID == null) {
        timestamp = DateTime.now().millisecondsSinceEpoch;
      } else if (barcodeID != null &&
          barcodeID == closestBarcodeID &&
          (timestamp! + 2000) <= DateTime.now().millisecondsSinceEpoch) {
        autoSelect();
      }

      log(barcodeID.toString());
      final painter = SinglePainter(
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

  void autoSelect() {
    if (isBusy2) return;
    isBusy2 = true;
    HapticFeedback.lightImpact();
    Navigator.pop(context, barcodeID);
  }
}
