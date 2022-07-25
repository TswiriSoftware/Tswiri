import 'dart:developer';
import 'dart:io';
import 'package:sunbird_2/isar/isar_database.dart';

///Deletes Multiple Containers and all referneces
void deleteMultipleContainers(List<CatalogedContainer> containerEntries) {
  for (var catalogedContainer in containerEntries) {
    deleteContainer(catalogedContainer);
  }
}

///Delete's a single container and all references
void deleteContainer(CatalogedContainer catalogedContainer) {
  isar!.writeTxnSync((isar) {
    //Delete Container.
    isar.catalogedContainers.deleteSync(catalogedContainer.id);
    //Delete ContainerTags
    isar.containerTags
        .filter()
        .containerUIDMatches(catalogedContainer.containerUID)
        .deleteAllSync();

    //Delete Container Relationships.
    isar.containerRelationships
        .filter()
        .parentUIDMatches(catalogedContainer.containerUID)
        .deleteAllSync();

    isar.containerRelationships
        .filter()
        .containerUIDMatches(catalogedContainer.containerUID)
        .deleteAllSync();

    isar.markers
        .filter()
        .barcodeUIDMatches(catalogedContainer.barcodeUID!)
        .deleteAllSync();
  });

  //Delete Photos.
  List<Photo> photos = isar!.photos
      .filter()
      .containerUIDMatches(catalogedContainer.containerUID)
      .findAllSync();

  for (Photo photo in photos) {
    deletePhoto(photo);
  }
}

///Deletes a photo and all references.
void deletePhoto(Photo photo) {
  isar!.writeTxnSync((isar) {
    //1. Delete PhotoLabel (s).
    isar.photoLabels.filter().photoIDEqualTo(photo.id).deleteAllSync();

    //2. Delete MLPhotoLabel (S).
    isar.mLPhotoLabels.filter().photoIDEqualTo(photo.id).deleteAllSync();

    List<int> mlObjectIDs = isar.mLObjects
        .filter()
        .photoIDEqualTo(photo.id)
        .findAllSync()
        .map((e) => e.id)
        .toList();

    //3. Delete MLObject(s).
    isar.mLObjects.filter().photoIDEqualTo(photo.id).deleteAllSync();

    for (var mlObjectID in mlObjectIDs) {
      //4. Delete MLObjectLabel(s)
      isar.mLObjectLabels.filter().objectIDEqualTo(mlObjectID).deleteAllSync();
      //5. Delete ObjectLabel (s).
      isar.objectLabels.filter().objectIDEqualTo(mlObjectID).deleteAllSync();
    }

    List<MLTextElement> mlTextElements =
        isar.mLTextElements.filter().photoIDEqualTo(photo.id).findAllSync();

    Set<int> lineIDs = {};
    for (MLTextElement mlTextElement in mlTextElements) {
      lineIDs.add(mlTextElement.lineID);
      //6. Delete MLTextElement (s).
      isar.mLTextElements.deleteSync(mlTextElement.id);
    }

    Set<int> blockIDs = {};
    for (int lineID in lineIDs) {
      List<MLTextLine> mlTextLines =
          isar.mLTextLines.filter().idEqualTo(lineID).findAllSync();
      for (MLTextLine element in mlTextLines) {
        blockIDs.add(element.blockID);
        //7. Delete MLTextLine (s).
        isar.mLTextLines.deleteSync(element.id);
      }
    }

    for (int blockID in blockIDs) {
      //8. Delete MLTextBlock (s).
      isar.mLTextBlocks.deleteSync(blockID);
    }

    //9. Delete Photo.
    isar.photos.deleteSync(photo.id);

    log('Photos: ${isar.photos.where().findAllSync().length}');
    log('PhotoLabels: ${isar.photoLabels.where().findAllSync().length}');
    log('MLPhotoLabels: ${isar.mLPhotoLabels.where().findAllSync().length}');
    log('MLObjects: ${isar.mLObjects.where().findAllSync().length}');
    log('MLObjectLabel: ${isar.mLObjectLabels.where().findAllSync().length}');
    log('ObjectLabels: ${isar.objectLabels.where().findAllSync().length}');
    log('MLTextElements: ${isar.mLTextElements.where().findAllSync().length}');
    log('MLTextLines: ${isar.mLTextLines.where().findAllSync().length}');
    log('MLTextBlock: ${isar.mLTextBlocks.where().findAllSync().length}');
  });

  File(photo.getPhotoPath()).deleteSync();
  File(photo.getPhotoThumbnailPath()).deleteSync();
}
