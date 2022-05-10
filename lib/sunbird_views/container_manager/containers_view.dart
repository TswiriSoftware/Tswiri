import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/interbarcode_vector_entry/interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/new_container_view.dart';
import 'package:isar/isar.dart';

class ContainersView extends StatefulWidget {
  const ContainersView({Key? key}) : super(key: key);

  @override
  State<ContainersView> createState() => _ContainersViewState();
}

class _ContainersViewState extends State<ContainersView> {
  //Text Controller.
  TextEditingController searchController = TextEditingController();

  //Search FocusNode.
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  List<ContainerEntry> containers = [];
  List<String> selectedContainers = [];
  bool showCheckBoxes = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
    search('');
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Builder(builder: (context) {
          if (showCheckBoxes) {
            return selectionActions();
          } else {
            return _textField();
          }
        }),
        shadowColor: Colors.black54,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _focusNode.hasFocus ? null : _addButton(),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _focusNode.unfocus();
          });
        },
        child: Column(
          children: [
            Text(
              'hold for more options',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: containers.length,
                  itemBuilder: ((context, index) {
                    return containerCard(containers[index]);
                  })),
            ),
          ],
        ),
      ),
    );
  }

  ///SEARCH///

  Widget _textField() {
    return TextField(
      focusNode: _focusNode,
      controller: searchController,
      onChanged: (value) {
        setState(() {
          search(value);
        });
      },
      cursorColor: Colors.white,
      style: Theme.of(context).textTheme.labelLarge,
      decoration: InputDecoration(
        suffixIcon: isFocused ? null : _searchIcon(),
        hintText: 'Search',
        hintStyle: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _searchIcon() {
    return const Icon(
      Icons.search,
      color: Colors.white,
    );
  }

  ///CONTAINER///

  Widget containerCard(ContainerEntry containerEntry) {
    return Builder(
      builder: (context) {
        Color containerColor =
            getContainerColor(containerUID: containerEntry.containerUID);

        return InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContainerView(
                  containerEntry: containerEntry,
                ),
              ),
            );
            search('');
            setState(() {});
          },
          onLongPress: () {
            showCheckBoxes = true;
            selectedContainers.add(containerEntry.containerUID);
            setState(() {});
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.white12,
            elevation: 5,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: containerColor, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///NAME///
                  name(containerEntry, containerColor),

                  ///DESCRIPTION///
                  description(containerEntry),

                  ///BARCODE///
                  barcode(containerEntry, containerColor),

                  ///TAGS///
                  userTags(containerEntry, containerColor),

                  ///INFO///
                  _info()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget name(ContainerEntry containerEntry, Color containerColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///NAME///
            Text(
              'Name',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              containerEntry.name ?? containerEntry.containerUID,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Divider(
              height: 5,
              indent: 2,
            ),
          ],
        ),
        Visibility(
            visible: showCheckBoxes,
            child: checkBox(containerEntry, containerColor)),
      ],
    );
  }

  Widget description(ContainerEntry containerEntry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///DESCRIPTION///
        Text(
          'Description',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          containerEntry.description ?? '-',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Divider(
          height: 5,
          indent: 2,
        ),
      ],
    );
  }

  Widget userTags(ContainerEntry containerEntry, Color containerColor) {
    return Builder(
      builder: (context) {
        List<ContainerTag> tags = [];
        tags.addAll(isarDatabase!.containerTags
            .filter()
            .containerUIDContains(containerEntry.containerUID)
            .findAllSync());

        if (tags.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tags',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 5,
                  children:
                      tags.map((e) => tagChip(e, containerColor)).toList(),
                ),
              ),
            ],
          );
        } else {
          return Row();
        }
      },
    );
  }

  Widget barcode(ContainerEntry containerEntry, Color containerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///NAME///
        Text(
          'BarcodeUID',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          containerEntry.barcodeUID!,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Divider(
          height: 5,
          indent: 2,
        ),
      ],
    );
  }

  Widget _info() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'tap to edit',
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }

  Widget tagChip(ContainerTag containerTag, Color containerColor) {
    return Builder(builder: (context) {
      String tag = isarDatabase!.tags
          .filter()
          .idEqualTo(containerTag.tagID)
          .findFirstSync()!
          .tag;
      return Chip(
        label: Text(
          tag,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: containerColor,
      );
    });
  }

  Widget checkBox(ContainerEntry containerEntry, Color containerColor) {
    return Checkbox(
        value: selectedContainers.contains(containerEntry.containerUID),
        fillColor: MaterialStateProperty.all(containerColor),
        onChanged: (value) {
          _onSelectedFilter(value!, containerEntry.containerUID);
          if (selectedContainers.isEmpty) {
            showCheckBoxes = false;
          } else {
            showCheckBoxes = true;
          }
          setState(() {});
        });
  }

  ///NEW CONTAINER///

  Widget _addButton() {
    return Visibility(
      visible: !isFocused,
      child: FloatingActionButton(
        elevation: 10,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewContainerView()),
          );

          search('');
          setState(() {});
        },
        child: _addIcon(),
      ),
    );
  }

  Widget _addIcon() {
    return const Icon(
      Icons.add,
      color: Colors.white,
    );
  }

  void search(String enteredKeyword) {
    if (enteredKeyword.isNotEmpty) {
      enteredKeyword = enteredKeyword.toLowerCase();
      containers = isarDatabase!.containerEntrys
          .filter()
          .nameContains(enteredKeyword, caseSensitive: false)
          .or()
          .descriptionContains(enteredKeyword, caseSensitive: false)
          .findAllSync();
    } else {
      containers = isarDatabase!.containerEntrys.where().findAllSync();
    }
  }

  void _onSelectedFilter(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        selectedContainers.add(dataName);
      });
    } else {
      setState(() {
        selectedContainers.remove(dataName);
      });
    }
  }

  Widget selectionActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            deleteSelection();
          },
          icon: const Icon(Icons.delete),
        ),
        IconButton(
          onPressed: () {
            if (selectedContainers.isEmpty) {
              selectedContainers.addAll(containers.map((e) => e.containerUID));
            } else {
              selectedContainers = [];
            }
            setState(() {});
          },
          icon: const Icon(Icons.select_all),
        ),
        IconButton(
          onPressed: () {
            showCheckBoxes = false;
            selectedContainers = [];
            setState(() {});
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  void deleteSelection() {
    List<Marker> markers = [];
    List<InterBarcodeVectorEntry> interBarcodeData = [];
    List<ContainerRelationship> containerRelationships = [];
    List<ContainerTag> containerTags = [];

    List<ContainerPhoto> containerPhotos = [];
    List<PhotoTag> photoTags = [];
    List<ContainerEntry> containerEntries = [];

    if (selectedContainers.isNotEmpty) {
      List<ContainerEntry> containersToDelete = isarDatabase!.containerEntrys
          .filter()
          .repeat(selectedContainers,
              (q, String element) => q.containerUIDMatches(element))
          .findAllSync();

      containerEntries.addAll(containersToDelete);

      for (ContainerEntry container in containersToDelete) {
        //Markers
        markers.addAll(isarDatabase!.markers
            .filter()
            .parentContainerUIDMatches(container.containerUID)
            .findAllSync());

        //InterBarcodeData
        if (container.barcodeUID != null) {
          interBarcodeData.addAll(isarDatabase!.interBarcodeVectorEntrys
              .filter()
              .endBarcodeUIDMatches(container.barcodeUID!)
              .or()
              .startBarcodeUIDMatches(container.barcodeUID!)
              .findAllSync());
        }

        //Relationships
        containerRelationships.addAll(isarDatabase!.containerRelationships
            .filter()
            .containerUIDMatches(container.containerUID)
            .findAllSync());

        //Container Tags
        containerTags.addAll(isarDatabase!.containerTags
            .filter()
            .containerUIDMatches(container.containerUID)
            .findAllSync());

        //Container Photos
        containerPhotos.addAll(isarDatabase!.containerPhotos
            .filter()
            .containerUIDMatches(container.containerUID)
            .findAllSync());

        //Photo Tags
        photoTags.addAll(isarDatabase!.photoTags
            .filter()
            .repeat(
                containerPhotos,
                (q, ContainerPhoto element) =>
                    q.photoPathMatches(element.photoPath))
            .findAllSync());
      }
    }

    //Delete marker. *
    //Delete realInterBarcodeData.*
    //Container Relationships.*
    //Delete Container Tags. *
    //Delete photo tags. *
    //Delete Container Photos and Photo.* - delete physical photo
    //Delete Container Entry.

    //Delete on device Photos
    for (ContainerPhoto containerPhoto in containerPhotos) {
      if (File(containerPhoto.photoPath).existsSync()) {
        File(containerPhoto.photoPath).deleteSync();
        File(containerPhoto.photoThumbnailPath).deleteSync();
      }
    }

    isarDatabase!.writeTxnSync((isar) {
      isar.markers
          .filter()
          .repeat(markers,
              (q, Marker element) => q.barcodeUIDMatches(element.barcodeUID))
          .deleteFirstSync();
      isar.interBarcodeVectorEntrys
          .filter()
          .repeat(
              markers,
              (q, Marker element) => q.group((q) => q
                  .endBarcodeUIDMatches(element.barcodeUID)
                  .or()
                  .startBarcodeUIDMatches(element.barcodeUID)))
          .deleteAllSync();
      isar.containerRelationships
          .filter()
          .repeat(
              containerRelationships,
              (q, ContainerRelationship element) =>
                  q.containerUIDMatches(element.containerUID))
          .deleteAllSync();
      isar.containerTags
          .filter()
          .repeat(
              containerTags,
              (q, ContainerTag element) =>
                  q.containerUIDMatches(element.containerUID))
          .deleteAllSync();
      isar.containerPhotos
          .filter()
          .repeat(
              containerPhotos,
              (q, ContainerPhoto element) =>
                  q.photoPathMatches(element.photoPath))
          .deleteAllSync();

      isar.photoTags
          .filter()
          .repeat(photoTags,
              (q, PhotoTag element) => q.photoPathMatches(element.photoPath))
          .deleteAllSync();
      isar.containerEntrys
          .filter()
          .repeat(
              containerEntries,
              (q, ContainerEntry element) =>
                  q.containerUIDMatches(element.containerUID))
          .deleteAllSync();
    });
    showCheckBoxes = false;
    search('');
    setState(() {});
  }
}
