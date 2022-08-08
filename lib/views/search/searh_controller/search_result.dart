import 'package:sunbird/isar/isar_database.dart';

class SearchResult {
  SearchResult({
    required this.catalogedContainer,
  });

  ///Container Entry ID.
  late final int id = catalogedContainer.id;

  ///Container Entry.
  final CatalogedContainer catalogedContainer;

  late ContainerType containerType =
      isar!.containerTypes.getSync(catalogedContainer.containerTypeID)!;

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

  ///Merges this with arg.
  void merge(SearchResult searchResult) {
    //4. Container tags
    containerTags = searchResult.containerTags;

    //5. Photos
    if (photos.isEmpty) {
      photos = searchResult.photos;
    } else {
      List<int> photoIDs = photos.map((e) => e.id).toList();
      for (Photo photo in searchResult.photos) {
        if (!photoIDs.contains(photo.id)) {
          photos.add(photo);
        }
      }
    }

    //6. MLObject Labels.
    mlObjectLabels = searchResult.mlObjectLabels;

    //7. Object Labels.
    objectLabels = searchResult.objectLabels;

    //8. ML Photo Labels.
    mlPhotoLabels = searchResult.mlPhotoLabels;

    //9. Photo Labels.
    photoLabels = searchResult.photoLabels;

    //10. MLTextElements.
    mlTextElements = searchResult.mlTextElements;
  }
}
