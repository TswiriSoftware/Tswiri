import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../functions/coordinate_translator/coordinates_translator.dart';
import '../../../objects/photo_tagging/image_data.dart';

class ObjectDetectorPainter extends CustomPainter {
  ObjectDetectorPainter({required this.objectData});
  final ImageData objectData;

  @override
  void paint(Canvas canvas, Size size) {
    List<DetectedObject> _objects = objectData.detectedObjects;
    List<TextBlock> _textData = objectData.detectedText!.blocks;
    Size absoluteSize = objectData.size;
    InputImageRotation rotation = objectData.imageRotation;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red;

    final Paint background = Paint()..color = const Color(0x99000000);

    for (DetectedObject detectedObject in _objects) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );

      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));

      for (Label label in detectedObject.getLabels()) {
        builder.addText('${label.getText()} ${label.getConfidence()}\n');
      }

      builder.pop();

      final left = translateX(
          detectedObject.getBoundinBox().left, rotation, size, absoluteSize);
      final top = translateY(
          detectedObject.getBoundinBox().top, rotation, size, absoluteSize);
      final right = translateX(
          detectedObject.getBoundinBox().right, rotation, size, absoluteSize);
      final bottom = translateY(
          detectedObject.getBoundinBox().bottom, rotation, size, absoluteSize);

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: right - left,
          )),
        Offset(left, top),
      );
    }

    for (final textBlock in _textData) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 10,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));
      builder.addText(textBlock.text);
      builder.pop();

      final left =
          translateX(textBlock.rect.left, rotation, size, absoluteSize);
      final top = translateY(textBlock.rect.top, rotation, size, absoluteSize);
      final right =
          translateX(textBlock.rect.right, rotation, size, absoluteSize);
      final bottom =
          translateY(textBlock.rect.bottom, rotation, size, absoluteSize);

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: right - left,
          )),
        Offset(left, top),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
