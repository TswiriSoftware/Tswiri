import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/photo_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/grid_manager/container_grid_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/new_container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/photo_tagging/object_detector_view.dart';
import 'package:isar/isar.dart';

class ContainerView extends StatefulWidget {
  const ContainerView({Key? key, required this.containerEntry})
      : super(key: key);
  final ContainerEntry containerEntry;

  @override
  State<ContainerView> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerView> {
  late final ContainerEntry _containerEntry = widget.containerEntry;
  late final Color _containerColor =
      getContainerColor(containerUID: _containerEntry.containerUID);

  //Scroll View
  final ScrollController _scrollController = PageController();

  //Name.
  TextEditingController nameController = TextEditingController();

  final _nameNode = FocusNode();
  bool nameIsFocused = false;

  //Description.
  TextEditingController descriptionController = TextEditingController();
  final _descriptionNode = FocusNode();
  bool descriptionIsFocused = false;

  //Tags
  TextEditingController tagsController = TextEditingController();
  final _tagsNode = FocusNode();
  bool showTagEditor = false;
  late GlobalObjectKey tagsKey =
      GlobalObjectKey('${widget.containerEntry.containerUID}_tags');

  List<int> assignedTagIDs = [];
  List<int> allTags = [];

  @override
  void initState() {
    nameController.text = _containerEntry.name ?? '';
    descriptionController.text = _containerEntry.description ?? '';

    updateTags();

    addListeners();

    super.initState();
  }

  @override
  void dispose() {
    closeListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomSheet: _bottomSheet(),
    );
  }

  ///APP BAR///

  AppBar _appBar() {
    return AppBar(
      backgroundColor: _containerColor,
      elevation: 25,
      centerTitle: true,
      title: _title(),
      shadowColor: Colors.black54,
    );
  }

  Text _title() {
    return Text(
      _containerEntry.name ?? _containerEntry.containerUID,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  ///BODY///
  Widget _body() {
    return GestureDetector(
      onTap: () {
        _nameNode.unfocus();
        _descriptionNode.unfocus();
        _tagsNode.unfocus();
      },
      child: ListView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.25),
        controller: _scrollController,
        children: [
          //Container info.
          _info(),

          //Container children.
          _children(),

          //Tags
          _tags(),

          //Photos
          _photos(),

          //Photo Tags
          _photoTags(),

          const SizedBox(
            height: 500,
          ),
        ],
      ),
    );
  }

