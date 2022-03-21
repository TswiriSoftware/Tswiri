import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_generator/barcode_generator.dart';
import 'package:printing/printing.dart';

class BarcodeGenerationView extends StatefulWidget {
  const BarcodeGenerationView({
    Key? key,
    required this.barcodeUIDs,
  }) : super(key: key);

  final List<String> barcodeUIDs;

  @override
  _BarcodeGenerationViewState createState() => _BarcodeGenerationViewState();
}

class _BarcodeGenerationViewState extends State<BarcodeGenerationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Barcode Printer',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomCardQrCode(
        barcodeUIDs: widget.barcodeUIDs,
      ),
    );
  }
}

class CustomCardQrCode extends StatelessWidget {
  const CustomCardQrCode({Key? key, required this.barcodeUIDs})
      : super(key: key);
  final List<String> barcodeUIDs;

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
        maxPageWidth: MediaQuery.of(context).size.width,
        build: (format) => barcodePdfGenerator(barcodeUIDs: barcodeUIDs));
  }
}
