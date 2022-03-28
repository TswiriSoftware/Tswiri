import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/widgets/container_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:isar/isar.dart';

class ContainerView extends StatefulWidget {
  const ContainerView({Key? key, required this.containerEntry})
      : super(key: key);

  final ContainerEntry containerEntry;

  @override
  State<ContainerView> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ContainerEntry? containerEntry;
  Color? containerTypeColor;
  bool isEditting = false;
  bool isShowingChildren = false;

  @override
  void initState() {
    containerEntry = widget.containerEntry;
    containerTypeColor =
        getContainerColor(containerUID: containerEntry!.containerUID);

    nameController.text = containerEntry?.name ?? containerEntry!.containerUID;
    descriptionController.text = containerEntry?.description ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerTypeColor,
        title: Text(
          containerEntry?.name ?? containerEntry?.containerUID ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //NameWidget
            _entryInfo(),
            //Children
            _childrenInfo()
          ],
        ),
      ),
    );
  }

  Widget _childrenInfo() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
        margin: 2.5,
        padding: 10,
        child: Builder(
          builder: (context) {
            List<ContainerRelationship> childrenRelationships = isarDatabase!
                .containerRelationships
                .filter()
                .parentUIDMatches(containerEntry!.containerUID)
                .findAllSync();
            log(childrenRelationships.toString());
            List<ContainerEntry> children = [];

            if (childrenRelationships.isNotEmpty) {
              children = isarDatabase!.containerEntrys
                  .filter()
                  .repeat(
                      childrenRelationships,
                      (q, ContainerRelationship element) =>
                          q.containerUIDMatches(element.containerUID))
                  .findAllSync();
            }

            log(children.toString());
            if (isShowingChildren) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Children',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        InkWell(
                          onTap: () {
                            isShowingChildren = !isShowingChildren;
                            setState(() {});
                          },
                          child: CustomOutlineContainer(
                            padding: 5,
                            width: 80,
                            height: 30,
                            child: Center(
                              child: Text(
                                'Hide',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            outlineColor: containerTypeColor!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children:
                        children.map((e) => containerDisplayWidget(e)).toList(),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Children',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            childrenRelationships.length.toString(),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          isShowingChildren = !isShowingChildren;
                          setState(() {});
                        },
                        child: CustomOutlineContainer(
                          padding: 5,
                          width: 80,
                          height: 30,
                          child: Center(
                            child: Text(
                              'View',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          outlineColor: containerTypeColor!,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
        outlineColor: containerTypeColor!,
      ),
    );
  }

  Widget _entryInfo() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
        outlineColor: containerTypeColor!,
        margin: 2.5,
        padding: 5,
        child: Builder(
          builder: (context) {
            if (isEditting) {
              return _entryEdit();
            } else {
              return _entryDisplay();
            }
          },
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 10,
      thickness: .5,
      color: containerTypeColor!,
    );
  }

  Widget textButton({required String text, required void Function() ontap}) {
    return InkWell(
      child: CustomOutlineContainer(
        padding: 5,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        outlineColor: containerTypeColor!,
      ),
    );
  }

  Widget _entryEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: TextField(
            controller: nameController,
            style: const TextStyle(fontSize: 18),
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
              labelText: 'Name',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ),
        ),
        _divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          child: TextField(
            controller: descriptionController,
            style: const TextStyle(fontSize: 18),
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
              labelText: 'Description',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ),
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                isEditting = !isEditting;
                containerEntry!.name = nameController.text;
                containerEntry!.description = descriptionController.text;

                isarDatabase!.writeTxnSync(
                  (isar) => isar.containerEntrys
                      .putSync(containerEntry!, replaceOnConflict: true),
                );

                setState(() {});
              },
              child: CustomOutlineContainer(
                width: 80,
                height: 30,
                padding: 5,
                child: Center(
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                outlineColor: containerTypeColor!,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _entryDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name/UID',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                containerEntry!.name ?? containerEntry!.containerUID,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        _divider(),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                containerEntry!.description ?? '',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        _divider(),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Container Type',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                containerEntry!.containerType,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        _divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                isEditting = !isEditting;
                setState(() {});
              },
              child: CustomOutlineContainer(
                padding: 5,
                width: 80,
                height: 30,
                child: Center(
                  child: Text(
                    'Edit',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                outlineColor: containerTypeColor!,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
