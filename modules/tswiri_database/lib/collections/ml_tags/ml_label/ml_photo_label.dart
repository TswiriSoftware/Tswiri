import 'package:isar/isar.dart';
part 'ml_photo_label.g.dart';

///TODO: finish commenting.

///Stores details about a container (Created by user).
///
///  - ```containerUID``` Unique identifier.
///  - ```containerTypeID``` Type of container [ContainerType].
///  - ```name``` Name of the container.
///  - ```description``` Description of the container.
///  - ```barcodeUID``` Barcode linked to this container.
///

@Collection()
@Name("MLPhotoLabel")
class MLPhotoLabel {
  Id id = Isar.autoIncrement;

  ///PhotoID.
  @Name("photoID")
  late int? photoID;

  ///DetectedLabelTextID.
  @Name("detectedLabelTextID")
  @Index(composite: [CompositeIndex('userFeedback')])
  late int detectedLabelTextID;

  ///Tag Confidence.
  @Name("confidence")
  late double confidence;

  ///Blacklisted.
  @Name("userFeedback")
  @Index()
  late bool? userFeedback;

  @override
  bool operator ==(Object other) {
    return other is MLPhotoLabel &&
        id == other.id &&
        photoID == other.photoID &&
        detectedLabelTextID == other.detectedLabelTextID &&
        confidence == other.confidence &&
        userFeedback == other.userFeedback;
  }

  @override
  String toString() {
    return '\nPhotoID: $photoID, DetectedLabelTextID: $detectedLabelTextID, Confidence: $confidence, UserFeedback: $userFeedback';
  }

  Map toJson() => {
        'id': id,
        'photoID': photoID,
        'textID': detectedLabelTextID,
        'confidence': confidence,
        'blackListed': userFeedback,
      };

  MLPhotoLabel fromJson(Map<String, dynamic> json) {
    return MLPhotoLabel()
      ..id = json['id']
      ..photoID = json['photoID']
      ..detectedLabelTextID = json['textID']
      ..confidence = json['confidence']
      ..userFeedback = json['blackListed'];
  }

  @override
  int get hashCode => id.hashCode;
}
