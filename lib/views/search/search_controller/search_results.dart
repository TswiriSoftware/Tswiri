import 'package:sunbird/isar/collections/ml_tags/ml_object/ml_object/ml_object.dart';
import 'package:sunbird/isar/collections/ml_tags/ml_text/ml_text_element/ml_text_element.dart';
import 'package:sunbird/isar/collections/photo/photo.dart';

///Base Result class.
abstract class Result {
  Result({
    required this.uid,
    required this.containerUID,
    required this.textSimilarity,
  });

  String uid;

  ///The containerUID of this result.
  String containerUID;

  ///The textSimilarity. (string_similarity)
  ///Comparison of enteredKeyword to the result.
  double textSimilarity;

  @override
  String toString() {
    return 'Result: $textSimilarity, $containerUID\n';
  }

  @override
  bool operator ==(other) {
    if (other is Result && other.uid == uid) {
      return true;
    } else {
      return false;
    }
  }
}

///Name Result.
class NameResult implements Result {
  NameResult({
    required this.uid,
    required this.containerUID,
    required this.textSimilarity,
    required this.name,
  });

  String uid;

  ///ContainerUID.
  @override
  String containerUID;

  ///Comparison between the enteredKeyword and the name.
  @override
  double textSimilarity;

  ///The name of the Cataloged Container.
  String name;

  @override
  String toString() {
    return 'Name Result, "$name", $textSimilarity, $containerUID\n';
  }
}

///Description Result.
class DescriptionResult implements Result {
  DescriptionResult({
    required this.uid,
    required this.containerUID,
    required this.textSimilarity,
    required this.description,
  });

  String uid;

  ///ContainerUID.
  @override
  String containerUID;

  ///Comparison between the enteredKeyword and the description.
  @override
  double textSimilarity;

  ///The description of the Cataloged Container.
  String description;

  @override
  String toString() {
    return 'Description Result, "$description", $textSimilarity, $containerUID\n';
  }
}

///ContainerTag Result.
class ContainerTagResult implements Result {
  ContainerTagResult({
    required this.uid,
    required this.containerUID,
    required this.textSimilarity,
    required this.tag,
  });
  String uid;

  ///ContainerUID.
  @override
  String containerUID;

  ///Comparison between the enteredKeyword and the description.
  @override
  double textSimilarity;

  ///The description of the Cataloged Container.
  String tag;

  @override
  String toString() {
    return 'Description Result, "$tag", $textSimilarity, $containerUID\n';
  }
}

///PhotoLabel Result.
class PhotoLabelResult implements Result {
  PhotoLabelResult({
    required this.uid,
    required this.containerUID,
    required this.textSimilarity,
    required this.photoLabel,
    required this.photo,
  });
  String uid;

  ///ContainerUID.
  @override
  String containerUID;

  ///Comparison between the enteredKeyword and the description.
  @override
  double textSimilarity;

  ///The photoLabel Text.
  String photoLabel;

  ///The Photo.
  Photo photo;

  @override
  String toString() {
    return 'Description Result, "$photoLabel", $textSimilarity, $containerUID\n';
  }
}

///ObjectLabel Result.
class ObjectLabelResult implements Result {
  ObjectLabelResult({
    required this.uid,
    required this.containerUID,
    required this.textSimilarity,
    required this.objectLabel,
    required this.mlObject,
    required this.photo,
  });
  String uid;

  ///ContainerUID.
  @override
  String containerUID;

  ///Comparison between the enteredKeyword and the description.
  @override
  double textSimilarity;

  ///The description of the Cataloged Container.
  String objectLabel;

  ///The mlObject (for cut-outs)
  MLObject mlObject;

  ///The Photo.
  Photo photo;

  @override
  String toString() {
    return 'Description Result, "$objectLabel", $textSimilarity, $containerUID\n';
  }
}

///MLPhotoLabel Result.
class MLPhotoLabelResult implements Result {
  MLPhotoLabelResult({
    required this.uid,
    required this.containerUID,
    required this.textSimilarity,
    required this.mlPhotoLabel,
    required this.photo,
  });
  String uid;

  ///ContainerUID.
  @override
  String containerUID;

  ///Comparison between the enteredKeyword and the description.
  @override
  double textSimilarity;

  ///The photoLabel Text.
  String mlPhotoLabel;

  ///The Photo.
  Photo photo;

  @override
  String toString() {
    return 'Description Result, "$mlPhotoLabel", $textSimilarity, $containerUID\n';
  }

  @override
  bool operator ==(other) {
    if (other is MLPhotoLabelResult && other.mlPhotoLabel == mlPhotoLabel) {
      return true;
    } else {
      return false;
    }
  }
}

///MLObjectLabel Result.
class MLObjectLabelResult implements Result {
  MLObjectLabelResult({
    required this.uid,
    required this.containerUID,
    required this.textSimilarity,
    required this.mlObjectLabel,
    required this.mlObject,
    required this.photo,
  });
  String uid;

  ///ContainerUID.
  @override
  String containerUID;

  ///Comparison between the enteredKeyword and the description.
  @override
  double textSimilarity;

  ///The description of the Cataloged Container.
  String mlObjectLabel;

  ///The mlObject (for cut-outs)
  MLObject mlObject;

  ///The Photo.
  Photo photo;

  @override
  String toString() {
    return 'Description Result, "$mlObjectLabel", $textSimilarity, $containerUID\n';
  }
}

///MLTextResult Result.
class MLTextResult implements Result {
  MLTextResult({
    required this.uid,
    required this.containerUID,
    required this.textSimilarity,
    required this.mlText,
    required this.mlTextElement,
    required this.photo,
  });
  String uid;

  ///ContainerUID.
  @override
  String containerUID;

  ///Comparison between the enteredKeyword and the description.
  @override
  double textSimilarity;

  ///The description of the Cataloged Container.
  String mlText;

  ///The mlObject (for cut-outs)
  MLTextElement mlTextElement;

  ///The Photo.
  Photo photo;

  @override
  String toString() {
    return 'Description Result, "$mlText", $textSimilarity, $containerUID\n';
  }
}
