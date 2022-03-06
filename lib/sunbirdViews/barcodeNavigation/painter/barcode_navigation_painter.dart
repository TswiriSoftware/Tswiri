import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/functions/dataProccessing/barcode_scanner_data_processing_functions.dart';
import 'package:flutter_google_ml_kit/functions/mathfunctions/round_to_double.dart';
import 'package:flutter_google_ml_kit/functions/paintFunctions/simple_paint.dart';
import 'package:flutter_google_ml_kit/globalValues/global_paints.dart';
import 'package:flutter_google_ml_kit/globalValues/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/objects/barcode_positional_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/appSettings/app_settings.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../databaseAdapters/allBarcodes/barcode_entry.dart';
import '../../../databaseAdapters/calibrationAdapters/distance_from_camera_lookup_entry.dart';
import '../../../databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import '../../../functions/barcodeCalculations/data_capturing_functions.dart';

///This Painter is used to gudide the user to the barcode they have
class BarcodeDetectorPainterNavigation extends CustomPainter {
  BarcodeDetectorPainterNavigation(
      {required this.barcodes,
      required this.absoluteImageSize,
      required this.rotation,
      required this.realBarcodePositions,
      required this.selectedBarcodeID,
      required this.distanceFromCameraLookup,
      required this.allBarcodes,
      required this.phoneAngle,
      required this.defaultBarcodeDiagonalLength});
  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final List<RealBarcodePostionEntry> realBarcodePositions;
  final String selectedBarcodeID;
  final List<DistanceFromCameraLookupEntry> distanceFromCameraLookup;
  final List<BarcodeDataEntry> allBarcodes;
  final double phoneAngle;
  final double defaultBarcodeDiagonalLength;

  ///Steps to follow for ///
  ///
  ///1. Check if the selected barcode is on screen.
  ///i. If true. (else go to ii)
  ///
  /// 1. Calculate the barcodes OnScreenData.
  ///
  /// 2. Draw a polygon around the selected barcode.
  ///
  /// 3. Calculate the finder circle's radius from the barcode size.
  ///
  /// 4. Check if the barcode is within the finder circle's radius
  ///      - true : Turn the finder circle blue.
  ///      - false: Turn the finder circle red and draw an idicator to guide the user to the barcode.
  ///
  ///ii. Find the screen center's real position.
  ///
  /// 1. Calculate the onImageCenters of the referenceBarcode and screenCenter.
  ///
  /// 2. Calculate the Offset between the centers referenceBarcodeCenter *to* screenCenter.
  ///
  /// 3. Calculate the real offset between referenceBarcodeCenter *to* screenCenter.
  ///
  /// 4. Get the real position of the reference barcode.
  ///
  /// 5. Calculate the screen center real position.
  ///
  /// 6. get the selected barcode real position.
  ///
  /// 7. Calculate the offset screenCenterRealPosition to selectedBarcodeRealPosition.
  ///
  /// 8. Calculate the angle to the selected Barocode.
  ///
  /// 9. Calculate the distance to the selected barcode.
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

      if (hapticFeedBack == true) {
        HapticFeedback.lightImpact();
      }

      //Draws a Polygon around the selectedBarcode.
      // canvas.drawPoints(PointMode.polygon, barcodeOnScreenData.cornerPoints,
      //     paintLightGreenAccent3);
      // canvas.drawPoints(PointMode.points, [barcodeOnScreenData.center],
      //     paintSimple(Colors.greenAccent, 4));

      //The finder circle's radius is related to the barcode on screen size.
      double finderCircleRadius = barcodeOnScreenData.barcodeOnScreenUnits / 2;

      //Check if the selected barcode is within the finder circle.
      double distance =
          (screenCenterPoint - barcodeOnScreenData.center).distance;
      if (distance < finderCircleRadius / 2) {
        //Draw the finder circle in blue indicating the barcode is within the finder circle
        canvas.drawCircle(screenCenterPoint, finderCircleRadius, paintBlue3);
      } else {
        //Draw finder circle in red when the barcode is not within the finder circle.
        canvas.drawCircle(screenCenterPoint, finderCircleRadius, paintRed3);

        //Contstuct the rectangle for the arc.
        Rect rect = Rect.fromCenter(
            center: screenCenterPoint, width: distance, height: distance);

        //Calculate the angle the selected barcode makes with the center of the screen.
        double selectedBarcodeAngleRadians =
            (barcodeOnScreenData.center - screenCenterPoint).direction;

        //Draw the direction indicator.
        canvas.drawArc(rect, selectedBarcodeAngleRadians - pi / 10, pi / 5,
            false, paintSimple(Colors.greenAccent, 5));
      }
    } else {
      if (barcodes.isNotEmpty) {
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

        //iii. rorate by angle.

        Offset rotatedreferenceBarcodeCenter = rotateOffset(
            offset: referenceBarcodeCenter, angleRadians: phoneAngle);
        Offset rotatedonImageScreenCenter =
            rotateOffset(offset: onImageScreenCenter, angleRadians: phoneAngle);

        //2. Calculate the Offset between the centers referenceBarcodeCenter *to* screenCenter
        Offset offsetToScreenCenter =
            rotatedonImageScreenCenter - rotatedreferenceBarcodeCenter;

        //3. Calculate real offset from reference barcode to screen center.

        //i. Calculate the mm value of 1 on image unit.

        double referenceBarcodeMMperOIU = calculateBacodeMMperOIU(
            barcodeDataEntries: allBarcodes,
            diagonalLength:
                calculateAverageBarcodeDiagonalLength(referenceBarcode),
            barcodeID: referenceBarcode.displayValue!,
            defaultBarcodeDiagonalLength: defaultBarcodeDiagonalLength);

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

          //7. Calculate the offset screenCenterRealPosition to selectedBarcodeRealPosition.
          Offset screenCenterToSelectedBarcode =
              selectedBarcodeRealPosition - screenCenterRealPosition;

          //8. Calculate the angle to the selected Barocode.
          double angleToSelectedBarcode =
              screenCenterToSelectedBarcode.direction;

          //9. Calculate the distance to the selected barcode.
          double distanceToSelectedBarcode =
              screenCenterToSelectedBarcode.distance;

          //d.log(distanceToSelectedBarcode.toString());

          //Contstuct the rectangle for the arc.
          Rect rect = Rect.fromCenter(
              center: screenCenterPoint,
              width: distanceToSelectedBarcode,
              height: distanceToSelectedBarcode);

          //Draw the direction indicator.
          canvas.drawArc(rect, angleToSelectedBarcode - pi / 10, pi / 5, false,
              paintSimple(Colors.greenAccent, 5));

          //Display the screen center's real position.
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

          // Draw some points of intrest :D
          // canvas.drawPoints(
          //     PointMode.points,
          //     [screenCenterPoint, referenceBarcodeScreenData.center],
          //     paintSimple(Colors.red, 5));
        }
      }
    }
  }

  Offset calculateScreenCenterPoint(Size size) =>
      Offset(size.width / 2, size.height / 2);

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
