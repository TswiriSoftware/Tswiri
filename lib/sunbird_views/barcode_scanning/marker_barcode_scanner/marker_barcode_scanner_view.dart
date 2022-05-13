import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/marker_barcode_scanner/marker_barcode_scanner_camera_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/marker_barcode_scanner/marker_barcode_scanner_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';

///Will return a String? BarcodeUID
class MarkerBarcodeScannerView extends StatefulWidget {
  const MarkerBarcodeScannerView(
      {Key? key, required this.parentContainer, this.color})
      : super(key: key);
  final ContainerEntry parentContainer;
  final Color? color;
  @override
  _MarkerBarcodeScannerViewState createState() =>
      _MarkerBarcodeScannerViewState();
}

class _MarkerBarcodeScannerViewState extends State<MarkerBarcodeScannerView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;
  String? currentBarcodeUID;
  List<String> selectedBarcodeUIDs = [];
  bool showList = false;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    selectedBarcodeUIDs.addAll(isarDatabase!.markers
        .filter()
        .parentContainerUIDMatches(widget.parentContainer.containerUID)
        .barcodeUIDProperty()
        .findAllSync());

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
      floatingActionButton: _addBarcode(),
      appBar: _appBar(),
      body: Column(
        children: [
          Expanded(
            child: MarkerBarcodeScannerCameraView(
              color: widget.color ?? sunbirdOrange,
              title: 'Barcode Scanner',
              customPaint: customPaint,
              onImage: (inputImage) {
                processImage(inputImage);
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: widget.color,
      centerTitle: true,
      title: Text(
        'Scan Markers',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        Visibility(
          visible: selectedBarcodeUIDs.isNotEmpty,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context, selectedBarcodeUIDs);
            },
            child: Column(
              children: [
                Text(
                  'Continue',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Scanned barcodes: ' + selectedBarcodeUIDs.length.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _addBarcode() {
    return FloatingActionButton(
      backgroundColor: widget.color,
      heroTag: null,
      onPressed: () {
        if (selectedBarcodeUIDs.contains(currentBarcodeUID)) {
          selectedBarcodeUIDs.remove(currentBarcodeUID);
        } else {
          if (currentBarcodeUID != null) {
            selectedBarcodeUIDs.add(currentBarcodeUID!);
          }
        }
      },
      child: const Icon(Icons.add),
    );
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
            setState(() {
              currentBarcodeUID = barcode.value.displayValue;
            });
          } else if (clostesBarcodeDistance > distanceFromCenter) {
            clostesBarcodeDistance = distanceFromCenter;
            setState(() {
              currentBarcodeUID = barcode.value.displayValue;
            });
          }
        }
      }

      final painter = MarkerBarcodeScannerPainter(
          barcodes: barcodes,
          absoluteImageSize: inputImage.inputImageData!.size,
          rotation: inputImage.inputImageData!.imageRotation,
          barcodeID: currentBarcodeUID,
          selectedBarcodeUIDs: selectedBarcodeUIDs);

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
