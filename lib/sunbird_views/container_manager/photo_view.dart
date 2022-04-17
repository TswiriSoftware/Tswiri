import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:isar/isar.dart';

class PhotoView extends StatefulWidget {
  const PhotoView(
      {Key? key, required this.containerPhoto, required this.containerColor})
      : super(key: key);
  final ContainerPhoto containerPhoto;
  final Color containerColor;
  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late final ContainerPhoto _containerPhoto = widget.containerPhoto;
  late final Color _containerColor = widget.containerColor;

  TextEditingController tagsController = TextEditingController();
  final _tagsNode = FocusNode();
  bool showTagEditor = false;

  List<PhotoTag> photoTags = [];
  List<int> assignedTagIDs = [];

  @override
  void initState() {
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
      elevation: 25,
      centerTitle: true,
      title: _title(),
      shadowColor: Colors.black54,
    );
  }

  Text _title() {
    return Text(
      'Photo Tags',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  ///BODY///

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _photoTags(),
          _photoCard(),
        ],
      ),
    );
  }

  ///PHOTO///

  Widget _photoCard() {
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
            Text('Photo', style: Theme.of(context).textTheme.headlineSmall),
            _dividerHeading(),
            Image.file(
              File(_containerPhoto.photoPath),
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
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
            Text('Photo Tags',
                style: Theme.of(context).textTheme.headlineSmall),
            _dividerHeading(),
            _photoTagsBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _photoTagsBuilder() {
    return Builder(builder: (context) {
      List<Widget> mlTags = [
        _addTag(),
      ];
      mlTags.addAll(photoTags.map((e) => mlTag(e.tagUID)).toList());

      return Wrap(
        runSpacing: 2.5,
        spacing: 2.5,
        children: mlTags,
      );
    });
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
        List<int> displayTagIDs = [];

        if (tagsController.text.isNotEmpty) {
          displayTagIDs.addAll(isarDatabase!.mlTags
              .filter()
              .tagContains(tagsController.text.toLowerCase(),
                  caseSensitive: false)
              .findAllSync()
              .map((e) => e.id)
              .where((element) => !assignedTagIDs.contains(element))
              .take(8));
        } else {
          displayTagIDs.addAll(isarDatabase!.mlTags
              .where()
              .findAllSync()
              .map((e) => e.id)
              .where((element) => !assignedTagIDs.contains(element))
              .take(10));
        }
        return Wrap(
          spacing: 5,
          children: displayTagIDs.map((e) => mlTag(e)).toList(),
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
          _tagsNode.unfocus();
        } else {
          //Should this be text only ?
          MlTag? mltag = isarDatabase!.mlTags
              .filter()
              .tagMatches(tagsController.text.toLowerCase().trim(),
                  caseSensitive: false)
              .and()
              .tagTypeEqualTo(mlTagType.text)
              .findFirstSync();

          if (mltag != null) {
            isarDatabase!
                .writeTxnSync((isar) => isar.photoTags.putSync(PhotoTag()
                  ..photoPath = _containerPhoto.photoPath
                  ..tagUID = mltag.id
                  ..confidence = 1.0
                  ..boundingBox = null));
          } else {
            MlTag newMlTag = MlTag()
              ..tag = tagsController.text.toLowerCase().trim()
              ..tagType = mlTagType.text;

            isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(newMlTag));

            isarDatabase!
                .writeTxnSync((isar) => isar.photoTags.putSync(PhotoTag()
                  ..photoPath = _containerPhoto.photoPath
                  ..tagUID = newMlTag.id
                  ..confidence = 1.0
                  ..boundingBox = null));
          }

          tagsController.clear();
          _tagsNode.requestFocus();
          updateTags();
          setState(() {});
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
            tagsController.clear();
            _tagsNode.requestFocus();
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

  Widget _addTag() {
    return Visibility(
      visible: !showTagEditor,
      child: InputChip(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _containerColor, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          setState(() {
            _tagsNode.requestFocus();
            showTagEditor = !showTagEditor;
          });
        },
        label: const Text('+'),
      ),
    );
  }

  Widget mlTag(int tagID) {
    return Builder(builder: (context) {
      MlTag currentMlTag = isarDatabase!.mlTags.getSync(tagID)!;
      return ActionChip(
        avatar: Builder(builder: (context) {
          switch (currentMlTag.tagType) {
            case mlTagType.text:
              return const Icon(
                Icons.format_size,
                size: 15,
              );

            case mlTagType.objectLabel:
              return const Icon(
                Icons.emoji_objects,
                size: 15,
              );

            case mlTagType.imageLabel:
              return const Icon(
                Icons.image,
                size: 15,
              );
          }
        }),
        backgroundColor: _containerColor,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentMlTag.tag + ' ',
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
            //Remove Tag
            PhotoTag currentPhotoTag =
                photoTags.where((element) => element.tagUID == tagID).first;
            isarDatabase!.writeTxnSync(
                (isar) => isar.photoTags.deleteSync(currentPhotoTag.id));
          } else {
            //Add Tag
            isarDatabase!
                .writeTxnSync((isar) => isar.photoTags.putSync(PhotoTag()
                  ..photoPath = _containerPhoto.photoPath
                  ..tagUID = tagID
                  ..confidence = 1.0
                  ..boundingBox = null));
            tagsController.clear();
          }
          updateTags();
          setState(() {});
        },
      );
    });
  }

  ///MISC///

  Divider _dividerHeading() {
    return const Divider(
      height: 8,
      thickness: 1,
      color: Colors.white,
    );
  }

  Divider _divider() {
    return const Divider(
      height: 8,
      indent: 2,
      color: Colors.white30,
    );
  }

  ///FUNCTIONS///

  void updateTags() {
    photoTags = [];
    photoTags.addAll(isarDatabase!.photoTags
        .filter()
        .photoPathMatches(widget.containerPhoto.photoPath)
        .findAllSync());

    assignedTagIDs = [];
    assignedTagIDs.addAll(photoTags.map((e) => e.tagUID));
  }

  void addListeners() {
    _tagsNode.addListener(() {
      setState(() {
        showTagEditor = _tagsNode.hasFocus;
      });
    });
  }

  void closeListeners() {
    _tagsNode.dispose();
  }
}
