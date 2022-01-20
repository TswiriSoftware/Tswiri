import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePDF() {
  final document = Document();

  document.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.BarcodeWidget(
            color: PdfColor.fromHex("#000000"),
            barcode: pw.Barcode.qrCode(),
            data: "My data",
          ),
        ); // Center);
      }));

  return document.save();
}
