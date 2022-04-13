import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/keyboard_functions/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo_thumbnail/container_photo_thumbnail.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_generator/barcode_generator_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/new_container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';

import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

class ContainerManagerView extends StatefulWidget {
  const ContainerManagerView({Key? key}) : super(key: key);

  @override
  State<ContainerManagerView> createState() => _ContainerManagerViewState();
}

class _ContainerManagerViewState extends State<ContainerManagerView> {
  List<String> containerTypeList = ['area', 'shelf', 'drawer', 'box'];
  List<String> containerTypes = [];

  TextEditingController searchController = TextEditingController();

  bool showFilterOptions = false;
  bool showCheckBoxes = false;

  List<String> selectedContainers = [];
  List<ContainerEntry> searchResults = [];

  @override
  void initState() {
    containerTypes = isarDatabase!.containerTypes
        .where()
        .containerTypeProperty()
        .findAllSync();

    searchContainers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Containers',
              style: Theme.of(context).textTheme.titleMedium),
          centerTitle: true,
          elevation: 0,
          actions: [
            Builder(
              builder: (context) {
                if (showCheckBoxes) {
                  return deleteButton();
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  floatingAddButton(),
                ],
              ),
            ),
            floatingSearchBar(),
          ],
        ), //floatingAddButton(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                'hold to select',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            //ListView
            _listViewBuilder(),
          ],
        ),
      ),
    );
  }

  Widget floatingAddButton() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () async {
        int numberOfLinkedBarcodes = isarDatabase!.containerEntrys
            .where()
            .barcodeUIDProperty()
            .findAllSync()
            .length;

        int numberOfBarcodes =
            isarDatabase!.barcodePropertys.where().findAllSync().length;

        if (numberOfBarcodes == 0) {
          showAlertDialogNoBarcodesGenerated(context);
        } else if (numberOfBarcodes == numberOfLinkedBarcodes) {
          showAlertDialogNoUnlinkedbarcodes(context);
        }

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewContainerView()),
        );
        searchContainers();
        setState(() {});
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget floatingSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrange, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          color: const Color(0xFF232323)),
      child: Column(
        children: [
          _searchOptions(),
          const Divider(),
          _searchField(),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              searchContainers();
            },
            autofocus: false,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              suffixIcon: Icon(Icons.search),
              labelText: 'Search',
              labelStyle: TextStyle(fontSize: 18),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchOptions() {
    return Builder(
      builder: (context) {
        if (showFilterOptions) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Options: ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: containerTypes
                      .map((e) => containerTypeFilterWidget(e))
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Options',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const VerticalDivider(),
                    GestureDetector(
                      onTap: () {
                        showFilterOptions = false;
                        setState(() {});
                      },
                      child: const OrangeOutlineContainer(
                        padding: 0,
                        margin: 0,
                        child: Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Options',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const VerticalDivider(),
              GestureDetector(
                onTap: () {
                  showFilterOptions = true;
                  setState(() {});
                },
                child: const OrangeOutlineContainer(
                  margin: 0,
                  padding: 0,
                  child: Icon(
                    Icons.arrow_drop_up_rounded,
                    size: 25,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _listViewBuilder() {
    return Builder(
      builder: ((context) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                ContainerEntry containerEntry = searchResults[index];
                //log(index.toString());
                if (index == searchResults.length - 1) {
                  //log('message');
                  return Column(
                    children: [
                      containerDisplayWidget(containerEntry),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                    ],
                  );
                } else {
                  return containerDisplayWidget(containerEntry);
                }
              },
            ),
          ),
        );
      }),
    );
  }

  void searchContainers() {
    bool enabled = false;
    if (searchController.text.isNotEmpty) {
      enabled = true;
    }
    // log(enabled.toString());
    // log(searchController.text);

    if (containerTypeList.isNotEmpty) {
      searchResults = isarDatabase!.containerEntrys
          .filter()
          .repeat(
            containerTypeList,
            (q, String element) => q.containerTypeMatches(
              element,
            ),
          )
          .and()
          .optional(
              enabled,
              (q) => q.group((q) => q
                  .containerUIDContains(searchController.text.toLowerCase(),
                      caseSensitive: false)
                  .or()
                  .nameContains(searchController.text.toLowerCase(),
                      caseSensitive: false)
                  .or()
                  .descriptionContains(searchController.text.toLowerCase(),
                      caseSensitive: false)))
          .findAllSync();
    } else {
      searchResults = [];
    }

    setState(() {});
  }

  Widget containerTypeFilterWidget(String containerType) {
    return Builder(
      builder: (context) {
        Color containerTypeColor = Color(int.parse(isarDatabase!.containerTypes
                .filter()
                .containerTypeMatches(containerType)
                .findFirstSync()!
                .containerColor))
            .withOpacity(1);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  containerType,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 30,
                  child: Checkbox(
                    activeColor: containerTypeColor,
                    fillColor: MaterialStateProperty.all(containerTypeColor),
                    value: containerTypeList.contains(containerType),
                    onChanged: (value) {
                      _onSelectedFilter(value!, containerType);
                      searchContainers();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            _optionDividerLight(),
          ],
        );
      },
    );
  }

  Widget _optionDividerLight() {
    return const Divider(
      height: 10,
      thickness: 1,
    );
  }

  void _onSelectedFilter(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        containerTypeList.add(dataName);
      });
    } else {
      setState(() {
        containerTypeList.remove(dataName);
      });
    }
  }

  void _onSelectedContainer(bool selected, String dataName) {
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

  Widget containerDisplayWidget(ContainerEntry containerEntry) {
    return Builder(
      builder: (context) {
        Color containerTypeColor =
            getContainerColor(containerUID: containerEntry.containerUID);
        return InkWell(
          onLongPress: () {
            showCheckBoxes = !showCheckBoxes;
            _onSelectedContainer(true, containerEntry.containerUID);
            setState(() {});
          },
          onTap: () async {
            if (!showCheckBoxes) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContainerView(
                    containerEntry: containerEntry,
                  ),
                ),
              );
              searchContainers();
              setState(() {});
            } else {
              if (selectedContainers.contains(containerEntry.containerUID)) {
                _onSelectedContainer(false, containerEntry.containerUID);
                if (selectedContainers.isEmpty) {
                  showCheckBoxes = false;
                }
              } else {
                _onSelectedContainer(true, containerEntry.containerUID);
              }
            }
          },
          child: LightContainer(
            margin: 2.5,
            padding: 2.5,
            child: CustomOutlineContainer(
              outlineColor: containerTypeColor,
              margin: 2.5,
              padding: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Container Name/UID',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        containerEntry.name ?? containerEntry.containerUID,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Divider(
                        height: 5,
                      ),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        containerEntry.description ?? '',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Divider(
                        height: 5,
                      ),
                      Text(
                        'BarcodeUID',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        containerEntry.barcodeUID ?? '',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  Builder(builder: (context) {
                    if (showCheckBoxes) {
                      return Checkbox(
                        activeColor: containerTypeColor,
                        fillColor:
                            MaterialStateProperty.all(containerTypeColor),
                        value: selectedContainers
                            .contains(containerEntry.containerUID),
                        onChanged: (value) {
                          _onSelectedContainer(
                              value!, containerEntry.containerUID);
                          if (selectedContainers.isEmpty) {
                            showCheckBoxes = false;
                          }
                          searchContainers();
                          setState(() {});
                        },
                      );
                    } else {
                      return Container();
                    }
                  })
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget deleteButton() {
    return IconButton(
      onPressed: () {
        List<Marker> markers = [];
        List<RealInterBarcodeVectorEntry> interBarcodeData = [];
        List<ContainerRelationship> containerRelationships = [];
        List<ContainerTag> containerTags = [];

        List<ContainerPhoto> containerPhotos = [];
        List<PhotoTag> photoTags = [];
        List<ContainerPhotoThumbnail> photoThumbnails = [];

        List<ContainerEntry> containerEntries = [];

        if (selectedContainers.isNotEmpty) {
          List<ContainerEntry> containersToDelete = isarDatabase!
              .containerEntrys
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
              interBarcodeData.addAll(isarDatabase!.realInterBarcodeVectorEntrys
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

            //Container Thumbnails
            photoThumbnails.addAll(isarDatabase!.containerPhotoThumbnails
                .filter()
                .repeat(
                    containerPhotos,
                    (q, ContainerPhoto element) =>
                        q.photoPathMatches(element.photoPath))
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

        //log(photoThumbnails.toString());

        //Delete marker. *
        //Delete realInterBarcodeData.*
        //Container Relationships.*
        //Delete Container Tags. *
        //Delete photo tags. *
        //Delete photo Thumbnail and Photo. * - delete physical photo
        //Delete Container Photos and Photo.* - delete physical photo
        //Delete Container Entry.

        //Delete on device Photos
        for (ContainerPhoto containerPhoto in containerPhotos) {
          if (File(containerPhoto.photoPath).existsSync()) {
            File(containerPhoto.photoPath).deleteSync();
          }
        }

        //Delete on device photo Thumbnails
        for (ContainerPhotoThumbnail thumbnail in photoThumbnails) {
          if (File(thumbnail.thumbnailPhotoPath).existsSync()) {
            File(thumbnail.thumbnailPhotoPath).deleteSync();
          }
        }

        isarDatabase!.writeTxnSync((isar) {
          isar.markers
              .filter()
              .repeat(
                  markers,
                  (q, Marker element) =>
                      q.barcodeUIDMatches(element.barcodeUID))
              .deleteFirstSync();
          isar.realInterBarcodeVectorEntrys
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
          isar.containerPhotoThumbnails
              .filter()
              .repeat(
                  photoThumbnails,
                  (q, ContainerPhotoThumbnail element) =>
                      q.thumbnailPhotoPathMatches(element.thumbnailPhotoPath))
              .deleteAllSync();
          isar.photoTags
              .filter()
              .repeat(
                  photoTags,
                  (q, PhotoTag element) =>
                      q.photoPathMatches(element.photoPath))
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
        searchContainers();
        setState(() {});
      },
      icon: const Icon(Icons.delete),
    );
  }

  showAlertDialogNoBarcodesGenerated(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext alertDialogContext) {
        return AlertDialog(
          title: Text(
            "No Barcodes",
            style: Theme.of(alertDialogContext).textTheme.labelLarge,
          ),
          content: Text(
            "You dont have any Barcodes Generate some.",
            style: Theme.of(alertDialogContext).textTheme.labelSmall,
          ),
          actions: [
            OrangeOutlineContainer(
              padding: 0,
              margin: 0,
              child: TextButton(
                child: Text(
                  "Generate Barcodes",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onPressed: () async {
                  Navigator.pop(alertDialogContext);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BarcodeGeneratorView()),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  showAlertDialogNoUnlinkedbarcodes(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext alertDialogContext) {
        return AlertDialog(
          title: Text(
            "No Unlinked Barcodes",
            style: Theme.of(alertDialogContext).textTheme.labelLarge,
          ),
          content: Text(
            "You dont have any Barcodes left to scan Generate some more.",
            style: Theme.of(alertDialogContext).textTheme.labelSmall,
          ),
          actions: [
            OrangeOutlineContainer(
              padding: 0,
              margin: 0,
              child: TextButton(
                child: Text(
                  "Generate Barcodes",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onPressed: () async {
                  Navigator.pop(alertDialogContext);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BarcodeGeneratorView()),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
