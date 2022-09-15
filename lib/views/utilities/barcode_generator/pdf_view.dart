// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tswiri_database/functions/barcodes/barcode_pdf_generator.dart';

class PdfView extends StatefulWidget {
  const PdfView(
      {Key? key,
      required this.barcodeUIDs,
      required this.size,
      required this.start,
      required this.end})
      : super(key: key);

  final List<String> barcodeUIDs;
  final double size;
  final int start;
  final int end;

  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  late Future<Uint8List> future = getPDF();
  Uint8List? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Range: ${widget.start} to ${widget.end}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<Uint8List>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return PDFView(
              pdfData: snapshot.data,
              fitPolicy: FitPolicy.BOTH,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (path != null) {
            await Printing.layoutPdf(
                format: PdfPageFormat.a4,
                onLayout: (_) => path!.buffer.asUint8List(),
                name: 'barcodes_${widget.start}_to_${widget.end}.pdf');
          }
        },
        child: const Icon(Icons.print),
      ),
    );
  }

  ///Retrieve pdf.
  Future<Uint8List> getPDF() async {
    final filePath = await barcodePdfGenerator(
      barcodeUIDs: widget.barcodeUIDs,
      size: widget.size,
    );

    setState(() {
      path = filePath;
    });

    return filePath;
  }
}
