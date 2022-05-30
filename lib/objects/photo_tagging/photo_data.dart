import 'package:google_ml_kit/google_ml_kit.dart';

class PhotoData {
  PhotoData({
    required this.photoPath,
    required this.thumbnailPhotoPath,
    required this.photoObjects,
    required this.photoLabels,
    required this.recognisedTexts,
  });

  ///Photo Path [String]
  final String photoPath;

  ///Photo Path [String]
  final String thumbnailPhotoPath;

  ///Photo labels [ImageLabel]
  final List<ImageLabel> photoLabels;

  ///Photo labels [DetectedObject]
  final List<DetectedObject> photoObjects;

  ///Photo Text Labels [RecognisedText]
  final RecognizedText recognisedTexts;
}
