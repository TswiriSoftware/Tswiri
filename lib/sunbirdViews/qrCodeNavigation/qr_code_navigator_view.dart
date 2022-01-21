import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/camera_view.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/barcode_detector_painter_calibration.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/barcode_detector_painter_navigation.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/qrCodeNavigation/qr_code_navigation_view.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:vector_math/vector_math.dart';

class QrCodeNavigatorView extends StatefulWidget {
  final String qrcodeID;
  const QrCodeNavigatorView({Key? key, required this.qrcodeID})
      : super(key: key);

  @override
  _QrCodeNavigatorViewState createState() => _QrCodeNavigatorViewState();
}

class _QrCodeNavigatorViewState extends State<QrCodeNavigatorView> {
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  bool isBusy = false;
  CustomPaint? customPaint;

  Map<String, Vector2> consolidatedData = {};

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
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QrCodeNavigationView()));
                },
                child: const Icon(Icons.check_rounded),
              ),
            ],
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

  Map<String, Vector2> getConsolidatedData(Box consolidatedData) {
    Map map = consolidatedData.toMap();
    Map<String, Vector2> mapConsolidated = {};
    map.forEach((key, value) {
      ConsolidatedData data = value;
      mapConsolidated.update(
        key,
        (value) => Vector2(data.X, data.Y),
        ifAbsent: () => Vector2(data.X, data.Y),
      );
    });
    return mapConsolidated;
  }
}
