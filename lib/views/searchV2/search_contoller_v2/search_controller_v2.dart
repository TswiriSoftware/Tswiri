import 'package:string_similarity/string_similarity.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/searchV2/search_contoller_v2/search_results.dart';

class SearchControllerV2 {
  SearchControllerV2({
    required this.filters,
  });

  ///A reference to the filterList.
  List<String> filters;

  List<Result> searchResults = [];

  void search({String? enteredKeyword}) {
    if (enteredKeyword != null && enteredKeyword.isNotEmpty) {
      //Normilize the enteredKeyword.
      String normilizedEnteredKeyword = enteredKeyword.trim().toLowerCase();

      //Clear the search results.
      searchResults.clear();

      if (filters.contains('Name')) {
        //Search on CatalogedContainer Name.
        searchResults.addAll(nameSearch(normilizedEnteredKeyword));
      }

      if (filters.contains('Description')) {
        //Search on CatalogedContainer Description.
        searchResults.addAll(descriptionSearch(enteredKeyword));
      }

      //Check if the TagText table search should be conducted.
      if (filters.contains('Tags') ||
          filters.contains('Photo Labels') ||
          filters.contains('Object Labels')) {
        //Search TagText Table.
        List<TagText> tagTexts = isar!.tagTexts
            .filter()
            .textContains(enteredKeyword, caseSensitive: false)
            .findAllSync();

        if (filters.contains('Tags')) {
          //Add Tag Results.
          searchResults.addAll(containerTagSearch(enteredKeyword, tagTexts));
        }
        if (filters.contains('Photo Labels')) {
          //Add Photo Label Results.
          searchResults.addAll(photoLabelSearch(enteredKeyword, tagTexts));
        }
        if (filters.contains('Object Labels')) {
          //Add Object Label Results.
          searchResults.addAll(objectLabelSearch(enteredKeyword, tagTexts));
        }
      }

      if (filters.contains('ML Labels')) {
        //Search on MLDetectedLabelText.
        List<MLDetectedLabelText> mlDetectedLabelTexts = isar!
            .mLDetectedLabelTexts
            .filter()
            .detectedLabelTextContains(enteredKeyword, caseSensitive: false)
            .findAllSync();

        //Add mlPhotoLabel results.
        searchResults
            .addAll(mlPhotoLabelSearch(enteredKeyword, mlDetectedLabelTexts));

        //Add mlObjectLabel results.
        searchResults
            .addAll(mlObjectLabelSearch(enteredKeyword, mlDetectedLabelTexts));
      }

      if (filters.contains('ML Text')) {
        List<MLDetectedElementText> mlDetectedElementTexts = isar!
            .mLDetectedElementTexts
            .filter()
            .detectedTextContains(enteredKeyword, caseSensitive: false)
            .findAllSync();

        //Add mlText results.
        searchResults
            .addAll(mlTextSearch(enteredKeyword, mlDetectedElementTexts));
      }

      //Sort results in decending order on TextSimilarity.
      searchResults
          .sort((a, b) => b.textSimilarity.compareTo(a.textSimilarity));
    } else {
      //Defaults.

      searchResults.addAll(nameSearch(''));
    }
  }

  //Search on containerNames.
  List<NameResult> nameSearch(String enteredKeyword) {
    //List of containers where name contains enteredKeyword.
    List<CatalogedContainer> containers = isar!.catalogedContainers
        .filter()
        .nameContains(enteredKeyword, caseSensitive: false)
        .findAllSync();

    return containers.map(
      (e) {
        return NameResult(
            containerUID: e.containerUID,
            textSimilarity: enteredKeyword.similarityTo(e.name),
            name: e.name ?? 'err');
      },
    ).toList();
  }

  //Search on containerDescriptions.
  List<DescriptionResult> descriptionSearch(String enteredKeyword) {
    //List of containers where name contains enteredKeyword.
    List<CatalogedContainer> containers = isar!.catalogedContainers
        .filter()
        .descriptionContains(enteredKeyword, caseSensitive: false)
        .findAllSync();

    return containers.map(
      (e) {
        return DescriptionResult(
            containerUID: e.containerUID,
            textSimilarity: enteredKeyword.similarityTo(e.description),
            description: e.description ?? 'err');
      },
    ).toList();
  }

  //Search on containerTags.
  List<ContainerTagResult> containerTagSearch(
      String enteredKeyword, List<TagText> tagTexts) {
    List<ContainerTagResult> results = [];

    for (TagText tagText in tagTexts) {
      //Find relevant containerTags.
      List<ContainerTag> containerTags = isar!.containerTags
          .filter()
          .tagTextIDEqualTo(tagText.id)
          .findAllSync();

      for (ContainerTag containerTag in containerTags) {
        //Find relevant CatalogedContainer.
        CatalogedContainer? catalogedContainer = isar!.catalogedContainers
            .filter()
            .containerUIDMatches(containerTag.containerUID)
            .findFirstSync();

        if (catalogedContainer != null) {
          //Create ContainerTag Result.
          results.add(
            ContainerTagResult(
              containerUID: catalogedContainer.containerUID,
              textSimilarity: enteredKeyword.similarityTo(tagText.text),
              tag: tagText.text,
            ),
          );
        }
      }
    }
    return results;
  }

