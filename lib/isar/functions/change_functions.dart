import 'package:sunbird/isar/isar_database.dart';

bool changeParent({
  required CatalogedContainer currentContainer,
  required CatalogedContainer parentContainer,
}) {
  //1. Check if parent container is a child of the current container.
  List<ContainerRelationship> currentContainerChildrenRelationships = isar!
      .containerRelationships
      .filter()
      .parentUIDMatches(currentContainer.containerUID)
      .findAllSync();

  List<String> currentContainerChildren =
      currentContainerChildrenRelationships.map((e) => e.containerUID).toList();

  if (currentContainerChildren.contains(parentContainer.containerUID) &&
      currentContainer.containerUID != parentContainer.containerUID) {
    return false;
  } else {
    ContainerRelationship? containerRelationship = isar!.containerRelationships
        .filter()
        .containerUIDMatches(currentContainer.containerUID)
        .findFirstSync();

    if (containerRelationship != null) {
      isar!.writeTxnSync(
        (isar) =>
            isar.containerRelationships.deleteSync(containerRelationship.id),
      );
    }

    ContainerRelationship newContainerRelationship = ContainerRelationship()
      ..containerUID = currentContainer.containerUID
      ..parentUID = parentContainer.containerUID;

    isar!.writeTxnSync((isar) =>
        isar.containerRelationships.putSync(newContainerRelationship));

    return true;
  }
}
