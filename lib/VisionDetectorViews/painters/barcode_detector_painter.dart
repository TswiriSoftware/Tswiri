import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/database/qrcodes.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as math;

import 'coordinates_translator.dart';

class BarcodeDetectorPainter extends CustomPainter {

  BarcodeDetectorPainter(this.barcodes, this.absoluteImageSize, this.rotation);

  // var path = Directory.current.path;

  var box = Hive.openBox('qrCodes');

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

    final Paint background = Paint()..color = const Color(0x99000000);

    var centers = []; // Centre co-ordinates of scanned QR codes
    var mmXY = []; //Offset With the mm value of X and Y
    var absVectors = [];
    var summary = [];

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

      final boundingBoxLeft = translateX(
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
            width: right - boundingBoxLeft,
          )),
        Offset(boundingBoxLeft, top),
      );

      canvas.drawRect(
        Rect.fromLTRB(boundingBoxLeft, top, right, bottom),
        paint,
      );

      var X = (boundingBoxLeft + right) / 2; //?
      var Y = (top + bottom) / 2; //?

      // Co-ordinates of points
      var pointsOfIntrest = [
        Offset(X, Y),
        Offset(boundingBoxLeft, top),
        Offset(right, top),
        Offset(boundingBoxLeft, bottom),
        Offset(right, bottom)
      ];

      centers.add(new Offset(X, Y));
      canvas.drawPoints(PointMode.points, pointsOfIntrest, paintRed);

      // Z distance calculation
      if (barcodes.length >= 2) {
        var mmX = 70 / (boundingBoxLeft - right).abs();
        var mmY = 70 / (top - bottom).abs();
        mmXY.add(Offset(mmX, mmY));
      }
      var pxXY = ((boundingBoxLeft - right).abs() + (top - bottom).abs()) / 2;
      var disZ = (4341 / pxXY) - 15.75;

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
          ..layout(const ParagraphConstraints(
            width: 1000,
          )),
        Offset(right, bottom),
      );

      int _now = DateTime.now().millisecondsSinceEpoch;
      summary.add([barcode.value.displayValue, math.Vector2(X, Y), _now]);
    }

    if (centers.length >= 3) {
      print("Summary: ${summary}");
      for (var i = 0; i < summary.length; i++) {
        var dXY, disX, disY;
        int _now = DateTime.now().millisecondsSinceEpoch;

        if (summary.length - 1 == i) {
          dXY = centers[i] - centers[0];
          disX = (dXY.dx * ((mmXY[i].dx + mmXY[0].dx) / mmXY.length));
          disY = (dXY.dy * ((mmXY[i].dy + mmXY[0].dy) / mmXY.length));
          var uid = "${i}_${0}";
          if (absVectors.contains(uid)) {
            absVectors.remove(uid);
            absVectors.add([uid, math.Vector2(disX, disY), _now]);
          } else {
            absVectors.add([uid, math.Vector2(disX, disY), _now]);
          }
        } else {
          dXY = centers[i] - centers[i + 1];
          disX = (dXY.dx * ((mmXY[i].dx + mmXY[i + 1].dx) / mmXY.length));
          disY = (dXY.dy * ((mmXY[i].dy + mmXY[i + 1].dy) / mmXY.length));
          var uid = "${i}_${i + 1}";

          if (absVectors.contains(uid)) {
            absVectors.remove(uid);
            absVectors.add([uid, math.Vector2(disX, disY), _now]);
          } else {
            absVectors.add([uid, math.Vector2(disX, disY), _now]);
          }
        }
      }

      print(absVectors);

      // absVectors.add(math.Vector2(disX, disY));

      // canvas.drawLine(centers[0], centers[1], paintBlue);
      // final ParagraphBuilder DistanceBuilder = ParagraphBuilder(
      //   ParagraphStyle(
      //       textAlign: TextAlign.left,
      //       fontSize: 16,
      //       textDirection: TextDirection.ltr),
      // );
      // DistanceBuilder.pushStyle(
      //     ui.TextStyle(color: Colors.blue, background: background));
      // DistanceBuilder.addText('${disX} , ${disY}');
      // DistanceBuilder.pop();

      // canvas.drawParagraph(
      //   DistanceBuilder.build()
      //     ..layout(const ParagraphConstraints(
      //       width: 1000,
      //     )),
      //   const Offset(0, 0),
      // );
    }
  }

  @override
  bool shouldRepaint(BarcodeDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.barcodes != barcodes;
  }
}
