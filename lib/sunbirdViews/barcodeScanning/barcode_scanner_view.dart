import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/functions/dataInjectors/barcode_raw_on_image_data_injector.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../VisionDetectorViews/camera_view.dart';
import 'painter/barcode_detector_painter.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({Key? key}) : super(key: key);

  @override
  _BarcodeScannerViewState createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  List<OnImageInterBarcodeDataHiveObject> allBarcodeData = [];
  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    barcodeScanner.close();
    allBarcodeData.forEach((element) {
      debugPrint(
          '${element.uidStart} ,${element.uidEnd}, [${typeOffsetToOffset(element.interBarcodeOffset).dx}, ${typeOffsetToOffset(element.interBarcodeOffset).dy}], ${element.startDiagonalLength}, ${element.endDiagonalLength} ');
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    final barcodes = await barcodeScanner.processImage(inputImage);
    var rawDataBox = await Hive.openBox(rawDataHiveBox);

    barcodeRawOnImageDataInjector(
        barcodes, inputImage.inputImageData!, rawDataBox, allBarcodeData);

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