  ///CONTAINER INFO///
  Widget _info() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _containerColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoHeading(),
            _dividerHeading(),
            _name(),
            _divider(),
            _description(),
            _divider(),
            _infoToolTip(),
          ],
        ),
      ),
    );
  }

  Widget _infoHeading() {
    return Text('Info', style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _name() {
    return InkWell(
      onTap: () {
        setState(() {
          nameIsFocused = !nameIsFocused;
          if (nameIsFocused) {
            _nameNode.requestFocus();
          }
        });
      },
      child: Builder(builder: (context) {
        if (nameIsFocused) {
          return _nameEdit();
        } else {
          return Row(
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
                    _containerEntry.name ?? _containerEntry.containerUID,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    nameIsFocused = !nameIsFocused;
                    _nameNode.requestFocus();
                  });
                },
                icon: const Icon(Icons.edit),
                iconSize: 15,
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _description() {
    return InkWell(
      onTap: () {
        setState(() {
          descriptionIsFocused = !descriptionIsFocused;
          if (descriptionIsFocused) {
            _descriptionNode.requestFocus();
          }
        });
      },
      child: Builder(builder: (context) {
        if (descriptionIsFocused) {
          return _descriptionEdit();
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    _containerEntry.description ?? '-',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    descriptionIsFocused = !descriptionIsFocused;
                    _descriptionNode.requestFocus();
                  });
                },
                icon: const Icon(Icons.edit),
                iconSize: 15,
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _nameEdit() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: nameController,
        focusNode: _nameNode,
        onSubmitted: (value) {
          saveName(value);
        },
        style: const TextStyle(fontSize: 18),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Name',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          suffixIcon: IconButton(
            onPressed: () {
              saveName(nameController.text);
            },
            icon: const Icon(Icons.save),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: _containerColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _containerColor)),
        ),
      ),
    );
  }

  Widget _descriptionEdit() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: descriptionController,
        focusNode: _descriptionNode,
        onSubmitted: (value) {
          saveDescription(value);
        },
        style: const TextStyle(fontSize: 18),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Description',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          suffixIcon: IconButton(
            onPressed: () {
              saveDescription(descriptionController.text);
              _descriptionNode.unfocus();
            },
            icon: const Icon(Icons.save),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: _containerColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _containerColor)),
        ),
      ),
    );
  }

  Widget _infoToolTip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('tap to edit', style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }

  void saveName(String value) {
    if (value.isNotEmpty) {
      _nameNode.unfocus();
      _containerEntry.name = value;
    } else {
      nameController.text =
          _containerEntry.name ?? _containerEntry.containerUID;
    }
    isarDatabase!
        .writeTxnSync((isar) => isar.containerEntrys.putSync(_containerEntry));
  }

  void saveDescription(String value) {
    if (value.isNotEmpty) {
      _descriptionNode.unfocus();
      _containerEntry.description = value;
    } else {
      descriptionController.text = _containerEntry.description ?? '';
      _containerEntry.description = null;
    }
    isarDatabase!
        .writeTxnSync((isar) => isar.containerEntrys.putSync(_containerEntry));
  }

  ///CHILDREN///

  Widget _children() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _containerColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _childrenHeading(),
            _dividerHeading(),
            _childrenListView(),
            _divider(),
            _childrenActions(),
          ],
        ),
      ),
    );
  }

  Widget _childrenHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Contains', style: Theme.of(context).textTheme.headlineSmall),
        _gridButton()
      ],
    );
  }

  Widget _gridButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_containerColor)),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContainerGridView(
                containerEntry: _containerEntry,
                containerTypeColor: _containerColor),
          ),
        );
        setState(() {});
      },
      child: Row(
        children: [
          Text('Grid ', style: Theme.of(context).textTheme.bodyMedium),
          const Icon(
            Icons.grid_4x4,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _childrenListView() {
    return Builder(builder: (context) {
      List<ContainerRelationship> relationships = [];
      relationships.addAll(isarDatabase!.containerRelationships
          .filter()
          .parentUIDMatches(_containerEntry.containerUID)
          .findAllSync());

      if (relationships.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: relationships.length,
          itemBuilder: (context, index) {
            return _childCard(relationships[index]);
          },
        );
      } else {
        return const Text('-');
      }
    });
  }

  Widget _childCard(ContainerRelationship containerRelationship) {
    return Builder(builder: (context) {
      ContainerEntry containerEntry =
          getContainerEntry(containerUID: containerRelationship.containerUID);

      Color containerColor =
          getContainerColor(containerUID: containerRelationship.containerUID);

      return Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: containerColor, width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  containerEntry.name ?? containerRelationship.containerUID,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContainerView(
                                containerEntry: containerEntry,
                              )),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _childrenActions() {
    return Row(
      children: [
        _multipleContainers(),
        _newContainer(),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  ElevatedButton _newContainer() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_containerColor)),
      onLongPress: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewContainerView(
              parentContainer: _containerEntry,
            ),
          ),
        );
        setState(() {});
      },
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewContainerView(
              parentContainer: _containerEntry,
            ),
          ),
        );
        setState(() {});
      },
      child: Row(
        children: [
          Text(
            'New',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Icon(Icons.add),
        ],
      ),
    );
  }

  ElevatedButton _multipleContainers() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_containerColor)),
      onPressed: () async {
        //TODO: implement multiple scan.
      },
      child: Row(
        children: [
          Text(
            'Scan',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Icon(Icons.add),
        ],
      ),
    );
  }

  ///TAGS///

  Widget _tags() {
    return Card(
      key: tagsKey,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _containerColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tagsHeading(),
            _dividerHeading(),
            _tagsWrap(),
          ],
        ),
      ),
    );
  }

  Widget _tagsHeading() {
    return Text('Tags', style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _tagsWrap() {
    return Builder(builder: (context) {
      List<Widget> tags = [
        addTag(),
      ];

      tags.addAll(assignedTagIDs.map((e) => tag(e)).toList());

      return Wrap(
        runSpacing: 2.5,
        spacing: 2.5,
        children: tags,
      );
    });
  }

  Widget addTag() {
    return Visibility(
      visible: !showTagEditor,
      child: InputChip(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _containerColor, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          setState(() {
            Scrollable.ensureVisible(tagsKey.currentContext!);
            _tagsNode.requestFocus();
            showTagEditor = !showTagEditor;
          });
        },
        label: const Text('+'),
      ),
    );
  }

  Widget _bottomSheet() {
    return Visibility(
      visible: showTagEditor,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _containerColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Tags',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            _tagSelector(),
            _divider(),
            _tagTextField(),
          ],
        ),
      ),
    );
  }

  Widget _tagSelector() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      scrollDirection: Axis.horizontal,
      child: Builder(builder: (context) {
        List<int> displayTags = [];

        if (tagsController.text.isNotEmpty) {
          displayTags.addAll(isarDatabase!.tagTexts
              .filter()
              .textContains(tagsController.text.toLowerCase(),
                  caseSensitive: false)
              .findAllSync()
              .map((e) => e.id)
              .where((element) => !assignedTagIDs.contains(element)));
        } else {
          displayTags.addAll(isarDatabase!.tagTexts
              .filter()
              .textContains(tagsController.text.toLowerCase(),
                  caseSensitive: false)
              .findAllSync()
              .map((e) => e.id)
              .where((element) => !assignedTagIDs.contains(element))
              .take(10));
        }

        return Wrap(
          spacing: 5,
          children: displayTags.map((e) => tag(e)).toList(),
        );
      }),
    );
  }

  Widget _tagTextField() {
    return TextField(
      controller: tagsController,
      focusNode: _tagsNode,
      onChanged: (value) {
        setState(() {});
      },
      onSubmitted: (value) {
        if (tagsController.text.isEmpty) {
          tagsController.clear();
          _tagsNode.unfocus();
        } else {
          _addNewTag();
        }
      },
      style: const TextStyle(fontSize: 18),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white10,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: 'Tag',
        labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
        suffixIcon: IconButton(
          onPressed: () {
            _addNewTag();
          },
          icon: const Icon(Icons.add),
        ),
        border:
            OutlineInputBorder(borderSide: BorderSide(color: _containerColor)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: _containerColor)),
      ),
    );
  }

  void _addNewTag() {
    TagText? tag = isarDatabase!.tagTexts
        .filter()
        .textMatches(tagsController.text.trim(), caseSensitive: false)
        .findFirstSync();

    if (tag != null) {
      //Add Existing Tag.
      isarDatabase!
          .writeTxnSync((isar) => isar.containerTags.putSync(ContainerTag()
            ..containerUID = _containerEntry.id
            ..textID = tag.id));
    } else {
      //log('new tag');
      //New Tag.
      TagText newTag = TagText()
        ..text = tagsController.text.toLowerCase().trim();
      isarDatabase!.writeTxnSync(
        (isar) => isar.tagTexts.putSync(newTag),
      );
      //New Container Tag.
      isarDatabase!
          .writeTxnSync((isar) => isar.containerTags.putSync(ContainerTag()
            ..containerUID = _containerEntry.id
            ..textID = newTag.id));
    }
    updateTags();
    setState(() {});
    tagsController.clear();
    _tagsNode.requestFocus();
  }

  Widget tag(int tagID) {
    return Builder(builder: (context) {
      TagText tag = isarDatabase!.tagTexts.getSync(tagID)!;
      return ActionChip(
        backgroundColor: _containerColor,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tag.text + ' ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Icon(
              assignedTagIDs.contains(tagID) ? Icons.close : Icons.add,
              size: 12.5,
            ),
          ],
        ),
        onPressed: () {
          if (assignedTagIDs.contains(tagID)) {
            isarDatabase!.writeTxnSync((isar) => isar.containerTags
                .filter()
                .textIDEqualTo(tagID)
                .deleteFirstSync());
            updateTags();
            setState(() {});
          } else {
            isarDatabase!.writeTxnSync(
                (isar) => isar.containerTags.putSync(ContainerTag()
                  ..containerUID = _containerEntry.id
                  ..textID = tagID));
            updateTags();
            tagsController.clear();
            setState(() {});
          }
        },
      );
    });
  }

  void updateTags() {
    assignedTagIDs = [];

    assignedTagIDs.addAll(isarDatabase!.containerTags
        .filter()
        .containerUIDEqualTo(_containerEntry.id)
        .textIDProperty()
        .findAllSync());

    allTags =
        isarDatabase!.tagTexts.where().findAllSync().map((e) => e.id).toList();
  }

  ///PHOTOS///

  Widget _photos() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _containerColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Photos', style: Theme.of(context).textTheme.headlineSmall),
            _dividerHeading(),
            _photosBuilder(),
            //_photoAddCard(),
          ],
        ),
      ),
    );
  }

  Widget _photosBuilder() {
    return Builder(
      builder: (context) {
        List<Photo> containerPhotos = [];
        containerPhotos.addAll(isarDatabase!.photos
            .filter()
            .containerIDEqualTo(_containerEntry.id)
            .findAllSync());

        List<Widget> photoWidgets = [
          _photoAddCard(),
        ];

        photoWidgets.addAll(containerPhotos.map((e) => photoCard(e)).toList());
        return Wrap(
          spacing: 1,
          runSpacing: 1,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: photoWidgets,
        );
      },
    );
  }

  Widget photoCard(Photo photo) {
    return Card(
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoView(
                photo: photo,
                color: _containerColor,
              ),
            ),
          );
          setState(() {});
        },
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.27,
              height: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                border: Border.all(color: _containerColor, width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              padding: const EdgeInsets.all(2.5),
              child: Image.file(
                File(photo.photoPath),
                fit: BoxFit.cover,
              ),
            ),
            photoDeleteButton(photo),
          ],
        ),
      ),
    );
  }

  Widget photoDeleteButton(Photo containerPhoto) {
    return Container(
      width: 35,
      height: 35,
      margin: const EdgeInsets.all(2.5),
      padding: const EdgeInsets.all(0),
      child: Center(
        child: IconButton(
          padding: const EdgeInsets.all(1),
          iconSize: 15,
          onPressed: () {
            deletePhoto(containerPhoto);
            setState(() {});
          },
          icon: const Icon(Icons.delete),
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: _containerColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          color: _containerColor.withOpacity(0.5)),
    );
  }

  Widget _photoAddCard() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ObjectDetectorView(
              customColor: _containerColor,
              containerID: _containerEntry.id,
            ),
          ),
        );

        setState(() {});
      },
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.27,
          height: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            border: Border.all(color: _containerColor, width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Center(
            child: Text(
              '+',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }

  void deletePhoto(Photo containerPhoto) {
    //Delete Photo.
    File(containerPhoto.photoPath).delete();

    //Delete Photo Thumbnail.
    File(containerPhoto.thumbnailPath).delete();

    //Delete References from database.
    isarDatabase!.writeTxnSync((isar) {
      isar.photos
          .filter()
          .photoPathMatches(containerPhoto.photoPath)
          .deleteFirstSync();

      isar.photos
          .filter()
          .photoPathMatches(containerPhoto.photoPath)
          .deleteAllSync();
    });
  }

  ///PHOTO TAGS///

  Widget _photoTags() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _containerColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AI Tags', style: Theme.of(context).textTheme.headlineSmall),
            _dividerHeading(),
            //_photoTagsBuilder(),
          ],
        ),
      ),
    );
  }

  // Widget _photoTagsBuilder() {
  //   return Builder(builder: (context) {
  //     List<MlTag> mlTags = [];
  //     List<PhotoTag> photoTags = [];

  //     List<ContainerPhoto> containerPhotos = isarDatabase!.containerPhotos
  //         .filter()
  //         .containerUIDMatches(_containerEntry.containerUID)
  //         .findAllSync();

  //     if (containerPhotos.isNotEmpty) {
  //       photoTags = isarDatabase!.photoTags
  //           .filter()
  //           .repeat(
  //               containerPhotos,
  //               (q, ContainerPhoto element) =>
  //                   q.photoPathMatches(element.photoPath))
  //           .findAllSync();

  //       if (photoTags.isNotEmpty) {
  //         mlTags = isarDatabase!.mlTags
  //             .filter()
  //             .repeat(photoTags,
  //                 (q, PhotoTag element) => q.idEqualTo(element.tagUID))
  //             .findAllSync();
  //       }
  //     }
  //     if (mlTags.isNotEmpty) {
  //       return Wrap(
  //         runSpacing: 2.5,
  //         spacing: 2.5,
  //         children: mlTags.map((e) => mlTag(e)).toList(),
  //       );
  //     } else {
  //       return Center(
  //         child: Text(
  //           'no tags',
  //           style: Theme.of(context).textTheme.bodySmall,
  //         ),
  //       );
  //     }
  //   });
  // }

  // Widget mlTag(MlTag mltag) {
  //   return Builder(builder: (context) {
  //     return Chip(
  //       avatar: Builder(builder: (context) {
  //         switch (mltag.tagType) {
  //           case mlTagType.text:
  //             return const Icon(
  //               Icons.format_size,
  //               size: 15,
  //             );

  //           case mlTagType.objectLabel:
  //             return const Icon(
  //               Icons.emoji_objects,
  //               size: 15,
  //             );

  //           case mlTagType.imageLabel:
  //             return const Icon(
  //               Icons.photo,
  //               size: 15,
  //             );
  //         }
  //       }),
  //       backgroundColor: _containerColor,
  //       label: Text(
  //         mltag.tag,
  //         style: Theme.of(context).textTheme.bodyMedium,
  //       ),
  //     );
  //   });
  // }

  ///MISC///

  Divider _divider() {
    return const Divider(
      height: 8,
      indent: 2,
      color: Colors.white30,
    );
  }

  Divider _dividerHeading() {
    return const Divider(
      height: 8,
      thickness: 1,
      color: Colors.white,
    );
  }

  ///LISTENERS///

  void addListeners() {
    _nameNode.addListener(() {
      setState(() {
        nameIsFocused = _nameNode.hasFocus;
      });
    });

    _descriptionNode.addListener(() {
      setState(() {
        descriptionIsFocused = _descriptionNode.hasFocus;
      });
    });

    _tagsNode.addListener(() {
      setState(() {
        showTagEditor = _tagsNode.hasFocus;
      });
    });
  }

  void closeListeners() {
    _nameNode.dispose();
    _descriptionNode.dispose();
    _tagsNode.dispose();
  }
}
