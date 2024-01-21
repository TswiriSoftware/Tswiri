import 'package:isar/isar.dart';
part 'ml_object_label.g.dart';

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
@Name("MLObjectLabel")
class MLObjectLabel {
  ///ObjectLabelID.
  Id id = Isar.autoIncrement;

  ///ObjectID.
  @Name("objectID")
  late int objectID;

  ///detectedLabelTextID.
  @Name("detectedLabelTextID")
  @Index()
  late int detectedLabelTextID;

  ///Tag Confidence.
  @Name("confidence")
  late double confidence;

  ///Blacklisted.
  @Name("userFeedback")
  late bool? userFeedback;

  @override
  String toString() {
    return '\nObjectID: $objectID, DetectedLabelTextID: $detectedLabelTextID, Confidence: $confidence, UserFeedback: $userFeedback';
  }

  @override
  bool operator ==(Object other) {
    return other is MLObjectLabel &&
        id == other.id &&
        objectID == other.objectID &&
        detectedLabelTextID == other.detectedLabelTextID &&
        confidence == other.confidence &&
        userFeedback == other.userFeedback;
  }

  Map toJson() => {
        'id': id,
        'photoID': objectID,
        'textID': detectedLabelTextID,
        'confidence': confidence,
        'blackListed': userFeedback,
      };

  MLObjectLabel fromJson(Map<String, dynamic> json) {
    return MLObjectLabel()
      ..id = json['id']
      ..objectID = json['photoID']
      ..detectedLabelTextID = json['textID']
      ..confidence = json['confidence']
      ..userFeedback = json['blackListed'];
  }

  @override
  int get hashCode => id.hashCode;
}
