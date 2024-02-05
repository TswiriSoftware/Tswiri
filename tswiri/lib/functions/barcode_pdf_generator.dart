import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

///Generates a pdf document containing barcodes.
///
/// - List<String> barcodeUIDs
/// - double Size of the barcodes in mm
Future<Uint8List> qrCodePDFGenerator({
  required List<String> barcodeUUIDs,
  required double size,
}) async {
  final pdf = Document();

  final conversionWidth = PdfPageFormat.a4.width / 210;
  final conversionHeight = PdfPageFormat.a4.height / 297;

  final realWidth = size * conversionWidth;
  final realHeight = size * conversionHeight;

  final totalWidth = realWidth + (12 * conversionWidth);
  final totalHeight = realHeight + (12 * conversionHeight);

  final crossAxisCount = (PdfPageFormat.a4.width ~/ totalWidth);
  final mainAxisCount = (PdfPageFormat.a4.height ~/ totalHeight);

  final numberPerPage = crossAxisCount * mainAxisCount;
  final numberOfPages = (barcodeUUIDs.length ~/ numberPerPage);
  final remainder = barcodeUUIDs.length % numberPerPage;

  for (var i = 0; i <= numberOfPages; i++) {
    List<String>? uuids;
    List<Widget>? barcodes;

    if (i < numberOfPages) {
      uuids = barcodeUUIDs
          .getRange(i * numberPerPage, i * numberPerPage + numberPerPage)
          .toList();

      barcodes = generatePageBarcodes(
        numberOfBarcodes: 6,
        barcodeUUIDs: uuids,
        size: realWidth,
        conversionWidth: conversionWidth,
        conversionHeight: conversionHeight,
      );
    } else if (remainder > 0) {
      uuids = barcodeUUIDs
          .getRange(i * numberPerPage, i * numberPerPage + remainder)
          .toList();

      barcodes = generatePageBarcodes(
        numberOfBarcodes: remainder,
        barcodeUUIDs: uuids,
        size: realWidth,
        conversionWidth: conversionWidth,
        conversionHeight: conversionHeight,
      );
    }

    if (uuids == null || barcodes == null) continue;

    final page = Page(
      margin: EdgeInsets.zero,
      build: (Context context) {
        return GridView(
          direction: Axis.vertical,
          crossAxisCount: crossAxisCount,
          children: barcodes!,
        );
      },
    );

    pdf.addPage(page);
  }

  return await pdf.save();
}

// Generates a page worth of barcodes.
List<Widget> generatePageBarcodes({
  required int numberOfBarcodes,
  required List<String> barcodeUUIDs,
  required double size,
  required double conversionWidth,
  required double conversionHeight,
}) {
  final left = 5 * conversionWidth;
  final right = 5 * conversionWidth;
  final bottom = 5 * conversionHeight;
  final top = 3 * conversionHeight;

  const borderSide = BorderSide(
    style: BorderStyle(
      pattern: [2, 6],
    ),
  );

  final barcodes = barcodeUUIDs.map((uuid) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.only(
        left: left,
        right: right,
        bottom: bottom,
        top: top,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: borderSide,
          top: borderSide,
          left: borderSide,
          right: borderSide,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            uuid,
            style: TextStyle(
              fontSize: ((2) * conversionHeight),
            ),
          ),
          BarcodeWidget(
            width: size,
            height: size,
            color: PdfColors.black,
            barcode: Barcode.qrCode(
              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
            ),
            data: uuid,
          ),
        ],
      ),
    );
  }).toList();

  return barcodes;
}
