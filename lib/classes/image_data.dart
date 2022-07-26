// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:sunbird/isar/isar_database.dart';

///ImageData
///
/// - Photo             [File]
///
/// - Photo Size        [Size]
///
/// - InputImageRotaion [InputImageRotation]
///
/// - MLPhotoLabel      [MLPhotoLabel]
///
/// - MLObject          [MLObject]
///
/// - MLObjectLabel     [MLObjectLabel]
///
/// - MLTextBlock       [MLTextBlock]
///
/// - MLTextLine        [MLTextLine]
///
/// - MLTextElement     [MLTextElement]
///
///
class ImageData {
  ImageData({
    required this.photoFile,
    required this.size,
    required this.rotation,
    required this.photoLabels,
    required this.mlPhotoLabels,
    required this.objectLabels,
    required this.mlObjects,
    required this.mlObjectLabels,
    required this.mlTextBlocks,
    required this.mlTextLines,
    required this.mlTextElements,
  });

  ///Photo File.
  File photoFile;

  ///Photo size.
  Size size;

  //Photo Rotation
  InputImageRotation rotation;

  ///List of PhotoLabel.
  List<PhotoLabel> photoLabels;

  ///List of ObjectLabel.
  List<ObjectLabel> objectLabels;

  ///List of detected MLPhotoLabels.
  List<MLPhotoLabel> mlPhotoLabels;

  ///List of detected MLObjects.
  List<MLObject> mlObjects;

  ///List of detected MLObjectLabels.
  List<MLObjectLabel> mlObjectLabels;

  ///List of MLTextBlock.
  List<MLTextBlock> mlTextBlocks;

  ///List of MLTextLines.
  List<MLTextLine> mlTextLines;

  ///List of MLTextElements.
  List<MLTextElement> mlTextElements;

  ///This creates relevant isarEntries for the specified container.
  ///
  /// - Photo Entry
  ///
  /// - ImageLabels
  ///
  /// - ObjectLabels
  ///
  /// - Recognized Text
  Future<void> savePhoto(String containerUID) async {
    //1. Photo Extention.
    String extention = photoFile.path.split('.').last;
    //2. Photo Name.
    int photoName = DateTime.now().millisecondsSinceEpoch;
    //3. Create the image file path.
    String photoFilePath = '${photoDirectory!.path}/$photoName.$extention';
    //4. Create image thumbnail path.
    String photoThumbnailPath =
        '${photoDirectory!.path}/${photoName}_thumbnail.$extention';
    //5. Load Image in memory.
    img.Image referenceImage = img.decodeJpg(photoFile.readAsBytesSync())!;
    //6. Create Thumbnail.
    img.Image thumbnailImage = img.copyResize(referenceImage, width: 120);
    //7. Save the Thumbnail.
    File(photoThumbnailPath).writeAsBytesSync(img.encodePng(thumbnailImage));
    //8. Save the Image.
    photoFile.copySync(photoFilePath);

    log('PhotoFilePath: $photoFilePath');

    //9. Create Photo Entry
    Photo newPhoto = Photo()
      ..containerUID = containerUID
      ..extention = extention
      ..photoName = photoName
      ..thumbnailExtention = extention
      ..thumbnailName = '${photoName}_thumbnail'
      ..photoSize = size;

    int photoID = 0;
    isar!.writeTxnSync((isar) {
      photoID = isar.photos.putSync(newPhoto);
    });

    isar!.writeTxnSync((isar) {
      ///Write Photo Labels to Isar.
      for (MLPhotoLabel mlPhotoLabel in mlPhotoLabels) {
        isar.mLPhotoLabels.putSync(
          MLPhotoLabel()
            ..confidence = mlPhotoLabel.confidence
            ..detectedLabelTextID = mlPhotoLabel.detectedLabelTextID
            ..photoID = photoID
            ..userFeedback = mlPhotoLabel.userFeedback,
        );
      }

      for (PhotoLabel photoLabel in photoLabels) {
        isar.photoLabels.putSync(PhotoLabel()
          ..photoID = photoID
          ..tagTextID = photoLabel.tagTextID);
      }

      ///Write Objects to Isar.
      for (MLObject mlObject in mlObjects) {
        int objectID = isar.mLObjects.putSync(
          MLObject()
            ..boundingBox = mlObject.boundingBox
            ..photoID = photoID,
        );

        ///Write Object Labels to Isar.
        for (MLObjectLabel mlObjectLabel in mlObjectLabels
            .where((element) => element.objectID == mlObject.id)) {
          isar.mLObjectLabels.putSync(
            MLObjectLabel()
              ..confidence = mlObjectLabel.confidence
              ..detectedLabelTextID = mlObjectLabel.detectedLabelTextID
              ..objectID = objectID
              ..userFeedback = mlObjectLabel.userFeedback,
          );
        }

        for (ObjectLabel objectLabel in objectLabels
            .where((element) => element.objectID == mlObject.id)) {
          isar.objectLabels.putSync(ObjectLabel()
            ..objectID = objectID
            ..tagTextID = objectLabel.tagTextID);
        }
      }

      ///Write Text Blocks to isar.
      for (MLTextBlock mlTextBlock in mlTextBlocks) {
        int textBlockID = isar.mLTextBlocks.putSync(
          MLTextBlock()
            ..cornerPoints = mlTextBlock.cornerPoints
            ..recognizedLanguages = mlTextBlock.recognizedLanguages,
        );

        ///Write Text Lines to isar.
        for (MLTextLine mlTextLine in mlTextLines
            .where((element) => element.blockID == mlTextBlock.id)) {
          int lineID = isar.mLTextLines.putSync(
            MLTextLine()
              ..blockID = textBlockID
              ..blockIndex = mlTextLine.blockIndex
              ..cornerPoints = mlTextLine.cornerPoints
              ..recognizedLanguages = mlTextLine.recognizedLanguages,
          );

          ///Write Text Elements to isar.
          for (MLTextElement e in mlTextElements
              .where((element) => element.lineID == mlTextLine.id)) {
            isar.mLTextElements.putSync(
              MLTextElement()
                ..cornerPoints = e.cornerPoints
                ..detectedElementTextID = e.detectedElementTextID
                ..lineID = lineID
                ..lineIndex = e.lineIndex
                ..photoID = photoID
                ..userFeedback = e.userFeedback,
            );
          }
        }
      }
    });
  }

