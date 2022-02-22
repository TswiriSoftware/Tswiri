import 'dart:developer' as d;
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/functions/dataProccessing/barcode_scanner_data_processing_functions.dart';
import 'package:flutter_google_ml_kit/functions/mathfunctions/round_to_double.dart';
import 'package:flutter_google_ml_kit/functions/paintFunctions/simple_paint.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_paints.dart';
import 'package:flutter_google_ml_kit/objects/barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../databaseAdapters/allBarcodes/barcode_entry.dart';
import '../../../databaseAdapters/calibrationAdapters/distance_from_camera_lookup_entry.dart';
import '../../../databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import '../../../functions/barcodeCalculations/data_capturing_functions.dart';
import '../../../objects/raw_on_image_barcode_data.dart';

class BarcodeDetectorPainterNavigation extends CustomPainter {
  BarcodeDetectorPainterNavigation({
    required this.barcodes,
    required this.absoluteImageSize,
    required this.rotation,
    required this.realBarcodePositions,
    required this.selectedBarcodeID,
    required this.distanceFromCameraLookup,
    required this.allBarcodes,
  });
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final List<RealBarcodePostionEntry> realBarcodePositions;
  final String selectedBarcodeID;
  final List<DistanceFromCameraLookupEntry> distanceFromCameraLookup;
  List<BarcodeDataEntry> allBarcodes;

  ///Steps///
  ///
  ///1. Check if the selected barcode is on screen.
  ///
  ///i. If it is on screen. (else go to ii)
  ///     i.   Calculate the barcodes OnScreenData
  ///     ii.  Draw a polygon around the selected barcode.
  ///     iii. Calculate the finder circle's radius from the barcode size.
  ///     iv.  Check if the barcode is within the finder circle's radius
  ///          - true : Turn the finder circle blue.
  ///          - false: Turn the finder circle red and draw an idicator to guide the user to the barcode.
  ///
  ///ii. find the phones general area
  /// 1. Calculate the onImageCenters of the referenceBarcode and screenCenter
  /// 2.  Calculate the Offset between the centers referenceBarcodeCenter *to* screenCenter
  /// 3. Calculate real offset.
  /// 4. Get the real position of the reference barcode.
  /// 5. Calculate the screen center real position.
  /// 6. get the selected barcode real position.
  ///
  ///
  ///