  //Search on photoLabels.
  List<PhotoLabelResult> photoLabelSearch(
      String enteredKeyword, List<TagText> tagTexts) {
    List<PhotoLabelResult> results = [];

    for (TagText tagText in tagTexts) {
      //Find relevant photoLabels.
      List<PhotoLabel> photoLabels =
          isar!.photoLabels.filter().tagTextIDEqualTo(tagText.id).findAllSync();

      for (PhotoLabel photoLabel in photoLabels) {
        Photo? photo = isar!.photos.getSync(photoLabel.photoID);
        if (photo != null) {
          results.add(PhotoLabelResult(
            containerUID: photo.containerUID!,
            textSimilarity: enteredKeyword.similarityTo(tagText.text),
            photoLabel: tagText.text,
            photo: photo,
          ));
        }
      }
    }

    return results;
  }

  //Search on objectLabels
  List<ObjectLabelResult> objectLabelSearch(
      String enteredKeyword, List<TagText> tagTexts) {
    //List of results.
    List<ObjectLabelResult> results = [];

    for (TagText tagText in tagTexts) {
      //Find relevant objectLabels.
      List<ObjectLabel> objectLabels = isar!.objectLabels
          .filter()
          .tagTextIDEqualTo(tagText.id)
          .findAllSync();

      for (ObjectLabel objectLabel in objectLabels) {
        //Find relevant mlObject.
        MLObject? mlObject = isar!.mLObjects.getSync(objectLabel.objectID);
        if (mlObject != null) {
          //Find relevant photo.
          Photo? photo = isar!.photos.getSync(mlObject.photoID);
          if (photo != null) {
            //Create ObjectLabelResult.
            results.add(
              ObjectLabelResult(
                containerUID: photo.containerUID!,
                textSimilarity: enteredKeyword.similarityTo(tagText.text),
                objectLabel: tagText.text,
                mlObject: mlObject,
                photo: photo,
              ),
            );
          }
        }
      }
    }

    return results;
  }

  List<MLPhotoLabelResult> mlPhotoLabelSearch(
      String enteredKeyword, List<MLDetectedLabelText> mlDetectedLabelTexts) {
    //List of results.
    List<MLPhotoLabelResult> results = [];

    for (MLDetectedLabelText mlDetectedLabel in mlDetectedLabelTexts) {
      //Find relevant mlPhotoLabels.
      List<MLPhotoLabel> mlPhotoLabels = isar!.mLPhotoLabels
          .filter()
          .detectedLabelTextIDEqualTo(mlDetectedLabel.id)
          .findAllSync();

      for (MLPhotoLabel mlPhotoLabel in mlPhotoLabels) {
        //Find relevant photo.
        Photo? photo = isar!.photos.getSync(mlPhotoLabel.photoID!);

        if (photo != null &&
            mlDetectedLabel.hidden == false &&
            mlPhotoLabel.userFeedback != false) {
          //Create MLPhotoLabelResult.
          results.add(
            MLPhotoLabelResult(
              containerUID: photo.containerUID!,
              textSimilarity: enteredKeyword
                  .similarityTo(mlDetectedLabel.detectedLabelText),
              mlPhotoLabel: mlDetectedLabel.detectedLabelText,
              photo: photo,
            ),
          );
        }
      }
    }
    return results;
  }

  List<MLObjectLabelResult> mlObjectLabelSearch(
      String enteredKeyword, List<MLDetectedLabelText> mlDetectedLabelTexts) {
    //List of results.
    List<MLObjectLabelResult> results = [];
    for (MLDetectedLabelText mlDetectedLabel in mlDetectedLabelTexts) {
      //Find relevant mlObjectLabels.
      List<MLObjectLabel> mlObjectLabels = isar!.mLObjectLabels
          .filter()
          .detectedLabelTextIDEqualTo(mlDetectedLabel.id)
          .findAllSync();

      for (MLObjectLabel mlObjectLabel in mlObjectLabels) {
        //Find relevant MLObject.
        MLObject? mlObject = isar!.mLObjects.getSync(mlObjectLabel.objectID);
        if (mlObject != null) {
          //Find relevant photo.
          Photo? photo = isar!.photos.getSync(mlObject.photoID);
          if (photo != null && mlObjectLabel.userFeedback != false) {
            //Create MLObjectLabelResult.
            results.add(
              MLObjectLabelResult(
                containerUID: photo.containerUID!,
                textSimilarity: enteredKeyword
                    .similarityTo(mlDetectedLabel.detectedLabelText),
                mlObjectLabel: mlDetectedLabel.detectedLabelText,
                mlObject: mlObject,
                photo: photo,
              ),
            );
          }
        }
      }
    }
    return results;
  }

  List<MLTextResult> mlTextSearch(String enteredKeyword,
      List<MLDetectedElementText> mlDetectedElementTexts) {
    List<MLTextResult> results = [];

    for (MLDetectedElementText mlDetectedElementText
        in mlDetectedElementTexts) {
      //Find relevant mlTextElements.
      List<MLTextElement> mlTextElements = isar!.mLTextElements
          .filter()
          .detectedElementTextIDEqualTo(mlDetectedElementText.id)
          .findAllSync();

      for (MLTextElement mlTextElement in mlTextElements) {
        //Find relevent photo.
        Photo? photo = isar!.photos.getSync(mlTextElement.photoID);
        if (photo != null) {
          results.add(
            MLTextResult(
              containerUID: photo.containerUID!,
              textSimilarity: enteredKeyword
                  .similarityTo(mlDetectedElementText.detectedText),
              mlText: mlDetectedElementText.detectedText,
              mlTextElement: mlTextElement,
              photo: photo,
            ),
          );
        }
      }
    }

    return results;
  }
}
