import 'package:isar/isar.dart';

import 'collections/collections_export.dart';

class Utils {
  Utils(this._isar);
  final Isar _isar;

  /// The list of all container types in the current space.
  List<ContainerType> get containerTypes {
    return _isar.containerTypes.where().findAllSync();
  }

  /// Get the container type with the given UUID.
  ContainerType? getContainerType(String? typeUUID) {
    if (typeUUID == null) return null;
    return _isar.containerTypes.filter().uuidMatches(typeUUID).findFirstSync();
  }

  /// Get the cataloged barcode with the given UUID.
  CatalogedBarcode? getCatalogedBarcode(String? barcodeUUID) {
    if (barcodeUUID == null) return null;
    return _isar.catalogedBarcodes
        .filter()
        .barcodeUUIDEqualTo(barcodeUUID)
        .findFirstSync();
  }

  CatalogedContainer? getCatalogedContainer({
    String? barcodeUUID,
    String? containerUUID,
  }) {
    assert(
      (barcodeUUID == null) != (containerUUID == null),
      'Only a barcodeUUID or containerUUID must be provided',
    );

    if (barcodeUUID != null) {
      return _isar.catalogedContainers
          .filter()
          .barcodeUUIDEqualTo(barcodeUUID)
          .findFirstSync();
    } else if (containerUUID != null) {
      return _isar.catalogedContainers
          .filter()
          .containerUUIDEqualTo(containerUUID)
          .findFirstSync();
    } else {
      return null;
    }
  }

  ContainerRelationship? getParentRelationShip(String containerUUID) {
    return _isar.containerRelationships
        .filter()
        .containerUUIDEqualTo(containerUUID)
        .findFirstSync();
  }

  ContainerRelationship? getChildRelationShips(String containerUUID) {
    return _isar.containerRelationships
        .filter()
        .parentContainerUUIDEqualTo(containerUUID)
        .findFirstSync();
  }
}
