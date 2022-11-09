import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:tswiri_database_interface/functions/isar/delete_functions.dart';
import 'package:tswiri_database_interface/models/image_data/image_data.dart';
import 'package:tswiri_database_interface/widgets/tag_texts_search/tag_texts_search.dart';

import '../../ml_kit/photo_labeling/ml_photo_labeling_camera_view.dart';

class ContainerView extends StatefulWidget {
  const ContainerView({
    Key? key,
    required this.catalogedContainer,
  }) : super(key: key);
  final CatalogedContainer catalogedContainer;
  @override
  State<ContainerView> createState() => ContainerViewState();
}

class ContainerViewState extends State<ContainerView> {
  final GlobalKey<TagTextSearchState> _tagTextPredictorKey = GlobalKey();

  late final CatalogedContainer _container = widget.catalogedContainer;

  late final ContainerRelationship? _containerRelationship = isar!
      .containerRelationships
      .filter()
      .containerUIDMatches(_container.containerUID)
      .findFirstSync();

  late List<ContainerTag> assignedTags = isar!.containerTags
      .filter()
      .containerUIDMatches(_container.containerUID)
      .findAllSync();

  late List<Photo> _containerPhotos = isar!.photos
      .filter()
      .containerUIDMatches(_container.containerUID)
      .findAllSync();

  TextEditingController _editController = TextEditingController();

  bool isAddingTag = false;

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
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 10,
      title: Text(_container.name ?? _container.containerUID),
      centerTitle: true,
      actions: [_delete()],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            _name(),
            _description(),
            _barcode(),
            _parent(),
            const Divider(),
            _tags(),
            const Divider(),
            _photos(),
          ],
        ),
      ),
    );
  }

  IconButton _delete() {
    return IconButton(
      onPressed: () {
        //TODO: Implement delete container.
      },
      icon: const Icon(Icons.delete_rounded),
    );
  }

  Visibility _name() {
    return Visibility(
      visible: !isAddingTag,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          initialValue: _container.name,
          onFieldSubmitted: (value) {
            try {
              isar!.writeTxnSync(
                () {
                  isar!.catalogedContainers.putSync(_container);
                  //TODO: add to changes table.
                  //extract to function.  
                },
              );
            } catch (e) {
              return;
            }

            setState(() {
              _container.name = value;
            });
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            label: Text('name'),
          ),
        ),
      ),
    );
  }

  Visibility _description() {
    return Visibility(
      visible: !isAddingTag,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          initialValue: _container.description,
          onFieldSubmitted: (value) {
            setState(() {
              _container.description = value;
            });

            isar!.writeTxnSync(
                () => isar!.catalogedContainers.putSync(_container));
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            label: Text('description'),
          ),
        ),
      ),
    );
  }

  Visibility _barcode() {
    return Visibility(
      visible: !isAddingTag,
      child: ListTile(
        title: const Text('Barcode:'),
        subtitle: Text(_container.barcodeUID!),
        trailing: IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.change_circle_rounded),
        ),
      ),
    );
  }

  Visibility _parent() {
    return Visibility(
      visible: !isAddingTag,
      child: ListTile(
        title: const Text('Parent:'),
        subtitle: Text(_containerRelationship?.parentUID ?? '-'),
        trailing: IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.change_circle_rounded),
        ),
      ),
    );
  }

  Padding _tags() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const ListTile(
            title: Text('Tags'),
            trailing: Icon(Icons.tag_rounded),
          ),
          Wrap(
            spacing: 4,
            children: [
              for (var e in assignedTags)
                InputChip(
                  label: Text(
                    isar!.tagTexts
                        .filter()
                        .idEqualTo(e.tagTextID)
                        .findFirstSync()!
                        .text,
                  ),
                  onDeleted: () {
                    isar!.writeTxnSync(
                        () => isar!.containerTags.deleteSync(e.id));

                    _updateAssignedTags();

                    ///Let the TagTextPredictor know this tag has been removed.
                    _tagTextPredictorKey.currentState
                        ?.updateAssignedTags(e.tagTextID);
                  },
                ),
              Visibility(
                visible: !isAddingTag,
                child: ActionChip(
                  label: const Text('+'),
                  onPressed: () {
                    setState(() {
                      isAddingTag = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tagTextSearch() {
    return TagTextSearch(
      key: _tagTextPredictorKey,
      excludedTags: assignedTags.map((e) => e.tagTextID).toList(),
      dismiss: () => setState(() {
        isAddingTag = false;
      }),
      onTagAdd: (tagTextID) {
        //Create New ContainerTag.
        ContainerTag newContainerTag = ContainerTag()
          ..containerUID = _container.containerUID
          ..tagTextID = tagTextID;

        //Write to isar.
        isar!.writeTxnSync(() => isar!.containerTags.putSync(newContainerTag));

        _updateAssignedTags();
      },
    );
  }

  ///Update the list of tags displayed.
  void _updateAssignedTags() {
    setState(() {
      assignedTags = isar!.containerTags
          .filter()
          .containerUIDMatches(_container.containerUID)
          .findAllSync();
    });
  }

  Visibility _photos() {
    return Visibility(
      visible: !isAddingTag,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text('Photos'),
              trailing: Icon(Icons.photo_rounded),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                children: [
                  Card(
                    elevation: 10,
                    child: ClipRRect(
                      child: SizedBox(
                        width: 150,
                        height: 250,
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              //Await ImageData.
                              ImageData? imageData =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MLPhotoLabelingCameraView(),
                                ),
                              );

                              if (imageData == null) return;
                              await imageData
                                  .savePhoto(_container.containerUID);

                              _updatePhotosDisplay();
                            },
                            icon: const Icon(Icons.add_rounded),
                          ),
                        ),
                      ),
                    ),
                  ),
                  for (var photo in _containerPhotos)
                    Card(
                      child: ClipRRect(
                        child: Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            Image.file(
                              width: 150,
                              height: 250,
                              File(photo.getPhotoThumbnailPath()),
                              fit: BoxFit.cover,
                            ),
                            Card(
                              color: Colors.black45,
                              child: IconButton(
                                onPressed: () {
                                  deletePhoto(photo);
                                  _updatePhotosDisplay();
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Updates the photos.
  void _updatePhotosDisplay() {
    setState(() {
      _containerPhotos = isar!.photos
          .filter()
          .containerUIDMatches(_container.containerUID)
          .findAllSync();

      log(_containerPhotos.length.toString());
      for (var photo in _containerPhotos) {
        log(photo.getPhotoThumbnailPath());
      }
    });
  }
}
