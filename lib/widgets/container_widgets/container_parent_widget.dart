import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar/container_isar.dart';
import 'package:flutter_google_ml_kit/isar/container_relationship.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

import '../../sunbirdViews/containerSystem/container_selector_view.dart';
import '../../sunbirdViews/containerSystem/functions/isar_functions.dart';
import '../basic_outline_containers/custom_outline_container.dart';
import '../basic_outline_containers/light_container.dart';

//TODO: convert to statefull

class ContainerParentWidget extends StatefulWidget {
  const ContainerParentWidget({
    Key? key,
    required this.currentContainerUID,
    required this.database,
  }) : super(key: key);

  final Isar database;
  final String currentContainerUID;

  @override
  State<ContainerParentWidget> createState() => _ContainerParentWidgetState();
}

class _ContainerParentWidgetState extends State<ContainerParentWidget> {
  Isar? database;

  int? parentContainerID;
  ContainerEntry? parentContainerEntry;
  ContainerRelationship? containerRelationship;

  String? parentContainerName;
  String? parentContainerUID;
  Color? parentContainerTypeColor;
  Color? displayColor;

  @override
  void initState() {
    database = widget.database;

    containerRelationship = getContainerRelationship(
        database: database!, currentContainerUID: widget.currentContainerUID);

    getParentContainerData();

    parentContainerName = parentContainerEntry?.name;
    parentContainerUID = parentContainerEntry?.containerUID;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: Builder(builder: (context) {
        if (parentContainerTypeColor != null) {
          displayColor = parentContainerTypeColor!;
        }
        return CustomOutlineContainer(
          outlineColor: displayColor ?? Colors.white60,
          padding: 0,
          margin: 0,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('parentName',
                    style: Theme.of(context).textTheme.bodySmall),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    parentContainerName ?? parentContainerUID ?? '',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Text('parentUID', style: Theme.of(context).textTheme.bodySmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      parentContainerUID ?? 'Select parent',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    InkWell(
                      onTap: () async {
                        List<String?>? parentContainerData =
                            await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContainerSelectorView(
                              currentContainerUID: widget.currentContainerUID,
                              database: database,
                              multipleSelect: false,
                            ),
                          ),
                        );
                        if (parentContainerData != null) {
                          parentContainerName = parentContainerData[1];
                          parentContainerUID = parentContainerData[0];

                          if (containerRelationship == null) {
                            containerRelationship = ContainerRelationship()
                              ..containerUID = widget.currentContainerUID
                              ..parentUID = parentContainerUID;
                          } else {
                            containerRelationship!
                              ..containerUID = widget.currentContainerUID
                              ..parentUID = parentContainerUID;
                          }
                          setState(() {
                            getParentContainerData();
                          });
                          database!.writeTxnSync((isar) {
                            isar.containerRelationships
                                .putSync(containerRelationship!);
                          });
                        } else if (containerRelationship != null) {
                          database!.writeTxnSync((isar) {
                            isar.containerRelationships
                                .deleteSync(containerRelationship!.id);
                          });
                        }
                        setState(() {});
                      },
                      child: const OrangeOutlineContainer(
                        padding: 8,
                        child: Text('select'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void getParentContainerData() {
    parentContainerID = getContainerID(
        containerEntrys: database!.containerEntrys,
        containerUID: containerRelationship?.parentUID ?? '');

    if (parentContainerID != null) {
      parentContainerEntry =
          database!.containerEntrys.getSync(parentContainerID!);
      parentContainerTypeColor =
          getContainerTypeColor(database: database!, id: parentContainerID!);
    }
  }
}
