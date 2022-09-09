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

  double realWidth = ((size) * convertionWidth);
  double realHeight = ((size) * convertionHeight);

  double totalWidth = realWidth + (12 * convertionWidth);
  double totalHeight = realHeight + (12 * convertionHeight);

  int crossAxisCount = (PdfPageFormat.a4.width ~/ totalWidth);
  int mainAxisCount = (PdfPageFormat.a4.height ~/ totalHeight);

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
                convertionWidth,
                convertionHeight,
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
                convertionWidth,
                convertionHeight,
              ),
            );
          },
        ),
      );
    }
  }

  return await pdf.save();
}

//Generates a page worth of barcodes.
List<pw.Widget> generatePageBarcodes(
  int numberOfBarcodes,
  List<String> barcodeUIDs,
  double size,
  double conversionWidth,
  double conversionHeight,
) {
  List<pw.Widget> barcodes = [];
  for (String barcodeUID in barcodeUIDs) {
    barcodes.add(
      pw.Container(
        padding: pw.EdgeInsets.only(
          left: (5 * conversionWidth),
          right: (5 * conversionWidth),
          bottom: (5 * conversionHeight),
          top: (3 * conversionHeight),
        ),
        decoration: const pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(
              style: pw.BorderStyle(
                pattern: [2, 6],
              ),
            ),
            top: pw.BorderSide(
              style: pw.BorderStyle(
                pattern: [2, 6],
              ),
            ),
            left: pw.BorderSide(
              style: pw.BorderStyle(
                pattern: [2, 6],
              ),
            ),
            right: pw.BorderSide(
              style: pw.BorderStyle(
                pattern: [2, 6],
              ),
            ),
          ),
        ),
        child: pw.Column(
          children: [
            pw.Text(
              barcodeUID,
              style: pw.TextStyle(
                fontSize: (2 * conversionHeight),
              ),
            ),
            pw.BarcodeWidget(
              height: size,
              width: size,
              color: PdfColor.fromHex("#000000"),
              barcode: pw.Barcode.qrCode(
                errorCorrectLevel: pw.BarcodeQRCorrectionLevel.high,
              ),
              data: barcodeUID,
            ),
          ],
        ),
      ),
    );
  }

  return barcodes;
}

// Future<Uint8List> barcodePdfGenerator({
//   required List<String> barcodeUIDs,
//   required double size,
//   required int start,
//   required int end,
// }) async {
//   final pdf = pw.Document();

//   double convertionWidth = PdfPageFormat.a4.width / 210;
//   double convertionHeight = PdfPageFormat.a4.height / 297;

//   double realWidth = (size * convertionWidth);
//   double realHeight = (size * convertionHeight);

//   int crossAxisCount = PdfPageFormat.a4.width ~/ realWidth;
//   int mainAxisCount = PdfPageFormat.a4.height ~/ realHeight;

//   log(size.toString());
//   if (size <= 40 && mainAxisCount > 1) {
//     mainAxisCount = mainAxisCount - 1;
//   }
//   if (mainAxisCount > 18) {
//     mainAxisCount = 18;
//   }
//   if (crossAxisCount > 16) {
//     crossAxisCount = 16;
//   }

//   log(mainAxisCount.toString());
//   log(crossAxisCount.toString());

//   int numberPerPage = crossAxisCount * mainAxisCount;

//   int numberOfPages = (barcodeUIDs.length ~/ numberPerPage);
//   int remainder = barcodeUIDs.length % numberPerPage;

//   for (var i = 0; i <= numberOfPages; i++) {
//     if (i < numberOfPages) {
//       pdf.addPage(
//         pw.Page(
//           margin: pw.EdgeInsets.zero,
//           build: (pw.Context context) {
//             return pw.GridView(
//               direction: pw.Axis.vertical,
//               crossAxisCount: crossAxisCount,
//               children: generatePageBarcodes(
//                 6,
//                 barcodeUIDs
//                     .getRange(
//                         i * numberPerPage, i * numberPerPage + numberPerPage)
//                     .toList(),
//                 realWidth,
//               ),
//             );
//           },
//         ),
//       );
//     } else if (remainder > 0) {
//       pdf.addPage(
//         pw.Page(
//           margin: pw.EdgeInsets.zero,
//           build: (pw.Context context) {
//             return pw.GridView(
//               direction: pw.Axis.vertical,
//               crossAxisCount: crossAxisCount,
//               children: generatePageBarcodes(
//                 remainder,
//                 barcodeUIDs
//                     .getRange(i * numberPerPage, i * numberPerPage + remainder)
//                     .toList(),
//                 realWidth,
//               ),
//             );
//           },
//         ),
//       );
//     }
//   }

//   return await pdf.save();
// }

// //Generates a page worth of barcodes.
// List<pw.Widget> generatePageBarcodes(
//   int numberOfBarcodes,
//   List<String> barcodeUIDs,
//   double size,
// ) {
//   List<pw.Widget> barcodes = [];
//   for (String barcodeUID in barcodeUIDs) {
//     barcodes.add(
//       pw.Container(
//         child: pw.Padding(
//           padding: const pw.EdgeInsets.all(5),
//           child: pw.Column(
//             mainAxisSize: pw.MainAxisSize.max,
//             crossAxisAlignment: pw.CrossAxisAlignment.center,
//             mainAxisAlignment: pw.MainAxisAlignment.center,
//             children: [
//               pw.Text(barcodeUID, style: pw.TextStyle(fontSize: (size / 15))),
//               pw.Stack(children: [
//                 pw.BarcodeWidget(
//                   height: size,
//                   width: size,
//                   color: PdfColor.fromHex("#000000"),
//                   barcode: pw.Barcode.qrCode(
//                       errorCorrectLevel: pw.BarcodeQRCorrectionLevel.high),
//                   data: barcodeUID,
//                 ),
//               ]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   return barcodes;
// }
