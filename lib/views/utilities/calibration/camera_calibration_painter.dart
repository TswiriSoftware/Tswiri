import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';

class CameraCalibrationVisualizerPainter extends CustomPainter {
  CameraCalibrationVisualizerPainter();

  @override
  paint(Canvas canvas, Size size) {
    final Paint equationPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent;

    final Paint dataPointPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red;

    final Paint backgroundPaint = Paint()..color = background[300]!;

    //Draw the equation
    List<Offset> equationPoints = [];
    for (var i = 50; i < 2000; i++) {
      double distanceFromCamera =
          focalLength * defaultBarcodeSize / i.toDouble();
      Offset dataPoint = Offset(i.toDouble(), distanceFromCamera);

      equationPoints.add(Offset(
          ((dataPoint.dx + size.width / 2) / (size.width / 50)),
          ((dataPoint.dy + size.height / 2) / (size.height / 50))));
    }

    canvas.drawPoints(PointMode.points, equationPoints, equationPaint);

    //Draw the dataPoints
    List<CameraCalibrationEntry> entries =
        isar!.cameraCalibrationEntrys.where().findAllSync();

    List<Offset> dataPoints = [];
    for (var element in entries) {
      Offset offsetData =
          Offset(element.diagonalSize, element.distanceFromCamera);

      Offset position = Offset(
        ((offsetData.dx + size.width / 2) / (size.width / 50)),
        ((offsetData.dy + size.height / 2) / (size.height / 50)),
      );
      dataPoints.add(position);

      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 5,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(ui.TextStyle(
          color: Colors.lightGreenAccent,
          background: backgroundPaint,
          fontSize: 5));
      builder.addText(
          '(${element.distanceFromCamera.toStringAsFixed(2)}, ${element.diagonalSize.toStringAsFixed(2)})');
      builder.pop();

      canvas.drawParagraph(
        builder.build()..layout(const ParagraphConstraints(width: 100)),
        position,
      );
    }

    canvas.drawPoints(PointMode.points, dataPoints, dataPointPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
