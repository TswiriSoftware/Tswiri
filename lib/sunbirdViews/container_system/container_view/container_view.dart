import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/statefull_container_edit_widgets/container_barcode_edit_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/statefull_container_edit_widgets/container_description_edit_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/statefull_container_edit_widgets/container_name_edit_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/statefull_container_edit_widgets/container_parent_edit_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/stateless_container_display_widgets/container_barcode_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/stateless_container_display_widgets/container_children_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/stateless_container_display_widgets/container_description_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/stateless_container_display_widgets/container_name_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/stateless_container_display_widgets/container_parent_display_widget.dart';
import 'package:isar/isar.dart';
import '../../../functions/barcodeTools/hide_keyboard.dart';
import '../../../isar/container_isar/container_isar.dart';

import '../../../isar/functions/isar_functions.dart';

class ContainerView extends StatefulWidget {
  const ContainerView({Key? key, required this.containerUID, this.database})
      : super(key: key);
  final String containerUID;
  final Isar? database;
  @override
  State<ContainerView> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerView> {
  Isar? database;
  ContainerEntry? containerEntry;
  ContainerEntry? parentContainerEntry;
  List<ContainerEntry> children = [];
  bool editActive = false;

  @override
  void initState() {
    database = widget.database;
    database ??= openIsar();
    getContainerInfo();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.database == null) {
      database!.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => hideKeyboard(context)),
      child: Scaffold(
        appBar: AppBar(
          title: Builder(builder: (context) {
            return Text(containerEntry?.name ?? widget.containerUID);
          }),
          automaticallyImplyLeading: false,
          leading: Builder(builder: (context) {
            if (editActive) {
              return Container();
            }
            return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ));
          }),
          actions: [
            Builder(builder: (context) {
              if (!editActive) {
                return IconButton(
                  onPressed: () {
                    editActive = !editActive;
                    setState(() {});
                  },
                  icon: const Icon(Icons.edit),
                );
              } else {
                return IconButton(
                  onPressed: () {
                    editActive = !editActive;
                    //Update the container info.
                    getContainerInfo();
                    setState(() {});
                  },
                  icon: const Icon(Icons.save),
                );
              }
            })
          ],
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Builder(builder: (context) {
                if (editActive) {
                  return Column(
                    children: [
                      //Name edit
                      ContainerNameEditWidget(
                        containerUID: containerEntry!.containerUID,
                        database: database!,
                      ),

                      //Description edit.
                      ContainerDescriptionEditWidget(
                          containerUID: containerEntry!.containerUID,
                          database: database!),

                      //Parent edit.
                      ContainerParentEditWidget(
                        database: database!,
                        currentContainerUID: containerEntry!.containerUID,
                      ),

                      //Barcode edit.
                      ContainerBarcodeEiditWidget(
                          database: database!,
                          containerUID: containerEntry!.containerUID),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      //Name stateless
                      ContainerNameDisplayWidget(
                        name: containerEntry?.name ??
                            containerEntry!.containerUID,
                      ),

                      //Description stateless
                      Builder(builder: (context) {
                        if (containerEntry!.description == null ||
                            containerEntry!.description!.isEmpty) {
                          return Container();
                        }
                        return ContainerDescriptionDisplayWidget(
                          description: containerEntry?.description,
                        );
                      }),

                      //Parent stateless
                      Builder(builder: (context) {
                        if (parentContainerEntry == null) {
                          return Container();
                        }
                        return ContainerParentDisplayWidget(
                          parentName: parentContainerEntry?.name ??
                              parentContainerEntry?.containerUID,
                          parentUID: parentContainerEntry?.containerUID,
                        );
                      }),

                      //BarcodeUID stateless
                      Builder(builder: (context) {
                        if (containerEntry!.barcodeUID == null) {
                          return Container();
                        }
                        return ContainerBarcodeDisplayWidget(
                          barcodeUID: containerEntry?.barcodeUID,
                        );
                      }),

                      //Container Children
                      ContainerChildrenDisplayWidget(
                          children: children,
                          database: database!,
                          updateChildren: getContainerInfo),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  void getContainerInfo() {
    String? parentContainerUID;
    //Get containerEntry.
    containerEntry = database!.containerEntrys
        .filter()
        .containerUIDMatches(widget.containerUID)
        .findFirstSync();

    //get parent containerUID
    parentContainerUID = database!.containerRelationships
        .filter()
        .containerUIDMatches(containerEntry!.containerUID)
        .findFirstSync()
        ?.parentUID;

    //get parent containerEntry
    if (parentContainerUID != null) {
      parentContainerEntry = database!.containerEntrys
          .filter()
          .containerUIDMatches(parentContainerUID)
          .findFirstSync();
    }

    List<String> childrenUIDs = database!.containerRelationships
        .filter()
        .parentUIDMatches(containerEntry!.containerUID)
        .containerUIDProperty()
        .findAllSync();

    log(childrenUIDs.length.toString());
    children = [];
    for (String child in childrenUIDs) {
      children.add(database!.containerEntrys
          .filter()
          .containerUIDMatches(child)
          .findFirstSync()!);
    }

    setState(() {});
  }
}
