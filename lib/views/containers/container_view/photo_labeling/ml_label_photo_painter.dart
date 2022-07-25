import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:sunbird_2/globals/globals_export.dart';
import 'package:sunbird_2/isar/isar_database.dart';
import 'package:sunbird_2/scripts/coordinate_translator.dart';
import '../../../../classes/image_data.dart';

class MLLabelPhotoPainter extends CustomPainter {
  MLLabelPhotoPainter({
    required this.imageData,
    required this.showObjects,
    required this.showText,
  });
  final ImageData imageData;
  final bool showObjects;
  final bool showText;

  @override
  void paint(Canvas canvas, Size size) {
    // List<EditableDetectedObject> objects = imageData.objects;
    Size absoluteSize = imageData.size;
    InputImageRotation rotation = imageData.rotation;

    final Paint objectPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    final Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.greenAccent;

    final Paint textBackground = Paint()..color = const Color(0x99000000);

    if (showObjects == true) {
      for (var object in imageData.mlObjects) {
        final ParagraphBuilder builder = ParagraphBuilder(
          ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 10,
            textDirection: TextDirection.ltr,
          ),
        );

        builder.pushStyle(
          ui.TextStyle(
            color: Colors.lightGreenAccent,
            background: textBackground,
          ),
        );

        builder.addText(
          'ID: ${object.id} \n',
        );

        for (MLObjectLabel label in imageData.mlObjectLabels
            .where((element) =>
                element.objectID == object.id && element.userFeedback != false)
            .toList()) {
          //Ensure label falls above objectDetectionConfidence
          if (label.confidence >= objectDetectionConfidence) {
            builder.addText(
              '${getMLDetectedLabelText(label.detectedLabelTextID)} (${(label.confidence * 100).toInt()}%) \n',
            );
          }
        }

        builder.pop();

        final left =
            translateX(object.boundingBox[0], rotation, size, absoluteSize);
        final top =
            translateY(object.boundingBox[1], rotation, size, absoluteSize);
        final right =
            translateX(object.boundingBox[2], rotation, size, absoluteSize);
        final bottom =
            translateY(object.boundingBox[3], rotation, size, absoluteSize);

        canvas.drawRect(
          Rect.fromLTRB(left, top, right, bottom),
          objectPaint,
        );

        canvas.drawParagraph(
          builder.build()
            ..layout(ParagraphConstraints(
              width: right - left + 100,
            )),
          Offset(left, top),
        );
      }
    }

    if (showText == true) {
      for (MLTextBlock textBlock in imageData.mlTextBlocks) {
        final ParagraphBuilder builder = ParagraphBuilder(
          ParagraphStyle(
              textAlign: TextAlign.left,
              fontSize: 10,
              textDirection: TextDirection.ltr),
        );

        builder.pushStyle(
          ui.TextStyle(
            color: Colors.lightGreenAccent,
            background: textBackground,
          ),
        );

        List<MLTextLine> textLines = imageData.mlTextLines
            .where((element) => element.blockID == textBlock.id)
            .toList();

        List<MLTextElement> textElements = imageData.mlTextElements
            .where((element) =>
                textLines.map((e) => e.id).toList().contains(element.lineID))
            .toList();

        List<String> blockText = textElements
            .map((e) => getMLDetectedElementText(e.detectedElementTextID))
            .toList();

        builder.addText(
          blockText.join(' '),
        );

        builder.pop();

        List<Offset> offsetPoints = <Offset>[];

        for (var point in textBlock.cornerPoints) {
          double x =
              translateX(point.x.toDouble(), rotation, size, absoluteSize);
          double y =
              translateY(point.y.toDouble(), rotation, size, absoluteSize);

          offsetPoints.add(Offset(x, y));
        }

        offsetPoints.add(offsetPoints.first);
        canvas.drawPoints(PointMode.polygon, offsetPoints, textPaint);

        canvas.drawParagraph(
          builder.build()
            ..layout(ParagraphConstraints(
              width: (offsetPoints[0] - offsetPoints[1]).distance,
            )),
          offsetPoints[0],
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
