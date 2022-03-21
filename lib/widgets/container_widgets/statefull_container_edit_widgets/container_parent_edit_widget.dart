import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container/container_isar.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

import '../../../sunbird_views/container_system/container_select_views/container_selector_view.dart';

class ContainerParentEditWidget extends StatefulWidget {
  const ContainerParentEditWidget({
    Key? key,
    required this.database,
    required this.currentContainerUID,
  }) : super(key: key);

  final Isar database;
  final String currentContainerUID;

  @override
  State<ContainerParentEditWidget> createState() =>
      _ContainerParentEditWidgetState();
}

class _ContainerParentEditWidgetState extends State<ContainerParentEditWidget> {
  ContainerEntry? parentContainerEntry;
  String? parentContainerUID;
  String? parentContainerName;
  Color outlineColor = Colors.white60;

  @override
  void initState() {
    parentContainerUID = widget.database.containerRelationships
        .filter()
        .containerUIDMatches(widget.currentContainerUID)
        .findFirstSync()
        ?.parentUID;

    if (parentContainerUID != null) {
      //Get containerEntry.
      parentContainerEntry = widget.database.containerEntrys
          .filter()
          .containerUIDMatches(parentContainerUID!)
          .findFirstSync();
      parentContainerName = parentContainerEntry?.name;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: Builder(builder: (context) {
        if (parentContainerUID == null) {
          outlineColor = Colors.white60;
        } else {
          outlineColor = Colors.deepOrange;
        }
        return CustomOutlineContainer(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('parentName',
                    style: Theme.of(context).textTheme.bodySmall),
                Text(parentContainerName ?? parentContainerUID ?? "'",
                    style: Theme.of(context).textTheme.subtitle2),
                Text('parentUID', style: Theme.of(context).textTheme.bodySmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(parentContainerUID ?? "'",
                        style: Theme.of(context).textTheme.subtitle2),
                    InkWell(
                      onTap: () async {
                        ContainerEntry? selectedParent = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContainerSelectorView(
                              currentContainerUID: widget.currentContainerUID,
                              database: widget.database,
                              multipleSelect: false,
                            ),
                          ),
                        );
                        if (selectedParent != null) {
                          setState(() {
                            parentContainerUID = selectedParent.containerUID;
                            parentContainerName = selectedParent.name;
                          });

                          ContainerRelationship? containerRelationship = widget
                              .database.containerRelationships
                              .filter()
                              .containerUIDMatches(widget.currentContainerUID)
                              .findFirstSync();
                          //Update existing relationship.
                          if (containerRelationship != null) {
                            containerRelationship.parentUID =
                                parentContainerUID;

                            widget.database.writeTxnSync(
                              (isar) {
                                isar.containerRelationships
                                    .putSync(containerRelationship);
                              },
                            );
                          } else {
                            //Create new relationship.
                            ContainerRelationship? containerRelationship =
                                ContainerRelationship()
                                  ..containerUID = widget.currentContainerUID
                                  ..parentUID = selectedParent.name;
                            widget.database.writeTxnSync(
                              (isar) {
                                isar.containerRelationships
                                    .putSync(containerRelationship);
                              },
                            );
                          }
                        } else if (selectedParent == null &&
                            parentContainerEntry != null) {
                          //delete relationship.
                          widget.database.writeTxnSync((isar) {
                            isar.containerRelationships.deleteSync(isar
                                .containerRelationships
                                .filter()
                                .containerUIDMatches(widget.currentContainerUID)
                                .findFirstSync()!
                                .id);
                          });
                        }
                      },
                      child: OrangeOutlineContainer(
                        child: Text(
                          'select',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          outlineColor: outlineColor,
        );
      }),
    );
  }
}
