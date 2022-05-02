import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';

import '../../../functions/translating/coordinates_translator.dart';

class ImageObjectDetectorPainter extends CustomPainter {
  ImageObjectDetectorPainter(
      {required this.containerPhoto, required this.absoluteSize});
  final ContainerPhoto containerPhoto;
  final Size absoluteSize;

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    // List<DetectedObject> _objects = objectData.detectedObjects;
    // List<TextBlock> _textData = objectData.detectedText!.blocks;
    // Size absoluteSize = objectData.size;
    // InputImageRotation rotation = objectData.imageRotation;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red;

    final Paint background = Paint()..color = const Color(0x99000000);

    //PhotoTags with boundingBoxes
    List<PhotoTag> photoTags = isarDatabase!.photoTags
        .filter()
        .photoPathMatches(containerPhoto.photoPath)
        .and()
        .not()
        .boundingBoxIsNull()
        .findAllSync();

    for (var photoTag in photoTags) {
      final left = translateX(photoTag.boundingBox![0],
          InputImageRotation.Rotation_90deg, size, absoluteSize);
      final top = translateY(photoTag.boundingBox![1],
          InputImageRotation.Rotation_90deg, size, absoluteSize);
      final right = translateX(photoTag.boundingBox![2],
          InputImageRotation.Rotation_90deg, size, absoluteSize);
      final bottom = translateY(photoTag.boundingBox![3],
          InputImageRotation.Rotation_90deg, size, absoluteSize);

      Rect rect = Rect.fromLTRB(
        left,
        top,
        right,
        bottom,
      );

      canvas.drawRect(rect, paint);

      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );

      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));

      builder.addText(isarDatabase!.mlTags.getSync(photoTag.tagUID)!.tag);

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
