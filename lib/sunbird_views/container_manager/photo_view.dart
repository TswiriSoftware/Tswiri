import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/user_tag/user_tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/gallery/image_painter.dart.dart';

import 'package:isar/isar.dart';

class PhotoView extends StatefulWidget {
  const PhotoView(
      {Key? key, required this.containerPhoto, required this.containerColor})
      : super(key: key);
  final Photo containerPhoto;
  final Color containerColor;
  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late final Photo _containerPhoto = widget.containerPhoto;
  late final Color _containerColor = widget.containerColor;

  TextEditingController tagsController = TextEditingController();
  final _tagsNode = FocusNode();
  bool showTagEditor = false;

  List<MlTag> photoTags = [];
  List<int> assignedTagIDs = [];

  late List<MlTag> mlTags = isarDatabase!.mlTags
      .filter()
      .mlTagIDEqualTo(_containerPhoto.id)
      .findAllSync();

  @override
  void initState() {
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
      bottomSheet: _userTagEditor(),
    );
  }

  ///APP BAR///
  AppBar _appBar() {
    return AppBar(
      backgroundColor: widget.containerColor,
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
          _photoCard(),
          _mlTags(),
          _userTags(),
          const SizedBox(
            height: 200,
          ),
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
            _imageViewer(),
          ],
        ),
      ),
    );
  }

  Widget _imageViewer() {
    return FutureBuilder<Size>(
      future: getImageSize(_containerPhoto),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: snapshot.data!.width,
            height: snapshot.data!.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  File(_containerPhoto.photoPath),
                  fit: BoxFit.fill,
                ),
                CustomPaint(
                  painter: ImageObjectDetectorPainter(
                      photo: _containerPhoto, absoluteSize: snapshot.data!),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<Size> getImageSize(Photo selectedPhoto) async {
    var decodedImage = await decodeImageFromList(
        File(selectedPhoto.photoPath).readAsBytesSync());

    Size absoluteSize =
        Size(decodedImage.height.toDouble(), decodedImage.width.toDouble());

    return absoluteSize;
  }

  ///MLTAGS///
  Widget _mlTags() {
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
            _mlTagsBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _mlTagsBuilder() {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: 2.5,
            spacing: 2.5,
            children: mlTags
                .where((element) => element.blackListed == false)
                .map((e) => mlTag(e))
                .toList(),
          ),
          Center(
            child: Text(
              'tap to blacklist',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          _divider(),
          Text('Blacklist', style: Theme.of(context).textTheme.headlineSmall),
          _dividerHeading(),
          Wrap(
            runSpacing: 2.5,
            spacing: 2.5,
            children: mlTags
                .where((element) => element.blackListed == true)
                .map((e) => mlTag(e))
                .toList(),
          ),
        ],
      );
    });
  }

  Widget mlTag(MlTag mlTag) {
    return Builder(builder: (context) {
      String tagText = isarDatabase!.tagTexts
          .filter()
          .idEqualTo(mlTag.textTagID)
          .tagProperty()
          .findFirstSync()!;

      return ActionChip(
        avatar: Builder(builder: (context) {
          switch (mlTag.tagType) {
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
        label: Text(tagText),
        backgroundColor: _containerColor,
        onPressed: () {
          if (mlTag.blackListed) {
            setState(() {
              mlTag.blackListed = false;
            });

            isarDatabase!.writeTxnSync(
                (isar) => isar.mlTags.putSync(mlTag, replaceOnConflict: true));
          } else {
            setState(() {
              mlTag.blackListed = true;
            });

            isarDatabase!.writeTxnSync(
                (isar) => isar.mlTags.putSync(mlTag, replaceOnConflict: true));
          }
        },
      );
    });
  }

  ///USER TAGS///
  Widget _userTags() {
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
            Text('User Tags', style: Theme.of(context).textTheme.headlineSmall),
            _dividerHeading(),
            _userTagsBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _userTagsBuilder() {
    return Builder(builder: (context) {
      List<Widget> widgets = [
        _addTag(),
      ];

      widgets.addAll(isarDatabase!.userTags
          .filter()
          .userTagIDEqualTo(_containerPhoto.id)
          .findAllSync()
          .map((e) => userTag(e)));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: 2.5,
            spacing: 2.5,
            children: widgets,
          ),
        ],
      );
    });
  }

  Widget userTag(UserTag userTag) {
    return Builder(
      builder: (context) {
        String tagtext = isarDatabase!.tagTexts
            .filter()
            .idEqualTo(userTag.tagTextID)
            .tagProperty()
            .findFirstSync()!;

        return ActionChip(
          label: Text(tagtext),
          onPressed: () {
            UserTag? selectedUserTag =
                isarDatabase!.userTags.getSync(userTag.id);
            if (selectedUserTag == null) {
              isarDatabase!
                  .writeTxnSync((isar) => isar.userTags.putSync(userTag));
              setState(() {});
            } else {
              isarDatabase!
                  .writeTxnSync((isar) => isar.userTags.deleteSync(userTag.id));
              setState(() {});
            }
          },
          backgroundColor: _containerColor,
        );
      },
    );
  }

  ///EDITOR///
  Widget _userTagEditor() {
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
            _userTagTextField(),
          ],
        ),
      ),
    );
  }

  Widget _userTagTextField() {
    return TextField(
      controller: tagsController,
      focusNode: _tagsNode,
      onChanged: (value) {
        setState(() {});
      },
      onSubmitted: (value) {
        addTag(value);
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
            addTag(tagsController.text);
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

  Widget _tagSelector() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      scrollDirection: Axis.horizontal,
      child: Builder(builder: (context) {
        List<TagText> tagTexts = [];
        List<int> assignedTags = isarDatabase!.userTags
            .where()
            .findAllSync()
            .map((e) => e.tagTextID)
            .toList();

        if (tagsController.text.isNotEmpty) {
          tagTexts.addAll(isarDatabase!.tagTexts
              .filter()
              .tagContains(tagsController.text.toLowerCase())
              .and()
              .not()
              .repeat(assignedTags, (q, int element) => q.idEqualTo(element))
              .findAllSync()
              .take(10));
        } else {
          tagTexts.addAll(isarDatabase!.tagTexts
              .filter()
              .not()
              .repeat(assignedTags, (q, int element) => q.idEqualTo(element))
              .findAllSync());
        }

        return Wrap(
          spacing: 5,
          children: tagTexts.map((e) => newUserTag(e)).toList(),
        );
      }),
    );
  }

  Widget newUserTag(TagText tagText) {
    return ActionChip(
      label: Text(tagText.tag),
      onPressed: () {
        UserTag? userTag = isarDatabase!.userTags
            .filter()
            .tagTextIDEqualTo(tagText.id)
            .findFirstSync();
        if (userTag == null) {
          userTag = UserTag()
            ..tagTextID = tagText.id
            ..userTagID = _containerPhoto.id;

          isarDatabase!.writeTxnSync((isar) => isar.userTags.putSync(userTag!));
        }

        setState(() {});
      },
      backgroundColor: _containerColor,
    );
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

  void addTag(String value) {
    if (value.isNotEmpty) {
      log(value);
      _tagsNode.requestFocus();

      //i. Label Text.
      String labelText = value.toLowerCase();

      //ii. Check if label text exists.
      TagText? tagText =
          isarDatabase!.tagTexts.filter().tagMatches(labelText).findFirstSync();

      //iii. Create new TagText.
      if (tagText == null) {
        tagText = TagText()..tag = labelText;
        isarDatabase!.writeTxnSync((isar) => isar.tagTexts.putSync(tagText!));
      }

      UserTag? userTag = isarDatabase!.userTags
          .filter()
          .userTagIDEqualTo(_containerPhoto.id)
          .and()
          .tagTextIDEqualTo(tagText.id)
          .findFirstSync();

      if (userTag == null) {
        UserTag userTag = UserTag()
          ..tagTextID = tagText.id
          ..userTagID = _containerPhoto.id;
        isarDatabase!.writeTxnSync((isar) => isar.userTags.putSync(userTag));
        setState(() {});
      }
      tagsController.clear();
    } else {
      setState(() {
        _tagsNode.unfocus();
      });
    }
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



// void addTag() {
//   if (tagsController.text.isEmpty) {
//     _tagsNode.unfocus();
//   } else {
//     //Should this be text only ?
//     MlTag? mltag = isarDatabase!.mlTags
//         .filter()
//         .tagMatches(tagsController.text.toLowerCase().trim(),
//             caseSensitive: false)
//         .and()
//         .tagTypeEqualTo(mlTagType.text)
//         .findFirstSync();

//     if (mltag != null) {
//       isarDatabase!.writeTxnSync((isar) => isar.photoTags.putSync(PhotoTag()
//         ..photoPath = _containerPhoto.photoPath
//         ..tagUID = mltag.id
//         ..confidence = 1.0
//         ..boundingBox = null));
//     } else {
//       MlTag newMlTag = MlTag()
//         ..tag = tagsController.text.toLowerCase().trim()
//         ..tagType = mlTagType.text;

//       isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(newMlTag));

//       isarDatabase!.writeTxnSync((isar) => isar.photoTags.putSync(PhotoTag()
//         ..photoPath = _containerPhoto.photoPath
//         ..tagUID = newMlTag.id
//         ..confidence = 1.0
//         ..boundingBox = null));
//     }

//     tagsController.clear();
//     _tagsNode.requestFocus();
//     updateTags();
//     setState(() {});
//   }
// }
