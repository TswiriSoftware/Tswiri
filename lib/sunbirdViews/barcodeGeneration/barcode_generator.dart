import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> barcodePdfGenerator(int rangeStart, int rangeEnd) {
  final document = Document();
  List<int> rangeOfBarcodes =
      List.generate(rangeEnd - rangeStart + 1, (index) => index + rangeStart);
  List<int> numberOfPages =
      List.generate(((rangeOfBarcodes.length) ~/ 6), (index) => index + 1);

  int remainder = (rangeOfBarcodes.length) % 6;

  for (var i = 0; i <= numberOfPages.length; i++) {
    if (i < numberOfPages.length) {
      document.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.GridView(
                direction: Axis.vertical,
                crossAxisCount: 2,
                children: generateBarcodes(6, rangeOfBarcodes[i * 6]));
          }));
    } else if (remainder > 0) {
      document.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.GridView(
                direction: Axis.vertical,
                crossAxisCount: 2,
                children: generateBarcodes(remainder, rangeOfBarcodes[i * 6]));
          }));
    }
  }
  return document.save();
}

List<Widget> generateBarcodes(int numberOfBarcodes, int startBarcode) {
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
                width: 200,
                color: PdfColor.fromHex("#000000"),
                barcode: pw.Barcode.qrCode(),
                data: "${startBarcode + index}",
              ),
            ]));
  });

  return test;
}
