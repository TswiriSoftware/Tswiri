import 'package:flutter_google_ml_kit/storageSystem/tag.dart';

class Photo {
  Photo({
    required this.photoUID,
    required this.photoPath,
    required this.tags,
  });

  ///PhotoUID
  ///ex. containerUID_timestamp
  String photoUID;

  ///Path to the photo (it includes the file extention).
  String photoPath;

  ///List of tags generated by photo processor.
  List<Tag> tags;
}
