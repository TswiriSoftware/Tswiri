import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/camera_view.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/barcode_detector_painter_navigation.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/consolidated_data_adapter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

class BarcodeNavigatorView extends StatefulWidget {
  final String qrcodeID;
  const BarcodeNavigatorView({Key? key, required this.qrcodeID})
      : super(key: key);

  @override
  _BarcodeNavigatorViewState createState() => _BarcodeNavigatorViewState();
}

class _BarcodeNavigatorViewState extends State<BarcodeNavigatorView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;

  Map<String, Offset> consolidatedData = {};

  @override
  void initState() {
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [],
          ),
        ),
        body: CameraView(
          title: 'Camera Calibration',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
        ));
  }

  Future<void> processImage(InputImage inputImage) async {
    var consolidatedDataBox = await Hive.openBox('consolidatedDataBox');
    consolidatedData = getConsolidatedData(consolidatedDataBox);

    if (isBusy) return;
    isBusy = true;
    final barcodes = await barcodeScanner.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeDetectorPainterNavigation(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation,
          consolidatedData,
          widget.qrcodeID);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Map<String, Offset> getConsolidatedData(Box consolidatedData) {
    Map map = consolidatedData.toMap();
    Map<String, Offset> mapConsolidated = {};
    map.forEach((key, value) {
      ConsolidatedData data = value;
      mapConsolidated.update(
        key,
        (value) => Offset(data.offset.x, data.offset.y),
        ifAbsent: () => Offset(data.offset.x, data.offset.y),
      );
    });
    return mapConsolidated;
  }
}

// _getRelativePosition(List<Barcode> barcodes, Size absoluteImageSize,
//     InputImageRotation rotation) {
//   for (final Barcode barcode in barcodes) {
//     final boundingBoxLeft = translateX(
//         barcode.value.boundingBox!.left, rotation, size, absoluteImageSize);
//     final boundingBoxTop = translateY(
//         barcode.value.boundingBox!.top, rotation, size, absoluteImageSize);
//     final boundingBoxRight = translateX(
//         barcode.value.boundingBox!.right, rotation, size, absoluteImageSize);
//     final boundingBoxBottom = translateY(
//         barcode.value.boundingBox!.bottom, rotation, size, absoluteImageSize);
//   }
// }
