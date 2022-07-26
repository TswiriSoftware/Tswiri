import 'package:sunbird_2/isar/isar_database.dart';

class SearchResult {
  SearchResult({
    required this.catalogedContainer,
  });

  ///Container Entry ID.
  late final int id = catalogedContainer.id;

  ///Container Entry.
  final CatalogedContainer catalogedContainer;

  ///List of ContainerTags.
  List<ContainerTag> containerTags = [];

  ///List of Photos.
  List<Photo> photos = [];

  ///List of MLObject Labels.
  List<MLObjectLabel> mlObjectLabels = [];

  ///List of Object Labels.
  List<ObjectLabel> objectLabels = [];

  ///List of ML Photo Labels.
  List<MLPhotoLabel> mlPhotoLabels = [];

  ///List of  Photo Labels.
  List<PhotoLabel> photoLabels = [];

  ///List of MLTextElements.
  List<MLTextElement> mlTextElements = [];

  @override
  bool operator ==(Object other) {
    return (other is SearchResult) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
