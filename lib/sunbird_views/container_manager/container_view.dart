import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo_thumbnail/container_photo_thumbnail.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/widgets/container_display_widget.dart';
import 'package:flutter_google_ml_kit/sunbird_views/photo_tagging/object_detector_image_processing.dart';
import 'package:flutter_google_ml_kit/sunbird_views/photo_tagging/object_detector_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';

import 'objects/photo_data.dart';

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
  TextEditingController tagController = TextEditingController();

  ContainerEntry? containerEntry;
  Color? containerTypeColor;

  bool isEditting = false;
  bool isShowingChildren = false;
  bool isShowingTagEditor = false;

  List<int> assignedTags = [];
  List<Tag> allTags = [];
  List<Tag> displayTags = [];

  @override
  void initState() {
    containerEntry = widget.containerEntry;

    containerTypeColor =
        getContainerColor(containerUID: containerEntry!.containerUID);

    nameController.text = containerEntry?.name ?? containerEntry!.containerUID;
    descriptionController.text = containerEntry?.description ?? '';

    assignedTags = isarDatabase!.containerTags
        .filter()
        .containerUIDMatches(containerEntry!.containerUID)
        .tagIDProperty()
        .findAllSync();

    allTags = isarDatabase!.tags.where().findAllSync();

    displayTags = allTags
        .where((element) =>
            !assignedTags.any((assignedTag) => assignedTag == element.id))
        .toList();

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
            _containsInfo(),
            //Tags
            containerTags(),
            //Photos
            photos(),
            //Photo Tags
            photoTags(),
          ],
        ),
      ),
    );
  }

  Widget photos() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
        margin: 2.5,
        padding: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Photos',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                photoActions(),
              ],
            ),
            Builder(
              builder: (context) {
                List<ContainerPhoto> containerPhotos = isarDatabase!
                    .containerPhotos
                    .filter()
                    .containerUIDMatches(containerEntry!.containerUID)
                    .findAllSync();

                return Wrap(
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 5,
                  runSpacing: 5,
                  children: containerPhotos.map((e) => photo(e)).toList(),
                );
              },
            ),
          ],
        ),
        outlineColor: containerTypeColor!,
      ),
    );
  }

  Widget photo(ContainerPhoto containerPhoto) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: CustomOutlineContainer(
            outlineColor: containerTypeColor!,
            padding: 2,
            child: Image.file(
              File(containerPhoto.photoPath),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            File(containerPhoto.photoPath).delete();
            isarDatabase!.writeTxnSync((isar) => isarDatabase!.containerPhotos
                .filter()
                .photoPathMatches(containerPhoto.photoPath)
                .deleteFirstSync());
            setState(() {});
          },
          icon: const Icon(Icons.delete),
          color: containerTypeColor,
        ),
      ],
    );
  }

  Widget photoActions() {
    return InkWell(
      onTap: () async {
        PhotoData? photoData = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ObjectDetectorView(),
          ),
        );

        if (photoData != null) {
          ContainerPhoto newContainerPhoto = ContainerPhoto()
            ..containerUID = containerEntry!.containerUID
            ..photoPath = photoData.photoPath;

          ContainerPhotoThumbnail newThumbnail = ContainerPhotoThumbnail()
            ..photoPath = photoData.photoPath
            ..thumbnailPhotoPath = photoData.thumbnailPhotoPath;

          List<PhotoTag> newPhotoTags = [];

          for (DetectedObject detectedObject in photoData.photoObjects) {
            List<Label> labels = detectedObject.getLabels();

            for (Label label in labels) {
              int mlTagID = isarDatabase!.mlTags
                  .filter()
                  .tagMatches(label.getText().toLowerCase())
                  .findFirstSync()!
                  .id;

              List<double> boundingBox = [
                detectedObject.getBoundinBox().left,
                detectedObject.getBoundinBox().top,
                detectedObject.getBoundinBox().right,
                detectedObject.getBoundinBox().bottom
              ];

              PhotoTag newPhotoTag = PhotoTag()
                ..photoPath = photoData.photoPath
                ..tagUID = mlTagID
                ..boundingBox = boundingBox
                ..confidence = label.getConfidence();

              newPhotoTags.add(newPhotoTag);
            }
          }

          for (ImageLabel imageLabel in photoData.photoLabels) {
            int mlTagID = isarDatabase!.mlTags
                .filter()
                .tagMatches(imageLabel.label.toLowerCase())
                .findFirstSync()!
                .id;

            PhotoTag newPhotoTag = PhotoTag()
              ..photoPath = photoData.photoPath
              ..tagUID = mlTagID
              ..boundingBox = null
              ..confidence = imageLabel.confidence;

            newPhotoTags.add(newPhotoTag);
          }

          isarDatabase!.writeTxnSync((isar) {
            isar.containerPhotos.putSync(newContainerPhoto);
            isar.containerPhotoThumbnails.putSync(newThumbnail);
            isar.photoTags.putAllSync(newPhotoTags);
          });
        }

        setState(() {});
      },
      child: CustomOutlineContainer(
        width: 80,
        height: 30,
        padding: 5,
        margin: 5,
        child: Center(
          child: Text(
            'add',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        outlineColor: containerTypeColor!,
      ),
    );
  }

  Widget photoTags() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
        margin: 2.5,
        padding: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Photo Tags',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Builder(
              builder: (context) {
                List<MlTag> mlTags = [];
                List<PhotoTag> photoTags = [];

                List<ContainerPhoto> containerPhotos = isarDatabase!
                    .containerPhotos
                    .filter()
                    .containerUIDMatches(containerEntry!.containerUID)
                    .findAllSync();

                if (containerPhotos.isNotEmpty) {
                  photoTags = isarDatabase!.photoTags
                      .filter()
                      .repeat(
                          containerPhotos,
                          (q, ContainerPhoto element) =>
                              q.photoPathMatches(element.photoPath))
                      .findAllSync();

                  if (photoTags.isNotEmpty) {
                    mlTags = isarDatabase!.mlTags
                        .filter()
                        .repeat(
                            photoTags,
                            (q, PhotoTag element) =>
                                q.idEqualTo(element.tagUID))
                        .findAllSync();
                  }
                }

                return Center(
                  child: Wrap(
                    children: mlTags.map((e) => photoTag(e)).toList(),
                  ),
                );
              },
            ),
          ],
        ),
        outlineColor: containerTypeColor!,
      ),
    );
  }

  Widget photoTag(MlTag mlTag) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: containerTypeColor!, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          color: Colors.black26),
      child: Text(
        mlTag.tag,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget containerTags() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
        outlineColor: containerTypeColor!,
        margin: 2.5,
        padding: 5,
        child: Builder(
          builder: (context) {
            if (isShowingTagEditor) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tags',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      tagSaveButton(),
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: assignedTags
                            .map((e) => containerTagWidget(e))
                            .toList(),
                      ),
                    ),
                  ),
                  const Divider(),
                  Builder(builder: (context) {
                    List<Tag> searchedTags = displayTags
                        .where((element) =>
                            element.tag.contains(tagController.text))
                        .toList();

                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: SingleChildScrollView(
                        child: Wrap(
                          children:
                              searchedTags.map((e) => tagWidget(e)).toList(),
                        ),
                      ),
                    );
                  }),
                  tagTextField(),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Container Tags',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      tagEditButton(),
                    ],
                  ),
                  const Divider(),
                  Builder(
                    builder: (context) {
                      //Get container tags

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: SingleChildScrollView(
                          child: Wrap(
                            children: assignedTags
                                .map((e) => containerTagWidget(e))
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget containerTagWidget(int tagID) {
    return Builder(builder: (context) {
      if (isarDatabase!.tags.filter().idEqualTo(tagID).findFirstSync() !=
          null) {
        return InkWell(
          onLongPress: (() {
            if (isShowingTagEditor) {
              assignedTags.removeWhere((element) => element == tagID);

              displayTags = allTags
                  .where((element) => !assignedTags
                      .any((assignedTag) => assignedTag == element.id))
                  .toList();

              setState(() {});
            }
          }),
          child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: containerTypeColor!, width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  color: Colors.black26),
              child: Builder(builder: (context) {
                return Text(
                  isarDatabase!.tags
                      .filter()
                      .idEqualTo(tagID)
                      .findFirstSync()!
                      .tag,
                  style: Theme.of(context).textTheme.bodyLarge,
                );
              })),
        );
      } else {
        return Container();
      }
    });
  }

  Widget tagWidget(Tag tag) {
    return InkWell(
      onTap: () {
        //TODO: Implement check if it is added already.

        if (!assignedTags.any((element) => element == tag.id)) {
          assignedTags.add(tag.id);

          displayTags = displayTags
              .where((element) =>
                  !assignedTags.any((assignedTag) => assignedTag == element.id))
              .toList();

          setState(() {});
        }
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: containerTypeColor!, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              color: Colors.black26),
          child: Text(
            tag.tag,
            style: Theme.of(context).textTheme.bodyLarge,
          )),
    );
  }

  Widget tagSaveButton() {
    return InkWell(
      onTap: () {
        isShowingTagEditor = !isShowingTagEditor;
        isarDatabase!.containerTags
            .filter()
            .containerUIDMatches(containerEntry!.containerUID)
            .findAllSync();

        isarDatabase!.writeTxnSync((isar) {
          isar.containerTags
              .filter()
              .containerUIDMatches(containerEntry!.containerUID)
              .deleteAllSync();
          for (var i = 0; i < assignedTags.length; i++) {
            isar.containerTags.putSync(ContainerTag()
              ..containerUID = containerEntry!.containerUID
              ..tagID = assignedTags[i]);
          }
        });
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
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
    );
  }

  Widget tagEditButton() {
    return InkWell(
      onTap: () {
        isShowingTagEditor = !isShowingTagEditor;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: CustomOutlineContainer(
          width: 80,
          height: 30,
          padding: 5,
          child: Center(
            child: Text(
              'Edit',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          outlineColor: containerTypeColor!,
        ),
      ),
    );
  }

  Widget tagTextField() {
    return OrangeOutlineContainer(
      margin: 5,
      padding: 8,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: tagController,
              onChanged: (value) {
                setState(() {});
              },
              style: const TextStyle(fontSize: 18),
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                labelText: 'Tag',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
          ),
          Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Tag? exists = isarDatabase!.tags
                      .filter()
                      .tagMatches(tagController.text.trim(),
                          caseSensitive: false)
                      .findFirstSync();

                  String inputValue = tagController.text;

                  if (exists == null && inputValue.isNotEmpty) {
                    //Remove white spaces
                    inputValue.trim();

                    Tag newTag = Tag()..tag = inputValue;
                    isarDatabase!.writeTxnSync(
                      (isar) => isar.tags.putSync(newTag),
                    );

                    displayTags = isarDatabase!.tags
                        .where()
                        .findAllSync()
                        .toList()
                        .where((element) => !assignedTags
                            .any((assignedTag) => assignedTag == element.id))
                        .toList();

                    tagController.text = '';
                    setState(() {});
                  }
                },
                child: OrangeOutlineContainer(
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _containsInfo() {
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

            if (isShowingChildren) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Contains',
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
                            'Contains',
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
        padding: 10,
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
