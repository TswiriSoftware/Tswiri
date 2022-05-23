import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/photo_card/photo_card_painter.dart';

Card photoCard({
  required BuildContext context,
  required Photo photo,
  required Color? color,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    color: Colors.white12,
    elevation: 5,
    shadowColor: Colors.black26,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: color ?? sunbirdOrange, width: 1.5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Size>(
        future: getImageSize(photo),
        builder: (context, size) {
          if (size.hasData && size.data != null) {
            return SizedBox(
              width: size.data!.width,
              height: size.data!.height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(photo.photoPath),
                    fit: BoxFit.fill,
                  ),
                  CustomPaint(
                    painter: PhotoCardPainter(
                        photo: photo, absoluteSize: size.data!),
                  ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    ),
  );
}

Future<Size> getImageSize(Photo selectedPhoto) async {
  var decodedImage = await decodeImageFromList(
      File(selectedPhoto.photoPath).readAsBytesSync());

  Size absoluteSize =
      Size(decodedImage.height.toDouble(), decodedImage.width.toDouble());
  //Size absoluteSize = Size(720, 480);
  return absoluteSize;
}
