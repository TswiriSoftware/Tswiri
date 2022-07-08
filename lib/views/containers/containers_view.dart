import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/user_tag/user_tag.dart';
import 'package:flutter_google_ml_kit/views/containers/container_view.dart';
import 'package:flutter_google_ml_kit/views/containers/new_container_view.dart';
import 'package:isar/isar.dart';

class ContainersView extends StatefulWidget {
  const ContainersView({Key? key}) : super(key: key);

  @override
  State<ContainersView> createState() => _ContainersViewState();
}

List<String> filters = ['shelf', 'area', 'drawer', 'box'];

class _ContainersViewState extends State<ContainersView> {
  //Search//
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  List<String> selectedContainers = [];
  bool isSelecting = false;

  //Containers//
  List<ContainerEntry> containers = [];

  late List<ContainerType> x =
      isarDatabase!.containerTypes.where().findAllSync();

  late Map containerColors = {
    for (var e in x)
      e.containerType: Color(int.parse(e.containerColor)).withOpacity(1)
  };

  late List<String> filterTypes = x.map((e) => e.containerType).toList();

  @override
  void initState() {
    search(null);
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });

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
      appBar: _appBar(),
      body: _body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _focusNode.hasFocus ? null : _addButton(),
    );
  }

  ///APP BAR///
  AppBar _appBar() {
    return AppBar(
      backgroundColor: sunbirdOrange,
      elevation: 25,
      centerTitle: true,
      title: Builder(builder: (context) {
        if (isSelecting) {
          return _selectionActions();
        } else {
          return _searchField();
        }
      }),
      shadowColor: Colors.black54,
    );
  }

  ///SEARCH FIELD///
  Widget _searchField() {
    return TextField(
      focusNode: _focusNode,
      controller: searchController,
      onChanged: (value) {
        search(value);
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

  ///FILTER///

  Widget _filters() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 5,
        children: filterTypes
            .map((e) => fliterChip(filter: e, tooltip: 'Filter by Type'))
            .toList(),
      ),
    );
  }

  FilterChip fliterChip({required String filter, required String tooltip}) {
    return FilterChip(
      label: Text(
        filter.capitalize(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onSelected: (selected) {
        _onSelected(selected, filter);
        setState(() {
          search(searchController.text);
        });
      },
      selected: filters.contains(filter),
      selectedColor: sunbirdOrange,
      tooltip: tooltip,
      elevation: 5,
      shadowColor: Colors.black54,
    );
  }

  void _onSelected(bool selected, String filter) {
    if (filters.contains(filter)) {
      setState(() {
        filters.removeWhere((element) => element == filter);
      });
    } else {
      setState(() {
        filters.add(filter);
      });
    }
  }

  ///SELECT ACTIONS///
  Widget _selectionActions() {
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
            isSelecting = false;
            selectedContainers = [];
            setState(() {});
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  ///BODY///
  Widget _body() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 50),
          itemCount: containers.length,
          itemBuilder: (context, index) {
            return container(containers[index],
                containerColors[containers[index].containerType]);
          },
        ),
        _filters(),
      ],
    );
  }

  ///CONTAINER CARD///

  Widget container(ContainerEntry containerEntry, Color color) {
    return GestureDetector(
      onLongPress: () {
        if (selectedContainers.isEmpty && !isSelecting) {
          setState(() {
            isSelecting = true;
            selectedContainers.add(containerEntry.containerUID);
            HapticFeedback.lightImpact();
          });
        }
      },
      onTap: () async {
        if (selectedContainers.isNotEmpty && isSelecting) {
          if (selectedContainers.isNotEmpty && isSelecting) {
            if (selectedContainers.contains(containerEntry.containerUID)) {
              selectedContainers.remove(containerEntry.containerUID);
              HapticFeedback.lightImpact();
              if (selectedContainers.isEmpty) {
                isSelecting = false;
              }
            } else {
              setState(() {
                selectedContainers.add(containerEntry.containerUID);
                HapticFeedback.lightImpact();
              });
            }
          }
          log(selectedContainers.toString());
          setState(() {});
        } else {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContainerView(
                containerEntry: containerEntry,
              ),
            ),
          );
        }
        search(null);
      },
      child: Builder(builder: (context) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          color: Colors.white12,
          elevation: 5,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            side: selectedContainers.contains(containerEntry.containerUID)
                ? const BorderSide(color: Colors.limeAccent, width: 3)
                : BorderSide(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///NAME///
                name(containerEntry.name, containerEntry.containerUID),
                const Divider(),

                ///DESCRIPTION///
                description(containerEntry.description),
                const Divider(),

                ///BARCODE///
                barcode(containerEntry.barcodeUID),
                const Divider(),

                userTags(containerEntry.containerUID, color),

                ///INFO///
                Center(
                  child: Text(
                    'Hold To Select',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  ///NAME///
  Widget name(String? name, String uid) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                name ?? '-',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const VerticalDivider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'UID',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                uid,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget description(String? description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          description ?? '-',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget barcode(String? barcodeUID) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Barcode UID',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          barcodeUID ?? '-',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget userTags(String containerUID, Color containerColor) {
    return Builder(builder: (context) {
      //Get container tags.
      List<ContainerTag> containerTags = isarDatabase!.containerTags
          .filter()
          .containerUIDMatches(containerUID)
          .findAllSync();

      if (containerTags.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tags',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 5,
                  children: containerTags
                      .map((e) => tagChip(e, containerColor))
                      .toList(),
                )),
            const Divider(),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget tagChip(ContainerTag containerTag, Color containerColor) {
    return Builder(builder: (context) {
      String? tag = isarDatabase!.tagTexts
              .filter()
              .idEqualTo(containerTag.textID)
              .findFirstSync()
              ?.text ??
          '';

      return Chip(
        label: Text(
          tag,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: containerColor,
      );
    });
  }

  ///ACTIONS///
  Widget _addButton() {
    return Visibility(
      visible: !isFocused,
      child: FloatingActionButton(
        key: const Key('new-container'),
        elevation: 10,
        onPressed: () async {
          ///Navigate to NewContainerView
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewContainerView()),
          );
          setState(() {
            containers = isarDatabase!.containerEntrys.where().findAllSync();
          });
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

  ///FUNCTIONS///
  void search(String? enteredText) {
    if (enteredText != null && enteredText.isNotEmpty) {
      enteredText = enteredText.toLowerCase();
      setState(() {
        containers = isarDatabase!.containerEntrys
            .filter()
            .nameContains(enteredText!, caseSensitive: false)
            .or()
            .descriptionContains(enteredText, caseSensitive: false)
            .findAllSync();
      });
    } else {
      containers = [];
      List<ContainerEntry> foundContainers =
          isarDatabase!.containerEntrys.where().findAllSync();

      for (String filter in filters) {
        containers.addAll(foundContainers
            .where((element) => element.containerType == filter));
      }
      //containers =

      setState(() {});
    }
  }

  void deleteSelection() async {
    //Delete Container Entry.
    //Delete ContainerRelationships.
    //Delete realInterBarcodeDataVectorEntry.
    //Delete Marker.
    //Delete ContainerTags.
    //Delete Container Photos and Thumbnails. - delete physical photo
    //Delete MlTags.
    //Delete UserTags.
    bool delete = true;

    //Throw Error when Deleting parent Container.
    List<ContainerEntry> containerEntries = [];
    List<ContainerRelationship> containerRelationships = [];
    //List<InterBarcodeVectorEntry> interBarcodeVectorEntries = [];
    List<Marker> containerMarkers = [];
    List<ContainerTag> containerTags = [];
    List<Photo> containerPhotos = [];
    List<MlTag> containerMlTags = [];
    List<UserTag> containerUserTags = [];

    for (String containerUID in selectedContainers) {
      //Get ContainerEntry.
      ContainerEntry container = isarDatabase!.containerEntrys
          .filter()
          .containerUIDMatches(containerUID)
          .findFirstSync()!;

      containerEntries.add(container);

      List<ContainerRelationship> children = isarDatabase!
          .containerRelationships
          .filter()
          .parentUIDMatches(containerUID)
          .findAllSync();

      if (children.isNotEmpty) {
        delete = await showDeleteDialog(container, children.length);
      }

      List<ContainerRelationship> parents = isarDatabase!.containerRelationships
          .filter()
          .containerUIDMatches(containerUID)
          .findAllSync();

      containerRelationships.addAll(parents);
      containerRelationships.addAll(children);

      // List<InterBarcodeVectorEntry> vectors = isarDatabase!
      //     .interBarcodeVectorEntrys
      //     .filter()
      //     .startBarcodeUIDMatches(container.barcodeUID!)
      //     .or()
      //     .endBarcodeUIDMatches(container.barcodeUID!)
      //     .findAllSync();

      // interBarcodeVectorEntries.addAll(vectors);

      List<Marker> markers = isarDatabase!.markers
          .filter()
          .parentContainerUIDMatches(containerUID)
          .findAllSync();

      // for (Marker marker in markers) {
      //   // List<InterBarcodeVectorEntry> markerVectors = isarDatabase!
      //   //     .interBarcodeVectorEntrys
      //   //     .filter()
      //   //     .startBarcodeUIDMatches(marker.barcodeUID)
      //   //     .or()
      //   //     .endBarcodeUIDMatches(marker.barcodeUID)
      //   //     .findAllSync();
      //   // interBarcodeVectorEntries.addAll(markerVectors);
      // }

      containerMarkers.addAll(markers);

      List<ContainerTag> tags = isarDatabase!.containerTags
          .filter()
          .containerUIDMatches(containerUID)
          .findAllSync();

      containerTags.addAll(tags);

      List<Photo> photos = isarDatabase!.photos
          .filter()
          .containerUIDMatches(containerUID)
          .findAllSync();

      containerPhotos.addAll(photos);

      List<MlTag> mlTags = isarDatabase!.mlTags
          .filter()
          .repeat(photos, (q, Photo photo) => q.photoIDEqualTo(photo.id))
          .findAllSync();

      containerMlTags.addAll(mlTags);

      List<UserTag> userTags = isarDatabase!.userTags
          .filter()
          .repeat(photos, (q, Photo photo) => q.photoIDEqualTo(photo.id))
          .findAllSync();

      containerUserTags.addAll(userTags);
    }

    //Delete on device Photos
    for (Photo containerPhoto in containerPhotos) {
      if (File(containerPhoto.photoPath).existsSync()) {
        File(containerPhoto.photoPath).deleteSync();
        File(containerPhoto.thumbnailPath).deleteSync();
      }
    }

    if (delete == true) {
      isarDatabase!.writeTxnSync((isar) {
        isar.markers
            .filter()
            .repeat(containerMarkers,
                (q, Marker element) => q.barcodeUIDMatches(element.barcodeUID))
            .deleteFirstSync();

        // isar.interBarcodeVectorEntrys
        //     .filter()
        //     .repeat(interBarcodeVectorEntries,
        //         (q, InterBarcodeVectorEntry element) => q.idEqualTo(element.id))
        //     .deleteAllSync();

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
                    q.containerUIDEqualTo(element.containerUID))
            .deleteAllSync();

        isar.photos
            .filter()
            .repeat(containerPhotos,
                (q, Photo element) => q.photoPathMatches(element.photoPath))
            .deleteAllSync();

        isar.mlTags
            .filter()
            .repeat(containerMlTags,
                (q, MlTag element) => q.photoIDEqualTo(element.id))
            .deleteAllSync();

        isar.containerEntrys
            .filter()
            .repeat(
                containerEntries,
                (q, ContainerEntry element) =>
                    q.containerUIDMatches(element.containerUID))
            .deleteAllSync();

        isar.userTags
            .filter()
            .repeat(containerUserTags,
                (q, UserTag element) => q.idEqualTo(element.id))
            .deleteAllSync();
      });
    }

    isSelecting = false;
    selectedContainers = [];
    search(null);
    setState(() {});
  }

  Future<bool> showDeleteDialog(
      ContainerEntry container, int numberOfChildren) async {
    bool delete = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (initialDialogContext) {
        return AlertDialog(
          title: Text('Delete ${container.name ?? container.containerUID}'),
          content: Text(
              'Are you sure you want to delete this container is has $numberOfChildren children.'),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(initialDialogContext, true);
              },
              child: const Text('delete'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(initialDialogContext, false);
              },
              child: const Text('cancel'),
            ),
          ],
        );
      },
    );
    return delete;
  }
}
