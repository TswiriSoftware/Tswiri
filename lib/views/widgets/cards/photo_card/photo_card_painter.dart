import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_bounding_box/object_bounding_box.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';

class PhotoCardPainter extends CustomPainter {
  PhotoCardPainter({required this.photo, required this.absoluteSize});
  final Photo photo;
  final Size absoluteSize;

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red;

    final Paint background = Paint()..color = const Color(0x99000000);

    //1. Find Object MlTags.
    List<MlTag> mlTags = isarDatabase!.mlTags
        .filter()
        .photoIDEqualTo(photo.id)
        .and()
        .tagTypeEqualTo(MlTagType.objectLabel)
        .findAllSync();

    for (var mlTag in mlTags) {
      //2. Get the boundingBoxes of objects.
      List<double> boundingBox = isarDatabase!.objectBoundingBoxs
          .filter()
          .mlTagIDEqualTo(mlTag.id)
          .boundingBoxProperty()
          .findFirstSync()!;

      //log(boundingBox.toString());

      final left = translateX(
          boundingBox[0], InputImageRotation.rotation90deg, size, absoluteSize);
      final top = translateY(
          boundingBox[1], InputImageRotation.rotation90deg, size, absoluteSize);
      final right = translateX(
          boundingBox[2], InputImageRotation.rotation90deg, size, absoluteSize);
      final bottom = translateY(
          boundingBox[3], InputImageRotation.rotation90deg, size, absoluteSize);

      //3. Construct the Rect.
      Rect rect = Rect.fromLTRB(
        left,
        top,
        right,
        bottom,
      );

      //4. Draw the Rect.
      canvas.drawRect(rect, paint);

      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 16,
            textDirection: TextDirection.ltr),
      );

      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));

      builder.addText(isarDatabase!.tagTexts.getSync(mlTag.textID)!.text);

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
