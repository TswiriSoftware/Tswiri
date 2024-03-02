import 'package:isar/isar.dart';
import 'package:tswiri_database/space.dart';
import 'collections/collections_export.dart';

extension SpaceExtension on Space {
  void _assertLoaded() {
    assert(isLoaded, 'Space must be loaded');
  }

  /// The list of all container types in the current space.
  List<ContainerType> get containerTypes {
    _assertLoaded();
    return db!.containerTypes.where().findAllSync();
  }

  /// Get the container type with the given UUID.
  ContainerType? getContainerType(String? typeUUID) {
    _assertLoaded();
    if (typeUUID == null) return null;
    return db?.containerTypes.filter().uuidMatches(typeUUID).findFirstSync();
  }

  /// Get the [CatalogedBarcode] with the given barcodeUUID.
  CatalogedBarcode? getCatalogedBarcode(String? barcodeUUID) {
    _assertLoaded();

    if (barcodeUUID == null) return null;
    return db?.catalogedBarcodes
        .filter()
        .barcodeUUIDEqualTo(barcodeUUID)
        .findFirstSync();
  }

  /// Get the [CatalogedContainer] with the given barcodeUUID or containerUUID.
  ///
  /// TODO: remove all sync methods.
  CatalogedContainer? getCatalogedContainerSync({
    String? barcodeUUID,
    String? containerUUID,
  }) {
    _assertLoaded();

    assert(
      (barcodeUUID == null) != (containerUUID == null),
      'Only a barcodeUUID or containerUUID must be provided',
    );

    if (barcodeUUID != null) {
      return db?.catalogedContainers
          .filter()
          .barcodeUUIDEqualTo(barcodeUUID)
          .findFirstSync();
    } else if (containerUUID != null) {
      return db?.catalogedContainers
          .filter()
          .containerUUIDEqualTo(containerUUID)
          .findFirstSync();
    } else {
      return null;
    }
  }

  /// Get the [CatalogedContainer] with the given barcodeUUID or containerUUID.
  Future<CatalogedContainer?> getCatalogedContainer({
    String? barcodeUUID,
    String? containerUUID,
  }) async {
    _assertLoaded();

    assert(
      (barcodeUUID == null) != (containerUUID == null),
      'Only a barcodeUUID or containerUUID must be provided',
    );

    if (barcodeUUID != null) {
      return db?.catalogedContainers
          .filter()
          .barcodeUUIDEqualTo(barcodeUUID)
          .findFirst();
    } else if (containerUUID != null) {
      return db?.catalogedContainers
          .filter()
          .containerUUIDEqualTo(containerUUID)
          .findFirst();
    } else {
      return null;
    }
  }

  /// Get the [ContainerRelationship] describing the parent of the container with the given UUID.
  ContainerRelationship? getParent(String containerUUID) {
    _assertLoaded();

    return db?.containerRelationships
        .filter()
        .containerUUIDEqualTo(containerUUID)
        .findFirstSync();
  }

  /// Get the list of all [ContainerRelationship]s describing the children of the container with the given UUID.
  Future<List<ContainerRelationship>> getChildren(String containerUUID) {
    _assertLoaded();

    return db!.containerRelationships
        .filter()
        .parentContainerUUIDEqualTo(containerUUID)
        .findAll();
  }

  /// This deletes the [CatalogedContainer] and all its [ContainerRelationship]s in the database.
  Future<bool> deleteCatalogedContainer(String containerUUID) async {
    _assertLoaded();

    final canDelete = canDeleteContainer(containerUUID);
    if (canDelete == false) {
      return false;
    }

    final result = await db?.writeTxn(() async {
      await db?.catalogedContainers
          .filter()
          .containerUUIDEqualTo(containerUUID)
          .deleteFirst();

      await db?.containerRelationships
          .filter()
          .containerUUIDContains(containerUUID)
          .deleteAll();

      await db?.containerRelationships
          .filter()
          .parentContainerUUIDEqualTo(containerUUID)
          .deleteAll();

      return true;
    });

    return result ?? false;
  }

  /// Check this container can be deleted.
  bool canDeleteContainer(String containerUUID) {
    _assertLoaded();

    final children = db!.containerRelationships
        .filter()
        .parentContainerUUIDEqualTo(containerUUID)
        .findAllSync();

    if (children.isNotEmpty) {
      return false;
    }

    return true;
  }

  bool isDescendantOf({
    required String parentUUID,
    required String containerUUID,
  }) {
    _assertLoaded();

    // Get a list of all descendant relationships of the containerUUID.
    final allRelationships = finalAllDescendants(containerUUID);

    // Check if the currentContainerUUID is a descendant of the containerUUID.
    final isDescendant = allRelationships.any(
      (relationship) {
        // Check if the relationship contains the current containerUUID.
        final isParent = relationship.containerUUID == parentUUID;
        final isChild = relationship.parentContainerUUID == parentUUID;

        return isParent || isChild;
      },
    );

    return isDescendant;
  }

  // Get a list of all descendant relationships of the containerUUID.
  List<ContainerRelationship> finalAllDescendants(String containerUUID) {
    _assertLoaded();

    final allRelationships = <ContainerRelationship>[];

    // Initialize the list with the direct children of the given containerUUID.
    var previousRelationships = db!.containerRelationships
        .filter()
        .parentContainerUUIDEqualTo(containerUUID)
        .findAllSync();

    allRelationships.addAll(previousRelationships);

    // Set the maximum number of iterations to prevent infinite loops.
    int iterations = 0;
    const max = 1000;

    while (previousRelationships.isNotEmpty && iterations < max) {
      final newRelationships = <ContainerRelationship>[];

      // Loop through the previous relationships and find their children.
      for (final relationship in previousRelationships) {
        final children = db!.containerRelationships
            .filter()
            .parentContainerUUIDEqualTo(relationship.containerUUID)
            .findAllSync();

        newRelationships.addAll(children);
      }

      // Add the new relationships to the list of all relationships.
      allRelationships.addAll(newRelationships);

      // Set the previous relationships to the new relationships.
      previousRelationships = newRelationships;
    }

    // Return the list of all relationships.
    return allRelationships;
  }
}