  @override
  void paint(Canvas canvas, Size size) {
    //Calculate screen center offset.
    Offset screenCenterPoint = calculateScreenCenterPoint(size);

    //Find the index of selected barcode, if index = -1 then selectedBarcode is not on screen.
    int indexOfSelectedBarcode = barcodes.indexWhere(
        (element) => element.value.displayValue == selectedBarcodeID);

    //Checks if selectedBarcode is on screen.
    if (indexOfSelectedBarcode != -1) {
      //Calculates the on screen data of the selected barcode.
      BarcodeOnScreenData barcodeOnScreenData = calculateScreenBarcodeData(
          barcode: barcodes[indexOfSelectedBarcode],
          rotation: rotation,
          size: size,
          absoluteImageSize: absoluteImageSize);

      //Draws a Polygon around the selectedBarcode.
      // canvas.drawPoints(PointMode.polygon, barcodeOnScreenData.cornerPoints,
      //     paintLightGreenAccent3);
      canvas.drawPoints(PointMode.points, [barcodeOnScreenData.center],
          paintSimple(Colors.greenAccent, 4));

      //The finder circle's radius is related to the barcode on screen size.
      double finderCircleRadius = barcodeOnScreenData.barcodeOnScreenUnits / 2;

      //Check if the selected barcode is within the finder circle.
      if ((screenCenterPoint - barcodeOnScreenData.center).distance <
          finderCircleRadius / 2) {
        //Draw the finder circle in blue indicating the barcode is within the finder circle
        canvas.drawCircle(screenCenterPoint, finderCircleRadius, paintBlue3);
      } else {
        //Draw finder circle in red when the barcode is not within the finder circle.
        canvas.drawCircle(screenCenterPoint, finderCircleRadius, paintRed3);

        //Contstuct the rectangle for the arc.
        Rect rect = Rect.fromCenter(
            center: screenCenterPoint,
            width: (screenCenterPoint - barcodeOnScreenData.center).distance,
            height: (screenCenterPoint - barcodeOnScreenData.center).distance);

        //Calculate the angle the selected barcode makes with the center of the screen.
        double selectedBarcodeAngleRadians =
            (barcodeOnScreenData.center - screenCenterPoint).direction;

        //Draw the direction indicator.
        canvas.drawArc(rect, selectedBarcodeAngleRadians - pi / 10, pi / 5,
            false, paintSimple(Colors.greenAccent, 5));
      }
    } else {
      if (barcodes.length >= 1) {
        BarcodeValue referenceBarcode = barcodes.first.value;

        //Calculate referenceBarcode on screen data.
        BarcodeOnScreenData referenceBarcodeScreenData =
            calculateScreenBarcodeData(
                barcode: barcodes.first,
                rotation: rotation,
                size: size,
                absoluteImageSize: absoluteImageSize);

        //Draw finder circle in red when the barcode is not within the finder circle.
        canvas.drawCircle(screenCenterPoint,
            referenceBarcodeScreenData.barcodeOnScreenUnits / 2, paintRed3);

        //1. Calculate the onImageCenters

        //i. Calculate reference barcode OnImageCenter
        Offset referenceBarcodeCenter =
            calculateBarcodeCenterPoint(referenceBarcode);

        // d.log(referenceBarcodeCenter.toString());

        //ii. Calcualte onImageScreenCenter.
        Offset onImageScreenCenter =
            Offset(absoluteImageSize.height / 2, absoluteImageSize.width / 2);

        // TODO: Rotate both barcode center vectors by phone angle.
        //
        //using rotateOffset().

        //2. Calculate the Offset between the centers referenceBarcodeCenter *to* screenCenter
        Offset offsetToScreenCenter =
            onImageScreenCenter - referenceBarcodeCenter;

        //3. Calculate real offset.

        //i. Calculate the mm value of 1 on image unit.
        double referenceBarcodeMMperOIU = calculateBacodeMMperOIU(
            barcodeDataEntries: allBarcodes,
            diagonalLength:
                calculateAverageBarcodeDiagonalLength(referenceBarcode),
            barcodeID: referenceBarcode.displayValue!);

        //ii. Calculate the real distance of the offset.
        Offset referenceBarcodeTOScreenCenter =
            offsetToScreenCenter / referenceBarcodeMMperOIU;

        //4. Get the real position of the reference barcode.

        //i. Get the index of the reference barcode if it exists.
        int indexOfReferenceBarcode = realBarcodePositions.indexWhere(
            (element) => element.uid == referenceBarcode.displayValue);

        //ii. If it exists proceed.
        if (indexOfReferenceBarcode != -1) {
          //iii. Get the barcodeEntry
          RealBarcodePostionEntry referenceBarcodeRealPositionEntry =
              realBarcodePositions[indexOfReferenceBarcode];

          //iv. Get the referenceBarcodeRealPosition Offset.
          Offset referenceBarcodeRealPosition =
              typeOffsetToOffset(referenceBarcodeRealPositionEntry.offset);

          //5. Calculate the screen center real position.
          Offset screenCenterRealPosition =
              referenceBarcodeRealPosition + referenceBarcodeTOScreenCenter;

          //6. get the selected barcode real position.

          //i. Get the selectedBarcodeRealPosition Offset.
          RealBarcodePostionEntry selectedarcodeRealPositionEntry =
              realBarcodePositions
                  .firstWhere((element) => element.uid == selectedBarcodeID);

          //iv. Get the selectedBarcodeRealPosition Offset.

          Offset selectedBarcodeRealPosition =
              typeOffsetToOffset(selectedarcodeRealPositionEntry.offset);

          //7. Calculate the offset screenCenterRealPosition to selectedBarcodeRealPosition
          Offset screenCenterToSelectedBarcode =
              selectedBarcodeRealPosition - screenCenterRealPosition;
          //8. Calculate the angle to the selected Barocode
          double angleToSelectedBarcode =
              screenCenterToSelectedBarcode.direction;
          //9. Calculate the distance to the selected barcode
          double distanceToSelectedBarcode =
              screenCenterToSelectedBarcode.distance;

          d.log(distanceToSelectedBarcode.toString());

          //Contstuct the rectangle for the arc.
          Rect rect = Rect.fromCenter(
              center: screenCenterPoint,
              width: distanceToSelectedBarcode,
              height: distanceToSelectedBarcode);

          //Draw the direction indicator.
          canvas.drawArc(rect, angleToSelectedBarcode - pi / 10, pi / 5, false,
              paintSimple(Colors.greenAccent, 5));

          TextSpan span = TextSpan(
              style: TextStyle(color: Colors.red[800], fontSize: 20),
              text:
                  'X: ${roundDouble(screenCenterRealPosition.dx, 1)} \n Y: ${roundDouble(screenCenterRealPosition.dy, 1)}');
          TextPainter tp = TextPainter(
              text: span,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr);
          tp.layout();
          tp.paint(canvas, screenCenterPoint);

          canvas.drawPoints(
              PointMode.points,
              [screenCenterPoint, referenceBarcodeScreenData.center],
              paintSimple(Colors.red, 5));
        }
      }
    }
  }

  Offset calculateScreenCenterPoint(Size size) =>
      Offset(size.width / 2, size.height / 2);

  Offset imageCenterPointToOnScreenCenterPoint(
      Offset imageCenterPoint, Size size) {
    return Offset(imageCenterPoint.dx * (size.width / absoluteImageSize.width),
        imageCenterPoint.dy * (size.height / absoluteImageSize.height));
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
  BarcodeOnScreenData barcodeScreenData,
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

// ///This draws a green box around selected barcode and will turn the finder circle blue
// void highlightSelectedBarcode(
//     Canvas canvas,
//     BarcodeOnScreenData barcodeScreenData,
//     Offset screenCenterPoint,
//     String barcodeID,
//     double barcodeSize) {
//   if (barcodeScreenData.displayValue == barcodeID) {
//     canvas.drawRect(barcodeScreenData.cornerPoints, paintLightGreenAccent3);
//     if ((screenCenterPoint - barcodeScreenData.center).distance < 100) {
//       canvas.drawCircle(screenCenterPoint, barcodeSize, paintBlue3);
//     }
//   }
// }

RealBarcodePosition getRealBarcodePosition(
    {required List<RealBarcodePostionEntry> realBarcodePositions,
    required String BarcodeID}) {
  RealBarcodePostionEntry realBarcodePositionEntry =
      realBarcodePositions.firstWhere((element) => element.uid == BarcodeID);

  RealBarcodePosition realBarcodePosition = RealBarcodePosition(
      uid: BarcodeID,
      offset: typeOffsetToOffset(realBarcodePositionEntry.offset),
      zOffset: realBarcodePositionEntry.zOffset);

  return realBarcodePosition;
}

void changeCircleFinderColor(
    Canvas canvas,
    BarcodeOnScreenData barcodeScreenData,
    Offset screenCenterPoint,
    String barcodeID,
    double barcodeSize) {
  if ((screenCenterPoint - barcodeScreenData.center).distance < 100 &&
      barcodeScreenData.displayValue == barcodeID) {
    canvas.drawCircle(screenCenterPoint, barcodeSize, paintBlue3);
  }
}
