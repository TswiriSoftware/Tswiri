import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:isar/isar.dart';

class PhotoTagsView extends StatefulWidget {
  const PhotoTagsView(
      {Key? key, required this.containerPhoto, required this.containerColor})
      : super(key: key);

  final ContainerPhoto containerPhoto;
  final Color containerColor;
  @override
  State<PhotoTagsView> createState() => _PhotoTagsViewState();
}

class _PhotoTagsViewState extends State<PhotoTagsView> {
  TextEditingController tagController = TextEditingController();
  bool showTagSearch = false;
  FocusNode myFocusNode = FocusNode();

  List<PhotoTag> photoTags = [];
  List<int> assignedTagIDs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.containerColor,
        title: Text(
          'Photo Tag Editor',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(builder: (context) {
        if (showTagSearch) {
          return _floatingTagSearch();
        } else {
          return Container();
        }
      }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _photoTagsBuilder(),
            _photo(),
          ],
        ),
      ),
    );
  }

  ///PHOTO///

  Widget _photo() {
    return SizedBox(
      child: CustomOutlineContainer(
        margin: 5,
        outlineColor: widget.containerColor,
        padding: 2,
        child: Image.file(
          File(widget.containerPhoto.photoPath),
        ),
      ),
    );
  }

  ///PHOTO TAGS///

  Widget _photoTagsBuilder() {
    return Builder(
      builder: (context) {
        _updateTags();

        List<Widget> tagWidgets = photoTags.map((e) => photoMlTag(e)).toList();
        tagWidgets.add(photoMlTagAddButton());

        return CustomOutlineContainer(
          margin: 2.5,
          outlineColor: widget.containerColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Column(
              children: [
                Text(
                  'Tags',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'tap to remove',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Divider(),
                Wrap(
                  runSpacing: 8,
                  spacing: 5,
                  children: tagWidgets,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget photoMlTag(PhotoTag photoTag) {
    return Builder(builder: (_) {
      MlTag mltag = isarDatabase!.mlTags
          .filter()
          .idEqualTo(photoTag.tagUID)
          .findFirstSync()!;

      return InkWell(
        onTap: () {
          isarDatabase!
              .writeTxnSync((isar) => isar.photoTags.deleteSync(photoTag.id));
          setState(() {});
        },
        child: Container(
          child: Text(
            mltag.tag,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: widget.containerColor, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              color: widget.containerColor),
        ),
      );
    });
  }

  Widget photoMlTagAddButton() {
    return Builder(builder: (context) {
      if (showTagSearch) {
        return Container();
      } else {
        return InkWell(
          onTap: () {
            setState(() {
              showTagSearch = true;
            });
          },
          child: Container(
            width: 50,
            child: Center(
              child: Text(
                '+',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: widget.containerColor, width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                color: Colors.white10),
          ),
        );
      }
    });
  }

  ///ADD TAG///

  Widget _floatingTagSearch() {
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //closeTagSearch(),
          _closeTagSearch(),
          _unassignedTagsBuilder(),
          _tagSearchField(),
        ],
      ),
    );
  }

  Widget _unassignedTagsBuilder() {
    return Builder(builder: (context) {
      List<int> displayTagIDs = [];

      if (tagController.text.isNotEmpty) {
        displayTagIDs.addAll(isarDatabase!.mlTags
            .filter()
            .tagContains(tagController.text.toLowerCase(), caseSensitive: false)
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
            .take(5));
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //_dividerLight(),
            Text('Unassigned Tags',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(
              height: 5,
            ),
            Wrap(
              runSpacing: 5,
              spacing: 5,
              children: displayTagIDs.map((e) => mlTag(e)).toList(),
            ),
          ],
        ),
      );
    });
  }

  Widget _tagSearchField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: tagController,
            onChanged: (value) {
              setState(() {});
            },
            focusNode: myFocusNode,
            onSubmitted: (value) {
              if (value.isEmpty) {
                setState(() {
                  showTagSearch = false;
                });
              } else {
                //Check if tag exists
                MlTag? exists = isarDatabase!.mlTags
                    .filter()
                    .tagMatches(tagController.text.trim(), caseSensitive: false)
                    .findFirstSync();

                String inputValue = tagController.text;

                if (exists != null && inputValue.isNotEmpty) {
                  // MlTag newTag = MlTag()
                  //   ..tag = inputValue
                  //   ..tagType = mlTagType.text;
                  // isarDatabase!.writeTxnSync(
                  //   (isar) => isar.mlTags.putSync(newTag),
                  // );

                  //tagController.text = '';
                  // assignedTags.add(newTag.id);
                  // updateTags();

                  //Maintain Focus
                  myFocusNode.requestFocus();

                  setState(() {});
                } else {
                  //Remove white spaces.
                  inputValue.trim();

                  MlTag newMlTag = MlTag()
                    ..tag = inputValue
                    ..tagType = mlTagType.text;

                  //Create new MlTag and PhotoTag
                  isarDatabase!.writeTxnSync((isar) {
                    //MlTag
                    isar.mlTags.putSync(newMlTag);
                  });

                  isarDatabase!.writeTxnSync((isar) {
                    isar.photoTags.putSync(PhotoTag()
                      ..boundingBox = null
                      ..confidence = 1
                      ..photoPath = widget.containerPhoto.photoPath
                      ..tagUID = newMlTag.id);
                  });

                  _updateTags();

                  //Maintain Focus.
                  myFocusNode.requestFocus();
                  //Clear input text.
                  tagController.clear();
                  setState(() {});
                }
              }
            },
            autofocus: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.search),
                ],
              ),
              labelText: 'Enter tag name',
              labelStyle: const TextStyle(fontSize: 18),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _closeTagSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              showTagSearch = false;
            });
          },
          child: CustomOutlineContainer(
            padding: 2.5,
            margin: 0,
            outlineColor: widget.containerColor,
            child: const Center(
              child: Icon(
                Icons.close,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mlTag(int tagID) {
    return InkWell(
      onTap: () {
        //ADD ML TAG

        //Create Photo Tag
        isarDatabase!.writeTxnSync((isar) => isar.photoTags.putSync(PhotoTag()
          ..confidence = 1
          ..photoPath = widget.containerPhoto.photoPath
          ..tagUID = tagID
          ..boundingBox = null));

        _updateTags();
        setState(() {});
      },
      child: Builder(builder: (context) {
        MlTag mlTag =
            isarDatabase!.mlTags.filter().idEqualTo(tagID).findFirstSync()!;
        return Container(
            child: Text(
              mlTag.tag,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 1,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: widget.containerColor, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              color: widget.containerColor,
            ));
      }),
    );
  }

  void _updateTags() {
    photoTags = [];
    photoTags.addAll(isarDatabase!.photoTags
        .filter()
        .photoPathMatches(widget.containerPhoto.photoPath)
        .findAllSync());

    assignedTagIDs = [];
    assignedTagIDs.addAll(photoTags.map((e) => e.tagUID));
  }
}