  factory ImageData.fromPhoto(Photo photo) {
    File photoFile = File(photo.getPhotoPath());

    List<MLObject> mlObject =
        isar!.mLObjects.filter().photoIDEqualTo(photo.id).findAllSync();

    List<MLObjectLabel> mlObjectLabels = isar!.mLObjectLabels
        .filter()
        .repeat(
            mlObject, (q, MLObject element) => q.objectIDEqualTo(element.id))
        .findAllSync();

    List<ObjectLabel> objectLabels = isar!.objectLabels
        .filter()
        .repeat(
            mlObject, (q, MLObject element) => q.objectIDEqualTo(element.id))
        .findAllSync();

    List<MLTextElement> mlTextElements =
        isar!.mLTextElements.filter().photoIDEqualTo(photo.id).findAllSync();

    List<MLTextLine> mlTextLines = isar!.mLTextLines
        .filter()
        .repeat(mlTextElements,
            (q, MLTextElement element) => q.idEqualTo(element.lineID))
        .findAllSync();

    List<MLTextBlock> mlTextBlocks = isar!.mLTextBlocks
        .filter()
        .repeat(mlTextLines,
            (q, MLTextLine element) => q.idEqualTo(element.blockID))
        .findAllSync();

    List<MLPhotoLabel> mlPhotoLabels =
        isar!.mLPhotoLabels.filter().photoIDEqualTo(photo.id).findAllSync();

    List<PhotoLabel> photoLabels =
        isar!.photoLabels.filter().photoIDEqualTo(photo.id).findAllSync();

    // log('mlPhotoLabels: ${mlPhotoLabels.length}');
    // log('mlObject: ${mlObject.length}');
    // log('objectLabels: ${objectLabels.length}');
    // log('mlObjectLabels: ${mlObjectLabels.length}');
    // log('mlTextBlocks: ${mlTextBlocks.length}');
    // log('mlTextLines: ${mlTextLines.length}');
    // log('mlTextElements: ${mlTextElements.length}');
    // log('photoLabels: ${photoLabels.length}');

    return ImageData(
      photoFile: photoFile,
      size: photo.photoSize,
      rotation: InputImageRotation.rotation0deg,
      photoLabels: photoLabels,
      mlPhotoLabels: mlPhotoLabels,
      mlObjects: mlObject,
      objectLabels: objectLabels,
      mlObjectLabels: mlObjectLabels,
      mlTextBlocks: mlTextBlocks,
      mlTextLines: mlTextLines,
      mlTextElements: mlTextElements,
    );
  }
}
