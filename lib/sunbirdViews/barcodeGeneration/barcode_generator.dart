import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePDF(int rangeStart, int rangeEnd) {
  List<int> range =
      List.generate(rangeEnd - rangeStart + 1, (index) => index + rangeStart);
  List<int> numberOfPages =
      List.generate(((range.length) ~/ 6), (index) => index + 1);

  return doc(numberOfPages, range).save();
}

List<Widget> barcodes(int numberOfBarcodes, int startBarcode) {
  List<Widget> test = List<Widget>.generate(numberOfBarcodes, (int index) {
    return pw.Padding(
        padding: const EdgeInsets.all(0),
        child: pw.Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pw.Text('${startBarcode + index}',
                  style: const TextStyle(fontSize: 15)),
              pw.BarcodeWidget(
                height: 200,
                color: PdfColor.fromHex("#000000"),
                barcode: pw.Barcode.qrCode(),
                data: "${startBarcode + index}",
              ),
            ]));
  });

  return test;
}

Document doc(List<int> numberOfPages, List<int> range) {
  int remainder = (range.length) % 6;
  final document = Document();
  for (var i = 0; i <= numberOfPages.length; i++) {
    if (i < numberOfPages.length) {
      document.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.GridView(
                direction: Axis.vertical,
                crossAxisCount: 2,
                children: barcodes(6, range[i]));
          }));
    } else if (remainder > 0) {
      document.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.GridView(
                direction: Axis.vertical,
                crossAxisCount: 2,
                children: barcodes(remainder, range[i * 6]));
          }));
    }
  }
  return document;
}
