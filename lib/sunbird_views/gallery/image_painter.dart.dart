import 'dart:developer';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_bounding_box/tag_bounding_box.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';

import '../../../functions/translating/coordinates_translator.dart';

class ImageObjectDetectorPainter extends CustomPainter {
  ImageObjectDetectorPainter({required this.photo, required this.absoluteSize});
  final Photo photo;
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
    List<MlTag> mlTags = isarDatabase!.mlTags
        .filter()
        .mlTagIDEqualTo(photo.id)
        .and()
        .tagTypeEqualTo(mlTagType.objectLabel)
        .findAllSync();

    for (var photoTag in mlTags) {
      //log(isarDatabase!.tagBoundingBoxs.where().findAllSync().toString());
      List<double> boundingBox = isarDatabase!.tagBoundingBoxs
          .filter()
          .mlTagIDEqualTo(photoTag.mlTagID)
          .boundingBoxProperty()
          .findFirstSync()!;

      final left = translateX(boundingBox[0], InputImageRotation.Rotation_90deg,
          size, absoluteSize);
      final top = translateY(boundingBox[1], InputImageRotation.Rotation_90deg,
          size, absoluteSize);
      final right = translateX(boundingBox[2],
          InputImageRotation.Rotation_90deg, size, absoluteSize);
      final bottom = translateY(boundingBox[3],
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

      builder.addText(isarDatabase!.tagTexts.getSync(photoTag.textTagID)!.tag);

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
