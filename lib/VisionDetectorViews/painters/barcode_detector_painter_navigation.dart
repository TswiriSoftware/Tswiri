import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_pixel_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_relative_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataInjectorFunctions/raw_data_functions.dart';
import 'package:flutter_google_ml_kit/functions/coordinateTranslator/coordinate_translator.dart';
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

      if (checkIfBarcodeIsValid()) {
        Offset relativeOffsetBetweenCurrentandSelectedBarcode =
            calculateOffsetBetweenTwoOffsets(
                p1: consolidatedData[selectedBarcodeID]!,
                p2: consolidatedData[barcodeScreenData.displayValue]!);

        Offset absoluteScreenCenterOffset = calculateAbsoluteCenterPoint(
            screenCenterPoint, absoluteImageSize, rotation);

        Offset absoluteBarcodeCenterOffset =
            calculateAbsoluteBarcodeCenterPoint(
                barcode, absoluteImageSize, rotation);

        Offset absoluteOffsetBetweenBarcodeCenterAndScreenCenter =
            calculateAbsoluteOffsetBetweenBarcodes(
                absoluteScreenCenterOffset, absoluteBarcodeCenterOffset);

        Offset relativeScreenCenterOffset = translateOffsetAbsoluteToRelative(
            absoluteOffsetBetweenBarcodeCenterAndScreenCenter,
            barcodeScreenData.absoluteBarcodeSize);

        Offset test = translateOffsetRelativeToAbsolute(
                calculateOffsetBetweenTwoOffsets(
                    p1: consolidatedData[selectedBarcodeID]!,
                    p2: relativeScreenCenterOffset),
                barcodeScreenData.absoluteBarcodeSize) *
            100;

        // translateOffsetRelativeToAbsolute(relativeScreenCenterOffset,
        //     barcodeScreenData.absoluteBarcodeSize),

        canvas.drawLine(
            screenCenterPoint, test + screenCenterPoint, paintBlue4);
      }
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

///This calculates the absolute center of a given image
Offset calculateAbsoluteCenterPoint(
    Offset offset, Size absoluteImageSize, InputImageRotation rotation) {
  final x = translateXAbsolute(offset.dx, rotation, absoluteImageSize);
  final y = translateYAbsolute(offset.dy, rotation, absoluteImageSize);

  final Offset centerOffset = Offset(x, y);

  return centerOffset;
}

///Returns a offset from p2 to p1
Offset calculateOffsetBetweenTwoOffsets(
    {required Offset p1, required Offset p2}) {
  Offset offset = p1 - p2;
  return offset;
}

Offset translateCoordinates(Offset offset) {
  if (offset.dx > 0 && offset.dy > 0) {
    offset = Offset(offset.dx, offset.dy);
  } else if (offset.dx > 0 && offset.dy < 0) {
    offset = Offset(offset.dx, offset.dy);
  } else if (offset.dx < 0 && offset.dy < 0) {
    offset = Offset(offset.dx, offset.dy);
  } else if (offset.dx < 0 && offset.dy < 0) {
    offset = Offset(offset.dx, offset.dy);
  }

  return offset;
}
