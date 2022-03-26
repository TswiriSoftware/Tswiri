import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_system/create_container_views/create_new_container_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/statefull_container_edit_widgets/container_barcode_edit_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/statefull_container_edit_widgets/container_children_position_edit_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/statefull_container_edit_widgets/container_description_edit_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/statefull_container_edit_widgets/container_marker_edit_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/statefull_container_edit_widgets/container_name_edit_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/statefull_container_edit_widgets/container_parent_edit_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/stateless_container_display_widgets/container_barcode_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/stateless_container_display_widgets/container_description_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/stateless_container_display_widgets/container_name_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/stateless_container_display_widgets/container_parent_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/orange_text_button_widget.dart';
import 'package:isar/isar.dart';
import '../../../functions/barcodeTools/hide_keyboard.dart';
import '../../../isar_database/container_entry/container_entry.dart';

import '../../../isar_database/functions/isar_functions.dart';

class ContainerView extends StatefulWidget {
  const ContainerView({Key? key, required this.containerUID}) : super(key: key);
  final String containerUID;

  @override
  State<ContainerView> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerView> {
  ContainerEntry? containerEntry;
  ContainerEntry? parentContainerEntry;
  List<ContainerEntry> children = [];
  bool editActive = false;
  bool showChildren = false;

  @override
  void initState() {
    getContainerInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => hideKeyboard(context)),
      child: Scaffold(
        appBar: AppBar(
          title: _titleBuilder(),
          automaticallyImplyLeading: false,
          leading: Builder(builder: (context) {
            if (editActive) {
              return _hideBackButton();
            }
            return _showBackButton();
          }),
          actions: [
            Builder(
              builder: (context) {
                if (editActive) {
                  return _scaffoldSaveButton();
                } else {
                  return _scaffoldEditButton();
                }
              },
            ),
          ],
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  if (editActive) {
                    return _buildContainerEdit();
                  } else {
                    return _buildContainerDisplay();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleBuilder() {
    return Builder(builder: (context) {
      return Text(
        containerEntry?.name ?? widget.containerUID,
        style: Theme.of(context).textTheme.titleLarge,
      );
    });
  }

  Widget _showBackButton() {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  Widget _hideBackButton() {
    return Container();
  }

  Widget _scaffoldEditButton() {
    return IconButton(
      onPressed: () {
        editActive = !editActive;
        setState(() {});
      },
      icon: const Icon(Icons.edit),
    );
  }

  Widget _scaffoldSaveButton() {
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

  Widget _buildContainerDisplay() {
    return Column(
      children: [
        //Name stateless
        ContainerNameDisplayWidget(
          name: containerEntry?.name ?? containerEntry!.containerUID,
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

        //Children Widget
        childrenWidget(),
      ],
    );
  }

  Widget _buildContainerEdit() {
    return Column(
      children: [
        //Name edit
        ContainerNameEditWidget(
          containerEntry: containerEntry!,
        ),

        //Description edit.
        ContainerDescriptionEditWidget(
          containerEntry: containerEntry!,
        ),

        //Parent edit.
        ContainerParentEditWidget(
          currentContainerUID: containerEntry!.containerUID,
        ),

        //Barcode edit.
        ContainerBarcodeEiditWidget(
          containerUID: containerEntry!.containerUID,
        ),

        //Marker edit.
        ContainerMarkerEditWidget(
          currentContainerUID: containerEntry!.containerUID,
        ),

        //Children Position Scan.
        ContainerChildrenPositionEdit(
          currentContainerUID: containerEntry!.containerUID,
        ),
      ],
    );
  }

  Widget childrenWidget() {
    return LightContainer(
      margin: 2.5,
      padding: 2.5,
      child: OrangeOutlineContainer(
        margin: 0,
        padding: 8,
        borderWidth: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Children:', style: Theme.of(context).textTheme.bodySmall),
            const Divider(),
            Row(
              children: [
                Text(
                  'Number of children: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  children.length.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Builder(builder: (context) {
              if (showChildren) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: OrangeOutlineContainer(
                    padding: 8,
                    margin: 2.5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: children.map((e) => childWidget(e)).toList(),
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
            const SizedBox(
              height: 5,
            ),
            Builder(builder: (context) {
              String text;
              if (!showChildren) {
                text = 'view';
              } else {
                text = 'hide';
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrangeTextButton(
                    text: 'add',
                    onTap: () async {
                      await Navigator.push(
                        context,
                        (MaterialPageRoute(
                          builder: (context) => CreateNewContainerView(
                            containerEntry: containerEntry,
                          ),
                        )),
                      );
                      getContainerInfo();
                      setState(() {});
                    },
                  ),
                  OrangeTextButton(
                    text: text,
                    onTap: () {
                      if (children.isNotEmpty) {
                        showChildren = !showChildren;
                        setState(() {});
                      }
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget childWidget(ContainerEntry containerEntry) {
    return Builder(builder: (context) {
      Color color =
          getContainerColor(containerUID: containerEntry.containerUID);
      return LightContainer(
        padding: 0,
        margin: 5,
        child: CustomOutlineContainer(
          outlineColor: color,
          padding: 5,
          margin: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'containerName:',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Divider(
                height: 2.5,
              ),
              Text(
                containerEntry.name ?? containerEntry.containerUID,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OrangeTextButton(
                      text: 'edit',
                      onTap: () {
                        Navigator.push(
                          context,
                          (MaterialPageRoute(
                            builder: (context) => ContainerView(
                              containerUID: containerEntry.containerUID,
                            ),
                          )),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  void getContainerInfo() {
    String? parentContainerUID;
    //Get containerEntry.
    containerEntry = isarDatabase!.containerEntrys
        .filter()
        .containerUIDMatches(widget.containerUID)
        .findFirstSync();

    //get parent containerUID
    parentContainerUID = isarDatabase!.containerRelationships
        .filter()
        .containerUIDMatches(containerEntry!.containerUID)
        .findFirstSync()
        ?.parentUID;

    //get parent containerEntry
    if (parentContainerUID != null) {
      parentContainerEntry = isarDatabase!.containerEntrys
          .filter()
          .containerUIDMatches(parentContainerUID)
          .findFirstSync();
    }

    List<String> childrenUIDs = isarDatabase!.containerRelationships
        .filter()
        .parentUIDMatches(containerEntry!.containerUID)
        .containerUIDProperty()
        .findAllSync();

    log(childrenUIDs.length.toString());
    children = [];
    for (String child in childrenUIDs) {
      children.add(isarDatabase!.containerEntrys
          .filter()
          .containerUIDMatches(child)
          .findFirstSync()!);
    }

    setState(() {});
  }
}
