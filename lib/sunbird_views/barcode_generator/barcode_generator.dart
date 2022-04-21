import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> barcodePdfGenerator({required List<String> barcodeUIDs}) {
  final document = Document();

  int numberOfPages = (barcodeUIDs.length ~/ 6);
  int remainder = barcodeUIDs.length % 6;

  //log('number of barcodes: ' + barcodeUIDs.length.toString());
  //log('remainder: ' + remainder.toString());
  //log('number of pages: ' + numberOfPages.toString());

  for (var i = 0; i <= numberOfPages; i++) {
    if (i < numberOfPages) {
      //log('page_' + i.toString());
      document.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.GridView(
              direction: Axis.vertical,
              crossAxisCount: 2,
              children: generatePageBarcodes(
                  6, barcodeUIDs.getRange(i * 6, i * 6 + 6).toList()),
            );
          },
        ),
      );
    } else if (remainder > 0) {
      //log('page_' + (i + 1).toString());
      document.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.GridView(
              direction: Axis.vertical,
              crossAxisCount: 2,
              children: generatePageBarcodes(remainder,
                  barcodeUIDs.getRange(i * 6, i * 6 + remainder).toList()),
            );
          },
        ),
      );
    }
  }

  return document.save();
}

List<Widget> generatePageBarcodes(
    int numberOfBarcodes, List<String> barcodeUIDs) {
  List<Widget> barcodes = [];
  for (String barcodeUID in barcodeUIDs) {
    barcodes.add(
      pw.Padding(
        padding: const EdgeInsets.all(0),
        child: pw.Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pw.Text(barcodeUID, style: const TextStyle(fontSize: 15)),
            pw.BarcodeWidget(
              height: 200,
              width: 200,
              color: PdfColor.fromHex("#000000"),
              barcode: pw.Barcode.qrCode(),
              data: barcodeUID,
            ),
          ],
        ),
      ),
    );
  }

  return barcodes;
}
