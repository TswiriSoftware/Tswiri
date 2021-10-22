import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/model/qrcodes.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

import 'coordinates_translator.dart';

class BarcodeDetectorPainter extends CustomPainter {
  BarcodeDetectorPainter(this.barcodes, this.absoluteImageSize, this.rotation);

  var box = Hive.box('testBox');

  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint paintRed = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..color = Colors.red;

    final Paint paintBlue = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.blue;

    final Paint background = Paint()..color = Color(0x99000000);

    var centers = []; // Centre co-ordinates of scanned QR codes
    var mmXY = []; //Offset With the mm value of X and Y

    DateTime _now = DateTime.now();
    print(
        'timestamp: ${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}');

    for (final Barcode barcode in barcodes) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));
      builder.addText('${barcode.value.displayValue}');
      builder.pop();

      final left = translateX(
          barcode.value.boundingBox!.left, rotation, size, absoluteImageSize);
      final top = translateY(
          barcode.value.boundingBox!.top, rotation, size, absoluteImageSize);
      final right = translateX(
          barcode.value.boundingBox!.right, rotation, size, absoluteImageSize);
      final bottom = translateY(
          barcode.value.boundingBox!.bottom, rotation, size, absoluteImageSize);

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: right - left,
          )),
        Offset(left, top),
      );

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );

      var X = (left + right) / 2;
      var Y = (top + bottom) / 2;

      // Co-ordinates of points
      var pointsOfIntrest = [
        new Offset(X, Y),
        new Offset(left, top),
        new Offset(right, top),
        new Offset(left, bottom),
        new Offset(right, bottom)
      ];

      centers.add(new Offset(X, Y));
      canvas.drawPoints(PointMode.points, pointsOfIntrest, paintRed);

      //Builder for Centre text
      final ParagraphBuilder builder2 = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );
      builder2
          .pushStyle(ui.TextStyle(color: Colors.red, background: background));
      builder2.addText('${X} , ${Y}');
      builder2.pop();

      canvas.drawParagraph(
        builder2.build()
          ..layout(ParagraphConstraints(
            width: right - left,
          )),
        Offset(X, Y),
      );

      if (barcodes.length >= 2) {
        var mmX = 70 / (left - right).abs();
        var mmY = 70 / (top - bottom).abs();
        mmXY.add(Offset(mmX, mmY));
      }
      var pxXY = ((left - right).abs() + (top - bottom).abs()) / 2;
      var disZ = (4341 / pxXY) - 15.75;

      //For testing purposes
      if (barcodes.length >= 1) {
        print('QRCode Value:, ${barcode.value.displayValue}');
        print('QR Size: ${pxXY}');
        print('QR Left:, ${left}');
        print('QR Top:, ${top}');
        print('QR Right:, ${right}');
        print('QR Bottom:, ${bottom}');
      }
      final ParagraphBuilder DistanceBuilder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );
      DistanceBuilder.pushStyle(
          ui.TextStyle(color: Colors.blue, background: background));
      DistanceBuilder.addText('${disZ}');
      DistanceBuilder.pop();

      canvas.drawParagraph(
        DistanceBuilder.build()
          ..layout(ParagraphConstraints(
            width: 1000,
          )),
        Offset(right, bottom),
      );
    }

    if (centers.length >= 2) {
      canvas.drawLine(centers[0], centers[1], paintBlue);
      var dXY = centers[0] - centers[1];
      var mmPxX = (mmXY[0].dx + mmXY[1].dx) / mmXY.length;
      var mmPxY = (mmXY[0].dy + mmXY[1].dy) / mmXY.length;
      var disX = (dXY.dx * mmPxX);
      var disY = (dXY.dy * mmPxY);

      final ParagraphBuilder DistanceBuilder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );
      DistanceBuilder.pushStyle(
          ui.TextStyle(color: Colors.blue, background: background));
      DistanceBuilder.addText('${disX} , ${disY}');
      DistanceBuilder.pop();

      print('${disX} , ${disY}');

      canvas.drawParagraph(
        DistanceBuilder.build()
          ..layout(ParagraphConstraints(
            width: 1000,
          )),
        Offset(0, 0),
      );
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
