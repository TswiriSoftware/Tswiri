import 'dart:developer';
import 'package:sunbird/isar/isar_database.dart';
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
  ///
  ///            \/     \/
  ///            ||     ||
  ///   \ \      /\     /\      / /
  ///    \ \     \/_____\/     / /
  ///     \ \____/| 0 0 |\____/ /
  ///      \____/_|  o  |_\____/
  ///           \ \     / /
  ///           / /     \ \
  ///           \ \     / /
  ///
  ///           _____   _____  _______  ___  _____
  /// |     |  |       |          |      |   |
  /// |_____|  |_____  |          |      |   |
  /// |     |  |       |          |      |   |
  /// |     |  |_____  |_____     |     _|_  |_____
  ///
  /// 'Tags': 'Search by container tags', *
  ///
  /// 'ML Labels': 'Search ML labels',
  ///
  /// 'Photo Labels': 'Search by User Labels', *
  ///
  /// 'Name': 'Search by container Name', *
  ///
  /// 'Description': 'Search by container Description', *
  ///
  /// 'Barcode': 'Search by container Barcodes', *
  ///
  /// 'ML Text': 'Search by detected text',

  void searchV2({String? enteredKeyword}) {
    if (enteredKeyword != null && enteredKeyword.isNotEmpty) {
      //Trim and Normilize enteredKeyword.
      enteredKeyword = enteredKeyword.trim().toLowerCase();

      searchResults.clear();

      ///Loop through Name results.
      if (filters.contains('Name')) {
        nameSearch(enteredKeyword).forEach(
          (element) {
            if (!searchResults.contains(element)) {
              searchResults.add(element);
            }
          },
        );
      }

      ///Loop through Description results.
      if (filters.contains('Description')) {
        descriptionSearch(enteredKeyword).forEach(
          (element) {
            if (!searchResults.contains(element)) {
              searchResults.add(element);
            }
          },
        );
      }

      ///Loop through Barcode results.
      if (filters.contains('Barcode')) {
        barcodeSearch(enteredKeyword).forEach(
          (element) {
            if (!searchResults.contains(element)) {
              searchResults.add(element);
            }
          },
        );
      }

      if (filters.contains('Tags') || filters.contains('Photo Labels')) {
        //TagTexts that contain this enteredKeyword.
        List<TagText> tagTexts = isar!.tagTexts
            .filter()
            .textContains(enteredKeyword, caseSensitive: false)
            .findAllSync();

        List<int> tagTextIDs = tagTexts.map((e) => e.id).toList();

        // log('\n\nNumber of TagTexts: ${tagTexts.length}');
        //Search Container Tags.
        if (filters.contains('Tags') && tagTextIDs.isNotEmpty) {
          //Filter Container Tags.
          List<ContainerTag> containerTags = isar!.containerTags
              .filter()
              .repeat(
                  tagTextIDs, (q, int element) => q.tagTextIDEqualTo(element))
              .findAllSync();

          // log('Number of containerTags: ${containerTags.length}');

          if (containerTags.isNotEmpty) {
            List<CatalogedContainer> containers = isar!.catalogedContainers
                .filter()
                .repeat(
                    containerTags,
                    (q, ContainerTag element) =>
                        q.containerUIDMatches(element.containerUID))
                .findAllSync();

            // log('Number of containers: ${containers.length}\n\n');

            for (CatalogedContainer container in containers) {
              SearchResult searchResult = SearchResult(
                catalogedContainer: container,
              );

              searchResult.containerTags = containerTags
                  .where((element) =>
                      element.containerUID == container.containerUID)
                  .toList();

              int index = searchResults
                  .indexWhere((element) => element.id == container.id);

              if (index == -1) {
                searchResults.add(searchResult);
              } else {
                searchResults[index].merge(searchResult);
              }
            }
          }
        }
        //Search Photo Labels.
        if (filters.contains('Photo Labels') && tagTextIDs.isNotEmpty) {
          //Filter Photo Labels.
          List<PhotoLabel> photoLabels = isar!.photoLabels
              .filter()
              .repeat(
                  tagTextIDs, (q, int element) => q.tagTextIDEqualTo(element))
              .findAllSync();

          log('Number of photoLabels: ${photoLabels.length}\n\n');

          //Filter Object Labels.
          List<ObjectLabel> objectLabels = isar!.objectLabels
              .filter()
              .repeat(
                  tagTextIDs, (q, int element) => q.tagTextIDEqualTo(element))
              .findAllSync();

          // log('Number of objectLabels: ${objectLabels.length}\n\n');

          //Find the relevant objects.
          List<MLObject> mlObjects = [];
          if (objectLabels.isNotEmpty) {
            mlObjects = isar!.mLObjects
                .filter()
                .repeat(objectLabels,
                    (q, ObjectLabel objectLabel) => q.idEqualTo(objectLabel.id))
                .findAllSync();
          }

          // log('Number of mlObjects: ${mlObjects.length}\n\n');

          if (photoLabels.isNotEmpty || mlObjects.isNotEmpty) {
            //Find relevant Photos.
            List<Photo> photos = isar!.photos
                .filter()
                .group(
                  (q) => q
                      .repeat(
                        photoLabels,
                        (q, PhotoLabel e) => q.idEqualTo(e.photoID),
                      )
                      .repeat(
                        mlObjects,
                        (q, MLObject e) => q.idEqualTo(e.photoID),
                      ),
                )
                .findAllSync();

            log('Number of photos: ${photos.length}\n\n');

            if (photos.isNotEmpty) {
              //Find relevant containers.
              List<CatalogedContainer> containers = isar!.catalogedContainers
                  .filter()
                  .repeat(
                      photos,
                      (q, Photo photo) =>
                          q.containerUIDMatches(photo.containerUID!))
                  .findAllSync();

              for (CatalogedContainer container in containers) {
                //Create the search object.
                SearchResult searchResult =
                    SearchResult(catalogedContainer: container);

                //Find Relevant Photos.
                List<Photo> containerPhotos = photos
                    .where((element) =>
                        element.containerUID == container.containerUID)
                    .toList();

                //List of photoIDs.
                List<int> photoIDs = containerPhotos.map((e) => e.id).toList();

                //Find the relevant photoLabels.
                List<PhotoLabel> containerPhotoLabels = photoLabels
                    .where((element) => photoIDs.contains(element.photoID))
                    .toList();

                //Find the relevant MLObjects.
                List<MLObject> containerMLObjects = mlObjects
                    .where((element) => photoIDs.contains(element.photoID))
                    .toList();

                //MLObjectIDs.
                List<int> objectIDs =
                    containerMLObjects.map((e) => e.id).toList();

                //Find relevant container object labels.
                List<ObjectLabel> containerObjectLabels = objectLabels
                    .where((element) => objectIDs.contains(element.objectID))
                    .toList();

                //Update the Search Result.
                searchResult.photos = containerPhotos;
                searchResult.photoLabels = containerPhotoLabels;
                searchResult.objectLabels = containerObjectLabels;

                //Check if it exists.
                int index = searchResults
                    .indexWhere((element) => element.id == container.id);

                if (index == -1) {
                  searchResults.add(searchResult);
                } else {
                  searchResults[index].merge(searchResult);
                }
              }
            }
          }
        }
      }

      if (filters.contains('ML Labels')) {
        //MLDetectedLabelTexts that contain this enteredKeyword.
        List<MLDetectedLabelText> mlDetectedLabelTexts = isar!
            .mLDetectedLabelTexts
            .filter()
            .detectedLabelTextContains(enteredKeyword, caseSensitive: false)
            .findAllSync();

        log('\n\nNumber of mlDetectedLabelTexts: ${mlDetectedLabelTexts.length}');
      }

      if (filters.contains('ML Text')) {
        //MLDetectedElementText that contain this enteredKeyword.
        List<MLDetectedElementText> mlDetectedElementTexts = isar!
            .mLDetectedElementTexts
            .filter()
            .detectedTextContains(enteredKeyword, caseSensitive: false)
            .findAllSync();

        log('\n\nNumber of mlDetectedElementTexts: ${mlDetectedElementTexts.length}');
      }
    } else {
      //Return Defaults.

    }
  }

  ///Find containers which name contain the enteredKeyword.
  List<SearchResult> nameSearch(String enteredKeyword) {
    List<CatalogedContainer> containers = isar!.catalogedContainers
        .filter()
        .nameContains(enteredKeyword, caseSensitive: false)
        .findAllSync();

    return containers.map((e) => SearchResult(catalogedContainer: e)).toList();
  }

  ///Find containers which description contain the enteredKeyword.
  List<SearchResult> descriptionSearch(String enteredKeyword) {
    List<CatalogedContainer> containers = isar!.catalogedContainers
        .filter()
        .descriptionContains(enteredKeyword, caseSensitive: false)
        .findAllSync();

    return containers.map((e) => SearchResult(catalogedContainer: e)).toList();
  }

  ///Find containers which barcodeUID contain the enteredKeyword..contains('Photo Objec
  List<SearchResult> barcodeSearch(String enteredKeyword) {
    List<CatalogedContainer> containers = isar!.catalogedContainers
        .filter()
        .barcodeUIDContains(enteredKeyword, caseSensitive: false)
        .findAllSync();

    return containers.map((e) => SearchResult(catalogedContainer: e)).toList();
  }

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
