import 'package:flutter/material.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:tswiri_base/colors/colors.dart';

///Creates a new CatalogedContainer.
///
/// (required)
/// - containerUID    [String]
/// - barcodeUID      [String]
/// - containerTypeID [int]
///
/// (optional)
/// - name        [String]
/// - description [String]
CatalogedContainer createNewCatalogedContainer({
  required String containerUID,
  required String barcodeUID,
  required int containerTypeID,
  String? name,
  String? description,
}) {
  //New Container Entry.
  CatalogedContainer newCatalogedContainer = CatalogedContainer()
    ..barcodeUID = barcodeUID
    ..containerTypeID = containerTypeID
    ..containerUID = containerUID
    ..description = description
    ..name = name;

  isar!.writeTxnSync(
    (isar) => isar.catalogedContainers.putSync(newCatalogedContainer),
  );

  return isar!.catalogedContainers
      .filter()
      .containerUIDMatches(newCatalogedContainer.containerUID)
      .findFirstSync()!;
}

///Creates a containerRelationship from parentContainerUID and containerUID.
createContainerRelationship({
  required String parentContainerUID,
  required String containerUID,
}) {
  ContainerRelationship relationship = ContainerRelationship()
    ..parentUID = parentContainerUID
    ..containerUID = containerUID;

  isar!.writeTxnSync(
      (isar) => isar.containerRelationships.putSync(relationship));
}

///Create the basic cotainerTypes
///
/// - Area
/// - Shelf
/// - Drawer
/// - box
///
void createBasicContainerTypes() {
  if (isar!.containerTypes.where().findAllSync().isEmpty) {
    isar!.writeTxnSync(
      (database) {
        database.containerTypes.putSync(
            ContainerType()
              ..id = 0
              ..containerTypeName = 'Area'
              ..containerDescription =
                  '- An Area is a stationary container with a marker.\n- which can contain all other types of containers.\n- It is part of the childrens grid.'
              ..canContain = [1, 2, 3]
              ..moveable = false
              ..enclosing = false
              ..containerColor = tswiriOrange
              ..iconData = const IconData(
                0xe7a2,
                fontFamily: 'MaterialIcons',
              )
              ..preferredChildContainer = 1,
            replaceOnConflict: true);

        database.containerTypes.putSync(
            ContainerType()
              ..id = 1
              ..containerTypeName = 'Shelf'
              ..containerDescription =
                  '- A Shelf is a stationary container with a marker.\n- which can contain Boxes and/or Drawers.\n- It is part of the childrens grid.'
              ..canContain = [2, 3]
              ..moveable = false
              ..enclosing = false
              ..containerColor = Colors.green
              ..iconData = const IconData(
                0xe9a7,
                fontFamily: 'MaterialIcons',
              )
              ..preferredChildContainer = 3,
            replaceOnConflict: true);

        database.containerTypes.putSync(
            ContainerType()
              ..id = 2
              ..containerTypeName = 'Drawer'
              ..containerDescription =
                  '- A Drawer is a stationary container.\n- which can contain boxes.\n- It does not form part of the childrens grid.'
              ..canContain = [1]
              ..moveable = false
              ..enclosing = true
              ..containerColor = Colors.blue
              ..iconData = const IconData(
                0xedac,
                fontFamily: 'MaterialIcons',
              )
              ..preferredChildContainer = 3,
            replaceOnConflict: true);

        database.containerTypes.putSync(
            ContainerType()
              ..id = 3
              ..containerTypeName = 'Box'
              ..containerDescription = '- A Box is a moveable container...'
              ..canContain = [1]
              ..moveable = true
              ..enclosing = true
              ..containerColor = const Color(0xFFF98866)
              ..iconData = const IconData(
                0xf134,
                fontFamily: 'MaterialIcons',
              )
              ..preferredChildContainer = 3,
            replaceOnConflict: true);
      },
    );
  }
}
