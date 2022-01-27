import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/globalValues/global_paints.dart';
import 'package:flutter_google_ml_kit/objects/barcode_positional_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class BarcodeDetectorPainterNavigation extends CustomPainter {
  BarcodeDetectorPainterNavigation(this.barcodes, this.absoluteImageSize,
      this.rotation, this.consolidatedData, this.selectedBarcodeID);
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final Map<String, Offset> consolidatedData;
  final String selectedBarcodeID;

  @override
  void paint(Canvas canvas, Size size) {
    Offset screenCenterPoint = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(screenCenterPoint, 100, paintRed3);

    for (final Barcode barcode in barcodes) {
      BarcodeScreenData barcodeScreenData = calculateScreenBarcodeData(
          barcode, rotation, size, absoluteImageSize);

      drawBarcodeDisplayValues(canvas, barcodeScreenData);
      highlightSelectedBarcode(
          canvas, barcodeScreenData, screenCenterPoint, selectedBarcodeID);

      bool checkIfBarcodeIsValid() =>
          barcode.value.displayValue != null &&
          barcode.value.boundingBox != null &&
          barcodeScreenData.displayValue != selectedBarcodeID;

      if (checkIfBarcodeIsValid()) {}
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainterNavigation oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}

///Draws the barcode display values in the center of the barcode given the canvas and barcodeData
void drawBarcodeDisplayValues(
  Canvas canvas,
  BarcodeScreenData barcodeScreenData,
) {
  final Paint background = Paint()..color = const Color(0x99000000);
  final ParagraphBuilder builder = ParagraphBuilder(
    ParagraphStyle(
        textAlign: TextAlign.left,
        fontSize: 20,
        textDirection: TextDirection.ltr),
  );

  builder.pushStyle(
      ui.TextStyle(color: Colors.lightGreenAccent, background: background));
  builder.addText(barcodeScreenData.displayValue);
  builder.pop();

  canvas.drawParagraph(
    builder.build()..layout(const ParagraphConstraints(width: 100)),
    barcodeScreenData.center,
  );
}

///This draws a green box around selected barcode and will turn the finder circle blue
void highlightSelectedBarcode(
    Canvas canvas,
    BarcodeScreenData barcodeScreenData,
    Offset screenCenterPoint,
    String barcodeID) {
  if (barcodeScreenData.displayValue == barcodeID) {
    canvas.drawRect(barcodeScreenData.boundingBox, paintLightGreenAccent3);
    if ((screenCenterPoint - barcodeScreenData.center).distance < 100) {
      canvas.drawCircle(screenCenterPoint, 100, paintBlue3);
    }
  }
}
