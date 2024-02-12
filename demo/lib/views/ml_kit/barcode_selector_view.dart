import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:isar/isar.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri/views/ml_kit/custom_camera_view.dart';
import 'package:tswiri/views/ml_kit/painters/barcode_detector_painter.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class BarcodeSelectorView extends ConsumerStatefulWidget {
  final List<BarcodeFormat> formats;

  const BarcodeSelectorView({
    super.key,
    this.formats = const [BarcodeFormat.all],
  });

  @override
  AbstractScreen<BarcodeSelectorView> createState() =>
      _BarcodeSelectorViewState();
}

class _BarcodeSelectorViewState extends AbstractScreen<BarcodeSelectorView> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner(
    formats: [BarcodeFormat.all],
  );

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCameraView(
      customPaint: _customPaint,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Select'),
        icon: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });

    final barcodes = await _barcodeScanner.processImage(inputImage);
    final validImage = inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null;

    if (validImage) {
      final validatedBarcodes = <(Barcode, bool)>[];

      if (mounted) {
        for (final barcode in barcodes) {
          final barcodeUUID = barcode.displayValue;

          if (barcodeUUID == null) continue;
          final catalogedBarcode = isar.catalogedBarcodes
              .filter()
              .barcodeUUIDMatches(barcodeUUID)
              .findFirstSync();

          print(catalogedBarcode?.toJson());
        }
      }

      // final painter2 = CustomBarcodeDetectorPainter(
      //   validatedBarcodes,
      //   imageSize,
      //   rotation,
      //   cameraLensDirection,
      // );
      final painter = BarcodeDetectorPainter(
        barcodes,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Barcodes found: ${barcodes.length}\n\n';
      for (final barcode in barcodes) {
        text += 'Barcode: ${barcode.rawValue}\n\n';
      }
      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
