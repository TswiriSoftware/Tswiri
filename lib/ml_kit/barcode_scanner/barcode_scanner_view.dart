import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:tswiri_database_interface/models/settings/app_settings.dart';
import 'barcode_scanner_camera_view.dart';
import 'barcode_scanner_painter.dart';

///Returns a single barcodeUID.
class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  //Initialize barcode scanner
  final _barcodeScanner = BarcodeScanner(
    formats: [
      BarcodeFormat.all,
    ],
  );

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  String? currentBarcode;
  int? timestamp;
  bool _isBusy2 = false;

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
    return BarcodeScannerCameraView(
        title: 'Barcode Scanner',
        customPaint: _customPaint,
        onImage: (inputImage) {
          processImage(inputImage);
        });
  }

  Widget _confirmButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pop(context, currentBarcode);
      },
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: const Icon(
        Icons.check_sharp,
      ),
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    if (_isBusy2) return;
    _isBusy = true;

    final barcodes = await _barcodeScanner.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = BarcodeScannerPainter(
          mounted: mounted,
          barcodes: barcodes,
          absoluteImageSize: inputImage.inputImageData!.size,
          rotation: inputImage.inputImageData!.imageRotation,
          currentBarcode: currentBarcode,
          callback: (uid) {
            if (!_isBusy2) {
              currentBarcode = uid ?? currentBarcode;
              if (timestamp == null) {
                timestamp = DateTime.now().millisecondsSinceEpoch;
              } else if (uid != currentBarcode || uid == null) {
                timestamp = DateTime.now().millisecondsSinceEpoch;
              } else if (uid == currentBarcode &&
                  (timestamp! + 2000) <=
                      DateTime.now().millisecondsSinceEpoch) {
                autoSelect();
              }
            }
          });

      _customPaint = CustomPaint(painter: painter);
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  void autoSelect() async {
    if (_isBusy2) return;
    _isBusy2 = true;

    if (vibrate) {
      HapticFeedback.lightImpact();
    }

    if (mounted) {
      await Future.delayed(const Duration(milliseconds: 10));

      // ignore: use_build_context_synchronously
      Navigator.pop(context, currentBarcode);
    }
  }
}
