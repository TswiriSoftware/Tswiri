import 'dart:developer';
import 'package:sunbird_2/isar/isar_database.dart';
import 'search_result.dart';
export 'search_result.dart';

class SearchController {
  SearchController({
    required this.filters,
  });

  ///List of search Results.
  List<SearchResult> searchResults = [];

  ///A reference to the filterList.
  List<String> filters;

  ///Search the database
  ///     |     |
  ///    /\     /\
  ///    \/_____\/
  ///     | 0 0 |
  ///   __|  o  |__
  ///  /  \     /  \
  /// /   /     \   \
  ///
  ///
  ///           _____   _____  _______  ___  _____
  /// |     |  |       |          |      |   |
  /// |_____|  |_____  |          |      |   |
  /// |     |  |       |          |      |   |
  /// |     |  |_____  |_____     |     _|_  |_____
  ///

  void search({String? enteredKeyword}) {
    if (enteredKeyword != null && enteredKeyword.isNotEmpty) {
      enteredKeyword = enteredKeyword.trim();
      searchResults.clear();

      ///Filter on 'name'.
      if (filters.contains('Name')) {
        List<CatalogedContainer> containers = isar!.catalogedContainers
            .filter()
            .nameContains(enteredKeyword, caseSensitive: false)
            .findAllSync();

        for (CatalogedContainer container in containers) {
          SearchResult containerSearchObject =
              SearchResult(catalogedContainer: container);
          if (!searchResults.contains(containerSearchObject)) {
            searchResults.add(containerSearchObject);
          }
        }
      }

      ///Filter on 'description'.
      if (filters.contains('Description')) {
        List<CatalogedContainer> containers = isar!.catalogedContainers
            .filter()
            .descriptionContains(enteredKeyword, caseSensitive: false)
            .findAllSync();
        for (CatalogedContainer container in containers) {
          SearchResult containerSearchObject =
              SearchResult(catalogedContainer: container);
          if (!searchResults.contains(containerSearchObject)) {
            searchResults.add(containerSearchObject);
          }
        }
      }

      ///Filter on 'barcode'.
      if (filters.contains('Barcode')) {
        List<CatalogedContainer> containers = isar!.catalogedContainers
            .filter()
            .barcodeUIDContains(enteredKeyword, caseSensitive: false)
            .findAllSync();
        for (CatalogedContainer container in containers) {
          SearchResult containerSearchObject =
              SearchResult(catalogedContainer: container);
          if (!searchResults.contains(containerSearchObject)) {
            searchResults.add(containerSearchObject);
          }
        }
      }

      List<TagText> tagTexts = isar!.tagTexts
          .filter()
          .textContains(enteredKeyword, caseSensitive: false)
          .findAllSync();

      List<int> tagTextsIDs = tagTexts.map((e) => e.id).toList();

      List<MLDetectedLabelText> mlDetectedLabelText = isar!.mLDetectedLabelTexts
          .filter()
          .detectedLabelTextContains(enteredKeyword, caseSensitive: false)
          .findAllSync();

      List<int> mlDetectedTextIDs =
          mlDetectedLabelText.map((e) => e.id).toList();

      ///Filter on 'tags'.
      if (filters.contains('Tags') && tagTextsIDs.isNotEmpty) {
        List<ContainerTag> containerTags = isar!.containerTags
            .filter()
            .repeat(
                tagTextsIDs, (q, int element) => q.tagTextIDEqualTo(element))
            .findAllSync();

        List<CatalogedContainer> containers = isar!.catalogedContainers
            .filter()
            .repeat(
                containerTags,
                (q, ContainerTag element) =>
                    q.containerUIDMatches(element.containerUID))
            .findAllSync();

        for (CatalogedContainer container in containers) {
          SearchResult containerSearchObject =
              SearchResult(catalogedContainer: container);

          int index =
              searchResults.indexWhere((element) => element.id == container.id);

          if (index != -1) {
            //It exists.
            searchResults[index].containerTags = containerTags
                .where(
                    (element) => element.containerUID == container.containerUID)
                .toList();
          } else {
            //Does not exist.
            containerSearchObject.containerTags = containerTags
                .where(
                    (element) => element.containerUID == container.containerUID)
                .toList();
            searchResults.add(containerSearchObject);
          }
        }
      }

      ///Filter on 'Photo Labels'.
      if (filters.contains('Photo Labels')) {
        //1. Filter on PhotoLabels.
        List<PhotoLabel> photoLabels = [];

        if (tagTextsIDs.isNotEmpty) {
          photoLabels = isar!.photoLabels
              .filter()
              .repeat(tagTextsIDs, (q, int e) => q.tagTextIDEqualTo(e))
              .findAllSync();
        }

        //2. Filter on ML Labels.
        List<MLPhotoLabel> mlPhotoLabels = [];
        if (mlDetectedTextIDs.isNotEmpty) {
          mlPhotoLabels = isar!.mLPhotoLabels
              .filter()
              .not()
              .userFeedbackEqualTo(false)
              .and()
              .repeat(mlDetectedTextIDs,
                  (q, int e) => q.detectedLabelTextIDEqualTo(e))
              .findAllSync();
        }

        //3. Find relevant Photos.
        List<Photo> photos = isar!.photos
            .filter()
            .group(
              (q) => q
                  .repeat(
                    photoLabels,
                    (q, PhotoLabel e) => q.idEqualTo(e.photoID),
                  )
                  .repeat(
                    mlPhotoLabels,
                    (q, MLPhotoLabel e) => q.idEqualTo(e.photoID!),
                  ),
            )
            .findAllSync();

        List<CatalogedContainer> containers = isar!.catalogedContainers
            .filter()
            .repeat(
                photos, (q, Photo e) => q.containerUIDMatches(e.containerUID!))
            .findAllSync();

        for (CatalogedContainer container in containers) {
          SearchResult containerSearchObject =
              SearchResult(catalogedContainer: container);

          int index =
              searchResults.indexWhere((element) => element.id == container.id);

          List<Photo> containerPhotos = photos
              .where(
                  (element) => element.containerUID == container.containerUID)
              .toList();

          List<int> containerPhotoIDs =
              containerPhotos.map((e) => e.id).toList();

          if (index != -1) {
            //Does contain.
            searchResults[index].photos = containerPhotos;

            searchResults[index].photoLabels = photoLabels
                .where((e) => containerPhotoIDs.contains(e.photoID))
                .toList();

            searchResults[index].mlPhotoLabels = mlPhotoLabels
                .where((element) => containerPhotoIDs.contains(element.photoID))
                .toList();
          } else {
            //Does not contain.
            containerSearchObject.photos = photos
                .where(
                    (element) => element.containerUID == container.containerUID)
                .toList();

            containerSearchObject.photoLabels = photoLabels
                .where((e) => containerPhotoIDs.contains(e.photoID))
                .toList();

            containerSearchObject.mlPhotoLabels = mlPhotoLabels
                .where((element) => containerPhotoIDs.contains(element.photoID))
                .toList();

            searchResults.add(containerSearchObject);
          }
        }
      }

      if (filters.contains('Photo Objects')) {
        //1. Filter on ObjectLabels.
        List<ObjectLabel> objectLabels = isar!.objectLabels
            .where()
            .findAllSync()
            .where((element) => tagTextsIDs.contains(element.tagTextID))
            .toList();

        for (var objectLabel in objectLabels) {
          log(isar!.tagTexts.getSync(objectLabel.id)!.text);
        }

        //2. Filter on MLObject Labels.
        List<MLObjectLabel> mlObjectLabels = [];
        if (mlDetectedTextIDs.isNotEmpty) {
          mlObjectLabels = isar!.mLObjectLabels
              .where()
              .findAllSync()
              .where((element) =>
                  element.userFeedback != false &&
                  mlDetectedTextIDs.contains(element.detectedLabelTextID))
              .toList();
        }

        List<MLObject> mlObjects = [];
        //3. Filter MLObjects.
        if (objectLabels.isNotEmpty) {
          mlObjects = isar!.mLObjects
              .filter()
              .repeat(
                  objectLabels, (q, ObjectLabel e) => q.idEqualTo(e.objectID))
              .findAllSync();
        }

        if (mlObjectLabels.isNotEmpty) {
          mlObjects.addAll(isar!.mLObjects
              .filter()
              .repeat(mlObjectLabels,
                  (q, MLObjectLabel e) => q.idEqualTo(e.objectID))
              .findAllSync());
        }

        //3. Find relevant Photos.
        List<Photo> photos = isar!.photos
            .filter()
            .repeat(mlObjects, (q, MLObject e) => q.idEqualTo(e.photoID))
            .findAllSync();

        if (photos.isNotEmpty) {
          //4. Find relevant CatalogedContainer (s).
          List<CatalogedContainer> containers = isar!.catalogedContainers
              .filter()
              .repeat(photos,
                  (q, Photo e) => q.containerUIDMatches(e.containerUID!))
              .findAllSync();

          for (CatalogedContainer container in containers) {
            SearchResult containerSearchObject =
                SearchResult(catalogedContainer: container);

            int index = searchResults
                .indexWhere((element) => element.id == container.id);

            List<Photo> containerPhotos = photos
                .where(
                    (element) => element.containerUID == container.containerUID)
                .toList();
            List<int> containerPhotoIDs =
                containerPhotos.map((e) => e.id).toList();

            List<MLObject> containerObjects = mlObjects
                .where((element) => containerPhotoIDs.contains(element.photoID))
                .toList();

            List<int> containerObjectIDs =
                containerObjects.map((e) => e.id).toList();

            if (index != -1) {
              //Does contain.
              searchResults[index].objectLabels = objectLabels
                  .where((element) =>
                      containerObjectIDs.contains(element.objectID))
                  .toList();

              List<int> photoIDS =
                  searchResults[index].photos.map((e) => e.id).toList();

              for (var photoID in containerPhotos.map((e) => e.id)) {
                if (!photoIDS.contains(photoID)) {
                  searchResults[index].photos.add(
                      photos.firstWhere((element) => element.id == photoID));
                }
              }

              searchResults[index].objectLabels = objectLabels
                  .where((element) =>
                      containerObjectIDs.contains(element.objectID))
                  .toList();

              searchResults[index].mlObjectLabels = mlObjectLabels
                  .where((element) =>
                      containerObjectIDs.contains(element.objectID))
                  .toList();
            } else {
              //Does not contain.
              containerSearchObject.objectLabels = objectLabels
                  .where((element) =>
                      containerObjectIDs.contains(element.objectID))
                  .toList();

              containerSearchObject.mlObjectLabels = mlObjectLabels
                  .where((element) =>
                      containerObjectIDs.contains(element.objectID))
                  .toList();

              containerSearchObject.photos = photos
                  .where((element) =>
                      element.containerUID == container.containerUID)
                  .toList();

              searchResults.add(containerSearchObject);
            }
          }
        }
      }
      if (filters.contains('ML Text')) {}
    } else {
      //Clear search results.
      searchResults.clear();
      //Find all Containers.
      List<CatalogedContainer> containers =
          isar!.catalogedContainers.where().findAllSync();

      for (CatalogedContainer container in containers) {
        SearchResult containerSearchObject =
            SearchResult(catalogedContainer: container);

        if (filters.contains('Tags')) {
          containerSearchObject.containerTags = isar!.containerTags
              .filter()
              .containerUIDMatches(container.containerUID)
              .findAllSync();
        }

        if (filters.contains('Photos')) {
          List<Photo> photos = isar!.photos
              .filter()
              .containerUIDMatches(container.containerUID)
              .findAllSync();

          for (Photo photo in photos) {
            containerSearchObject.photoLabels.addAll(isar!.photoLabels
                .filter()
                .photoIDEqualTo(photo.id)
                .findAllSync());

            containerSearchObject.mlPhotoLabels.addAll(isar!.mLPhotoLabels
                .filter()
                .photoIDEqualTo(photo.id)
                .findAllSync()
                .where((element) => element.userFeedback == true));

            List<MLObject> mlObjects =
                isar!.mLObjects.filter().photoIDEqualTo(photo.id).findAllSync();

            if (mlObjects.isNotEmpty) {
              containerSearchObject.objectLabels = isar!.objectLabels
                  .filter()
                  .repeat(mlObjects,
                      (q, MLObject element) => q.objectIDEqualTo(element.id))
                  .findAllSync();
            }

            containerSearchObject.photos.add(photo);
          }
        }
        searchResults.add(containerSearchObject);
      }
    }
  }
}
