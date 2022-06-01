import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> barcodePdfGenerator({
  required List<String> barcodeUIDs,
  required double size,
  required int start,
  required int end,
}) async {
  final pdf = pw.Document();

  double convertionWidth = PdfPageFormat.a4.width / 210;
  double convertionHeight = PdfPageFormat.a4.height / 297;
  double realWidth = size * convertionWidth;
  double realHeight = size * convertionHeight + (5 * convertionWidth);

  int crossAxisCount = PdfPageFormat.a4.availableWidth ~/ realWidth;
  int mainAxisCount = (PdfPageFormat.a4.availableHeight ~/ realHeight);

  int numberPerPage = crossAxisCount * mainAxisCount;

  int numberOfPages = (barcodeUIDs.length ~/ numberPerPage);
  int remainder = barcodeUIDs.length % numberPerPage;

  for (var i = 0; i <= numberOfPages; i++) {
    if (i < numberOfPages) {
      pdf.addPage(
        pw.Page(
          margin: pw.EdgeInsets.zero,
          build: (pw.Context context) {
            return pw.GridView(
              direction: pw.Axis.vertical,
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
      pdf.addPage(
        pw.Page(
          margin: pw.EdgeInsets.zero,
          build: (pw.Context context) {
            return pw.GridView(
              direction: pw.Axis.vertical,
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

  return await pdf.save();
}

List<pw.Widget> generatePageBarcodes(
    int numberOfBarcodes, List<String> barcodeUIDs, double size) {
  List<pw.Widget> barcodes = [];
  for (String barcodeUID in barcodeUIDs) {
    barcodes.add(
      pw.Padding(
        padding: const pw.EdgeInsets.all(1),
        child: pw.Column(
          mainAxisSize: pw.MainAxisSize.max,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(barcodeUID, style: pw.TextStyle(fontSize: (size / 15))),
            pw.BarcodeWidget(
              height: size,
              width: size,
              color: PdfColor.fromHex("#000000"),
              barcode: pw.Barcode.qrCode(
                  errorCorrectLevel: pw.BarcodeQRCorrectionLevel.high),
              data: barcodeUID,
            ),
          ],
        ),
      ),
    );
  }

  return barcodes;
}
