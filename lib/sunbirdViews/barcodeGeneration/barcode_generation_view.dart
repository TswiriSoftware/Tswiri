import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeGeneration/barcode_generator.dart';
import 'package:printing/printing.dart';

class QrCodeGenerationView extends StatefulWidget {
  const QrCodeGenerationView(
      {Key? key, required this.rangeStart, required this.rangeEnd})
      : super(key: key);
  final int rangeStart;
  final int rangeEnd;

  @override
  _QrCodeGenerationViewState createState() => _QrCodeGenerationViewState();
}

class _QrCodeGenerationViewState extends State<QrCodeGenerationView> {
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
      body: CustomCardQrCode(widget.rangeStart, widget.rangeEnd),
    );
  }
}

class CustomCardQrCode extends StatelessWidget {
  final int rangeStart;
  final int rangeEnd;

  // ignore: use_key_in_widget_constructors
  const CustomCardQrCode(this.rangeStart, this.rangeEnd);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PdfPreview(
            maxPageWidth: MediaQuery.of(context).size.width,
            build: (format) => generatePDF(rangeStart, rangeEnd)));
  }
}
