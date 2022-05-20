import 'dart:developer';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> barcodePdfGenerator(
    {required List<String> barcodeUIDs, required double size}) {
  final document = Document();

  double convertionWidth = PdfPageFormat.a4.width / 210;
  double convertionHeight = PdfPageFormat.a4.height / 297;
  double realWidth = size * convertionWidth;
  double realHeight = size * convertionHeight + (10 * convertionWidth);

  int crossAxisCount = PdfPageFormat.a4.availableWidth ~/ realWidth;
  int mainAxisCount = (PdfPageFormat.a4.availableHeight ~/ realHeight);

  log(crossAxisCount.toString());
  log(mainAxisCount.toString());

  int numberPerPage = crossAxisCount * mainAxisCount;

  int numberOfPages = (barcodeUIDs.length ~/ numberPerPage);
  int remainder = barcodeUIDs.length % numberPerPage;

  log(realHeight.toString());

  for (var i = 0; i <= numberOfPages; i++) {
    if (i < numberOfPages) {
      document.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.GridView(
              direction: Axis.vertical,
              crossAxisCount: crossAxisCount,
              children: generatePageBarcodes(
                6,
                barcodeUIDs
                    .getRange(
                        i * numberPerPage, i * numberPerPage + numberPerPage)
                    .toList(),
                realWidth,
              ),
            );
          },
        ),
      );
    } else if (remainder > 0) {
      document.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.GridView(
              direction: Axis.vertical,
              crossAxisCount: crossAxisCount,
              children: generatePageBarcodes(
                remainder,
                barcodeUIDs
                    .getRange(i * numberPerPage, i * numberPerPage + remainder)
                    .toList(),
                realWidth,
              ),
            );
          },
        ),
      );
    }
  }

  return document.save();
}

List<Widget> generatePageBarcodes(
    int numberOfBarcodes, List<String> barcodeUIDs, double size) {
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
            pw.Text(barcodeUID, style: TextStyle(fontSize: (size / 15))),
            pw.BarcodeWidget(
              height: size,
              width: size,
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
