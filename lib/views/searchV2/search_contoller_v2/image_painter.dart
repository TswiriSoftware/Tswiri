import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:sunbird/isar/collections/ml_tags/ml_object/ml_object/ml_object.dart';

import 'dart:ui' as ui;

class ImagePainter extends CustomPainter {
  ImagePainter(
    this.mlObject,
    this.image,
    this.photoSize,
  );

  ui.Image image;
  MLObject mlObject;
  Size photoSize;

  @override
  void paint(Canvas canvas, Size size) {
    double photoAspectRatio = photoSize.height / photoSize.width;
    Rect boundingBox = mlObject.getBoundingBox();
    double boundingBoxWidth = boundingBox.width;
    double boundingBoxHeight = boundingBox.height;

    if (boundingBoxWidth >= boundingBoxHeight) {
      //Width bigger
      log('width: $boundingBoxWidth');
      boundingBoxHeight = boundingBoxHeight * photoAspectRatio;
    } else {
      //Height Bigger
      log('width: $boundingBoxHeight');
      boundingBoxWidth = boundingBoxWidth * photoAspectRatio;
    }

    //TODO: maintain Aspect Ratio.
    final dst = Offset.zero & size;
    final src = Rect.fromCenter(
        center: boundingBox.center,
        width: boundingBoxWidth,
        height: boundingBoxHeight);

    canvas.drawImageRect(image, src, dst, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
