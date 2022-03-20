import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../isar/container_isar/container_isar.dart';
import '../../isar/container_relationship/container_relationship.dart';
import '../../sunbirdViews/container_system/container_modification/container_selector_view.dart';
import '../../isar/functions/isar_functions.dart';
import '../basic_outline_containers/custom_outline_container.dart';
import '../basic_outline_containers/light_container.dart';
import '../basic_outline_containers/orange_outline_container.dart';

///For new container
///1. database!
///2. isNewContainer = true
///3. function to update parentUID
///4. parentContainerUID?
///
///For existingContainer
///1. database!
///2. isNewContainer = false
///3. currentContainerUID
class ContainerParentWidget extends StatefulWidget {
  const ContainerParentWidget({
    Key? key,
    required this.database,
    required this.isNewContainer,
    this.updateParent,
    this.currentBarcodeUID,
    this.parentContainerUID,
  }) : super(key: key);

  final Isar database;
  final bool isNewContainer;
  final String? currentBarcodeUID;
  final String? parentContainerUID;
  final void Function(String parentUID)? updateParent;

  @override
  State<ContainerParentWidget> createState() => _ContainerParentWidgetState();
}

class _ContainerParentWidgetState extends State<ContainerParentWidget> {
  Isar? database;
  String? currentContainerUID;
  ContainerEntry? parentContainerEntry;
  String? parentContainerUID;
  String? parentContainerName;
  Color? outlineColor;

  @override
  void initState() {
    database = widget.database;

    currentContainerUID = widget.currentBarcodeUID;
    parentContainerUID = widget.parentContainerUID;

    if (parentContainerUID != null) {
      //Get parentContainerName if parentContainerUID is provided.
      parentContainerName = getContainerName(
          database: database!, containerUID: parentContainerUID!);

      //TODO: implement containerType Color
    } else if (currentContainerUID != null) {
      //Get parentContainerEntry if currentContainer is provided.
      parentContainerEntry = getParentContainerEntry(
          database: database!, currentContainerUID: currentContainerUID!);

      parentContainerUID = parentContainerEntry?.containerUID;
      parentContainerName = parentContainerEntry?.name;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LightContainer(
        child: CustomOutlineContainer(
            padding: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('parentName',
                    style: Theme.of(context).textTheme.bodySmall),
                Text(parentContainerName ?? '',
                    style: Theme.of(context).textTheme.subtitle2),
                Text('parentUID', style: Theme.of(context).textTheme.bodySmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(parentContainerUID ?? 'Select a parent',
                        style: Theme.of(context).textTheme.bodyLarge),
                    InkWell(
                      onTap: () async {
                        List<String?>? selectedContainerData =
                            await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContainerSelectorView(
                              currentContainerUID: currentContainerUID,
                              database: database,
                              multipleSelect: false,
                            ),
                          ),
                        );

                        //log(selectedContainerData.toString());
                        setState(() {
                          parentContainerUID = selectedContainerData?[0];
                          parentContainerName = selectedContainerData?[1];
                        });

                        if (selectedContainerData != null) {
                          if (widget.isNewContainer == true) {
                            //If it is a new container, Update the value;
                            widget.updateParent!(parentContainerUID!);
                          } else if (widget.isNewContainer == false &&
                              currentContainerUID != null) {
                            //If it is not a new container, update ContainerRelationshipEntry
                            log('Updating existing containerRelationship.');
                            ContainerRelationship containerRelationship =
                                database!.containerRelationships
                                    .filter()
                                    .containerUIDMatches(currentContainerUID!)
                                    .findFirstSync()!;

                            containerRelationship.parentUID =
                                parentContainerUID;

                            database!.writeTxnSync((isar) {
                              isar.containerRelationships
                                  .putSync(containerRelationship);
                            });
                          }
                        } else if (selectedContainerData == null &&
                            widget.isNewContainer == false) {
                          ///When it is not a new container and selectedContainerData is null, Delete the relationship.
                          log('Deleted containerRelationship.');
                          database!.writeTxnSync((isar) {
                            isar.containerRelationships.deleteSync(isar
                                .containerRelationships
                                .filter()
                                .containerUIDMatches(currentContainerUID!)
                                .findFirstSync()!
                                .id);
                          });
                        }

                        setState(() {});
                      },
                      child: OrangeOutlineContainer(
                        padding: 5,
                        child: Text('select',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            outlineColor: outlineColor ?? Colors.white60));
  }
}
