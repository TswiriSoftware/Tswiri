import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/functions/change_functions.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/classes/image_data.dart';
import 'package:sunbird/views/ml_kit_views/barcode_scanner/single_scanner_view.dart';
import 'package:sunbird/views/containers/container_view/photo_labeling/ml_photo_labeling_camera_view.dart';
import 'package:sunbird/views/ml_kit_views/navigator/navigator_view.dart';
import 'package:sunbird/views/utilities/grids/grid/grid_viewer_view.dart';
import 'package:sunbird/views/utilities/grids/new_grid/new_grid_view.dart';
import 'package:sunbird/widgets/photo/photo_edit_view.dart';
import 'package:sunbird/widgets/tag_text_search_field/tag_text_predictor.dart';
import 'package:sunbird/widgets/text_field/custom_text_field.dart';

import '../new_container_view/new_container_view.dart';

class ContainerView extends StatefulWidget {
  const ContainerView({
    Key? key,
    required this.catalogedContainer,
    this.tagsExpanded,
    this.photosExpaned,
    this.childrenExpanded,
    this.parentExpaned,
  }) : super(key: key);
  final CatalogedContainer catalogedContainer;
  final bool? tagsExpanded;
  final bool? photosExpaned;
  final bool? childrenExpanded;
  final bool? parentExpaned;
  @override
  State<ContainerView> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerView> {
  late final CatalogedContainer _catalogedContainer = widget.catalogedContainer;

  final GlobalKey<TagTextPredictorState> _tagTextPredictorKey = GlobalKey();
  final GlobalKey<PhotoEditViewState> _photoEditViewKey = GlobalKey();

  late List<ContainerTag> assignedTags = isar!.containerTags
      .filter()
      .containerUIDMatches(_catalogedContainer.containerUID)
      .findAllSync();

  late List<Photo> _photos = isar!.photos
      .filter()
      .containerUIDMatches(_catalogedContainer.containerUID)
      .findAllSync();

  late final ContainerType _containerType =
      isar!.containerTypes.getSync(_catalogedContainer.containerTypeID)!;

  late Color containerColor = _containerType.containerColor;

  late List<ContainerRelationship> containerRelationships = isar!
      .containerRelationships
      .filter()
      .parentUIDMatches(_catalogedContainer.containerUID)
      .findAllSync();

  late ContainerRelationship? containerRelationship = isar!
      .containerRelationships
      .filter()
      .containerUIDMatches(_catalogedContainer.containerUID)
      .findFirstSync();

  bool isAddingTag = false;
  bool isEditingPhoto = false;
  Photo? _photo;

  late bool? tagsExpanded = widget.tagsExpanded ?? false;
  late bool? photosExpaned = widget.photosExpaned ?? false;
  late bool? childrenExpanded = widget.childrenExpanded ?? false;
  late bool? parentExpanded = widget.parentExpaned ?? false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomSheet: isAddingTag ? _tagTextSearch() : const SizedBox.shrink(),
      resizeToAvoidBottomInset: true,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        _catalogedContainer.name ?? _catalogedContainer.containerUID,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      actions: [
        isEditingPhoto ? _cancelPhotoEdit() : _findButton(),
      ],
    );
  }

  Widget _findButton() {
    return TextButton(
      onPressed: () {
        CatalogedCoordinate? catalogedCoordiante = isar!.catalogedCoordinates
            .filter()
            .barcodeUIDMatches(_catalogedContainer.barcodeUID!)
            .findFirstSync();

        if (catalogedCoordiante != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NavigatorView(
                  catalogedContainer: _catalogedContainer,
                  gridUID: catalogedCoordiante.gridUID),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Cannot find container',
                  ),
                  TextButton(
                      onPressed: () {
                        //TODO: implement help screen.
                      },
                      child: const Text(
                        'Help',
                        style: TextStyle(color: sunbirdOrange, fontSize: 16),
                      ))
                ],
              ),
            ),
          );
        }
      },
      child: Row(
        children: const [
          Text('Find '),
          Icon(
            Icons.location_searching,
          ),
        ],
      ),
    );
  }

  Widget _cancelPhotoEdit() {
    return IconButton(
      onPressed: () {
        setState(() {
          isEditingPhoto = false;
          _photo = null;
        });
      },
      icon: const Icon(Icons.close_sharp),
    );
  }

  Widget _body() {
    return isEditingPhoto ? _photoEdit() : _containerEdit();
  }

  Widget _containerEdit() {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            _nameTextField(),
            _descriptionTextField(),
            _parentCard(),
            _tagsCard(),
            _photosCard(),
            _containerChildren(),
            _gridCard(),
          ],
        ),
      ),
    );
  }

  Widget _photoEdit() {
    return PhotoEditView(
      key: _photoEditViewKey,
      photo: _photo!,
      onLeft: () {
        setState(() {
          int index = _photos.indexWhere((element) => element == _photo);
          if (index == 0) {
            index = _photos.length - 1;
          } else {
            index = index - 1;
          }
          _photo = _photos[index];
          _photoEditViewKey.currentState?.updatePhoto(_photo!);
        });
      },
      onRight: () {
        setState(() {
          int index = _photos.indexWhere((element) => element == _photo);
          if (index == _photos.length - 1) {
            index = 0;
          } else {
            index = index + 1;
          }
          _photo = _photos[index];
          _photoEditViewKey.currentState?.updatePhoto(_photo!);
        });
      },
      navigationEnabeld: _photos.length > 1,
    );
  }

  Widget _tagTextSearch() {
    return TagTextPredictor(
      key: _tagTextPredictorKey,
      excludedTags: assignedTags.map((e) => e.tagTextID).toList(),
      dismiss: () => setState(() {
        isAddingTag = false;
      }),
      onTagAdd: (tagTextID) {
        //Create New ContainerTag.
        ContainerTag newContainerTag = ContainerTag()
          ..containerUID = _catalogedContainer.containerUID
          ..tagTextID = tagTextID;

        //Write to isar.
        isar!.writeTxnSync(
            (isar) => isar.containerTags.putSync(newContainerTag));

        _updateTagsDisplay();
      },
    );
  }

  Widget _nameTextField() {
    return CustomTextField(
      label: 'name',
      initialValue: _catalogedContainer.name,
      onSubmitted: (value) {
        isar!.writeTxnSync((isar) {
          _catalogedContainer.name = value;
          isar.catalogedContainers
              .putSync(_catalogedContainer, replaceOnConflict: true);
        });
      },
    );
  }

  Widget _descriptionTextField() {
    return CustomTextField(
      label: 'Description',
      initialValue: _catalogedContainer.description,
      onSubmitted: (value) {
        isar!.writeTxnSync((isar) {
          _catalogedContainer.description = value;
          isar.catalogedContainers
              .putSync(_catalogedContainer, replaceOnConflict: true);
        });
      },
    );
  }

  Widget _parentCard() {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: parentExpanded ?? false,
        title: Text(
          'Parent',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        onExpansionChanged: (value) {
          setState(() {
            parentExpanded = value;
          });
        },
        children: [
          containerRelationship != null
              ? Card(
                  color: background[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          containerRelationship!.parentUID!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            //TODO: implement parent change screen.

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ChangeParentView(
                            //       containerRelationship: containerRelationship!,
                            //     ),
                            //   ),
                            // );

                            String? barcodeUID = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SingleBarcodeScannerView(),
                              ),
                            );

                            if (barcodeUID != null) {
                              CatalogedContainer? catalogedContainer = isar!
                                  .catalogedContainers
                                  .filter()
                                  .barcodeUIDMatches(barcodeUID)
                                  .findFirstSync();

                              if (catalogedContainer != null &&
                                  barcodeUID !=
                                      _catalogedContainer.barcodeUID) {
                                bool hasChangedParent = changeParent(
                                  currentContainer: _catalogedContainer,
                                  parentContainer: catalogedContainer,
                                );

                                if (hasChangedParent == true) {
                                  setState(() {
                                    containerRelationship = isar!
                                        .containerRelationships
                                        .filter()
                                        .containerUIDMatches(
                                            _catalogedContainer.containerUID)
                                        .findFirstSync();
                                  });
                                } else {
                                  //TODO: throw error.
                                }
                              }
                            }
                          },
                          child: Text(
                            'Change',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {},
                      child: Text(
                        'Scan Parent',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _tagsCard() {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: tagsExpanded ?? false,
        title: Text(
          'Tags',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        onExpansionChanged: (value) {
          setState(() {
            tagsExpanded = value;
          });
        },
        children: [
          Wrap(
            spacing: 4,
            children: [
              for (var e in assignedTags) _containerTagChip(e),
              ActionChip(
                label: Text(
                  '+',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                backgroundColor:
                    colorModeEnabled ? containerColor : sunbirdOrange,
                onPressed: () {
                  setState(() {
                    isAddingTag = true;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _containerTagChip(ContainerTag containerTag) {
    return Chip(
      label: Text(
        isar!.tagTexts.getSync(containerTag.tagTextID)?.text ?? 'err',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      deleteIcon: const Icon(
        Icons.close_sharp,
        size: 20,
      ),
      onDeleted: () {
        ///Remove the tag from the database.
        isar!.writeTxnSync(
            (isar) => isar.containerTags.deleteSync(containerTag.id));

        _updateTagsDisplay();

        ///Let the TagTextPredictor know this tag has been removed.
        _tagTextPredictorKey.currentState
            ?.updateAssignedTags(containerTag.tagTextID);
      },
    );
  }

  Widget _photosCard() {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: photosExpaned ?? false,
        onExpansionChanged: (value) {
          setState(() {
            photosExpaned = value;
          });
        },
        backgroundColor: null,
        title: Text(
          'Photos',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        children: [
          const Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              children: [
                _newPhotoCard(),
                for (var photo in _photos) _photoCard(photo),
              ],
            ),
          ),
          // const Divider(),
        ],
      ),
    );
  }

  Widget _newPhotoCard() {
    return InkWell(
      onTap: () async {
        //Await ImageData.
        ImageData? imageData = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MLPhotoLabelingCameraView(),
          ),
        );

        if (imageData != null) {
          //Create Imaiage *for the brave*
          await imageData.savePhoto(_catalogedContainer.containerUID);
          _updatePhotosDisplay();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: colorModeEnabled ? containerColor : sunbirdOrange,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        color: background[300],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: 150,
            height: 250,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_sharp),
                Text(
                  '(add photo)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget _photoCard(Photo photo) {
    return InkWell(
      onTap: () {
        setState(() {
          _photo = photo;
          isEditingPhoto = true;
        });
      },
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image.file(
                width: 150,
                height: 250,
                File(photo.getPhotoPath()),
                fit: BoxFit.cover,
              ),
              Card(
                color: background[300]!.withAlpha(150),
                child: IconButton(
                  onPressed: () {
                    deletePhoto(photo);
                    _updatePhotosDisplay();
                  },
                  icon: const Icon(Icons.delete),
                  color: sunbirdOrange,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerChildren() {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: childrenExpanded ?? false,
        onExpansionChanged: (value) {
          setState(() {
            childrenExpanded = value;
          });
        },
        title: Text(
          'Children',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        children: [
          _newContainerButton(),
          for (ContainerRelationship e in containerRelationships)
            _childContainerCard(e),
        ],
      ),
    );
  }

  Widget _newContainerButton() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewContainerView(
              parentContainerUID: _catalogedContainer,
              preferredContainerType: isar!.containerTypes
                  .getSync(_containerType.preferredChildContainer),
            ),
          ),
        );
        _updateChildrenContainers();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: sunbirdOrange,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        color: background[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '+',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '(New Container)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _childContainerCard(ContainerRelationship relationship) {
    //Container Entry
    CatalogedContainer catalogedContainer = isar!.catalogedContainers
        .filter()
        .containerUIDMatches(relationship.containerUID)
        .findFirstSync()!;

    return Card(
      color: background[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              catalogedContainer.name ?? catalogedContainer.containerUID,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ContainerView(
                      catalogedContainer: catalogedContainer,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit_sharp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridCard() {
    return Card(
      child: ExpansionTile(
        title: Text(
          'Grid',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        children: [
          ElevatedButton(
            onPressed: () {
              CatalogedCoordinate? catalogedCoordiante = isar!
                  .catalogedCoordinates
                  .filter()
                  .barcodeUIDMatches(_catalogedContainer.barcodeUID!)
                  .findFirstSync();

              if (catalogedCoordiante != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GirdViewer(
                      gridUID: catalogedCoordiante.gridUID,
                    ),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewGridView(
                      originBarcodeUID: _catalogedContainer.barcodeUID,
                    ),
                  ),
                );
              }
            },
            child: Text(
              'Grid View',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  ///Update the list of tags displayed.
  void _updateTagsDisplay() {
    setState(() {
      assignedTags = isar!.containerTags
          .filter()
          .containerUIDMatches(_catalogedContainer.containerUID)
          .findAllSync();
    });
  }

  ///Updates the photos.
  void _updatePhotosDisplay() {
    setState(() {
      _photos = isar!.photos
          .filter()
          .containerUIDMatches(_catalogedContainer.containerUID)
          .findAllSync();
    });
  }

  ///Updates children.
  void _updateChildrenContainers() {
    setState(() {
      containerRelationships = isar!.containerRelationships
          .filter()
          .parentUIDMatches(_catalogedContainer.containerUID)
          .findAllSync();
    });
  }
}
