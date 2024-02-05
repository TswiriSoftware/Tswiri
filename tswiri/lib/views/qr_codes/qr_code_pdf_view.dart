import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tswiri/extensions.dart';
import 'package:tswiri/functions/barcode_pdf_generator.dart';

class QrCodePDFView extends StatefulWidget {
  final List<String> barcodeUUIDs;
  final double size;

  const QrCodePDFView({
    super.key,
    required this.barcodeUUIDs,
    required this.size,
  });

  @override
  State<QrCodePDFView> createState() => _QrCodePDFViewState();
}

class _QrCodePDFViewState extends State<QrCodePDFView> {
  late Future<Uint8List> future;
  late int start;
  late int end;

  @override
  void initState() {
    super.initState();
    future = _buildPDF();

    start = widget.barcodeUUIDs.firstOrNull?.barcodeNumber ?? 0;
    end = widget.barcodeUUIDs.lastOrNull?.barcodeNumber ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code PDF'),
      ),
      body: FutureBuilder<Uint8List>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return PdfPreview(
              build: ((format) => snapshot.data!),
              pageFormats: const {'A4': PdfPageFormat.a4},
              canChangeOrientation: false,
              canChangePageFormat: false,
              initialPageFormat: PdfPageFormat.a4,
              canDebug: false,
              pdfFileName: 'barcode_${start}_to_$end.pdf',
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<Uint8List> _buildPDF() async {
    return qrCodePDFGenerator(
      barcodeUUIDs: widget.barcodeUUIDs,
      size: widget.size,
    );
  }
}
