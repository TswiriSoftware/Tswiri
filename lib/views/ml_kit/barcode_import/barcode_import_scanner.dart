// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import 'barcode_import_camera_view.dart';
import 'single_barcode_painter.dart';

///Returns a single barcodeUID.
class BarcodeImportScannerView extends StatefulWidget {
  const BarcodeImportScannerView({Key? key}) : super(key: key);

  @override
  State<BarcodeImportScannerView> createState() =>
      _BarcodeImportScannerViewState();
}

class _BarcodeImportScannerViewState extends State<BarcodeImportScannerView> {
  //Initialize barcode scanner
  final _barcodeScanner = BarcodeScanner(
    formats: [
      BarcodeFormat.qrCode,
    ],
  );

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  Set<String> scannedBarcodes = {};

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: _confirmButton(),
    );
  }

  Widget _body() {
    return BarcodeImportCameraView(
        title: 'Barcode Scanner',
        customPaint: _customPaint,
        onImage: (inputImage) {
          processImage(inputImage);
        });
  }

  Widget _confirmButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pop(
          context,
          scannedBarcodes,
        );
      },
      child: const Icon(
        Icons.check_sharp,
      ),
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final barcodes = await _barcodeScanner.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeImportPainter(
        barcodes: barcodes,
        absoluteImageSize: inputImage.inputImageData!.size,
        rotation: inputImage.inputImageData!.imageRotation,
      );

      _customPaint = CustomPaint(painter: painter);

      scannedBarcodes.addAll(barcodes.map((e) => e.displayValue!));
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
