import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePDF(List<int> qrCodeData) {
  final document = Document();

  List<Widget> barcodes = List<Widget>.generate(qrCodeData.length, (int index) {
    return pw.Padding(
        padding: EdgeInsets.all(0),
        child: pw.Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pw.Text('${qrCodeData[index]}', style: TextStyle(fontSize: 15)),
              pw.BarcodeWidget(
                height: 200,
                color: PdfColor.fromHex("#000000"),
                barcode: pw.Barcode.qrCode(),
                data: "${qrCodeData[index]}",
              ),
            ]));
  });

  document.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.GridView(
            direction: Axis.vertical, crossAxisCount: 2, children: barcodes);
      }));

  return document.save();
}
