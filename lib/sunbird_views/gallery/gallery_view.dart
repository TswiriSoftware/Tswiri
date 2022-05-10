import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/gallery/image_painter.dart.dart';
import 'package:isar/isar.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  ///List of all Photos.
  List<ContainerPhoto> photos = [];

  ///Selected Photo.
  ContainerPhoto? selectedPhoto;

  List<PhotoTag> photoTags = [];
  List<int> assignedTagIDs = [];

  TextEditingController tagsController = TextEditingController();
  final _tagsNode = FocusNode();
  bool showTagEditor = false;

  @override
  void initState() {
    updatePhotos();
    super.initState();
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
      backgroundColor: sunbirdOrange,
      elevation: 25,
      centerTitle: true,
      title: _title(),
      shadowColor: Colors.black54,
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () {
            setState(() {
              if (selectedPhoto == null) {
                Navigator.pop(context);
              } else {
                selectedPhoto = null;
              }
            });
          },
          icon: const Icon(Icons.arrow_back)),
    );
  }

  Text _title() {
    return Text(
      'Gallery',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  ///BODY///
  Widget _body() {
    return Builder(builder: (context) {
      if (selectedPhoto == null) {
        return _photoGridView();
      } else {
        return _photoEditor();
      }
    });
  }

  ///GRID VIEW///
  Widget _photoGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 1.0,
        crossAxisCount: 3,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return photoCard(photos[index]);
      },
    );
  }

  Widget photoCard(ContainerPhoto containerPhoto) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPhoto = containerPhoto;
        });
      },
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2.5), // Image border
          child: SizedBox.fromSize(
            child: Image.file(
              File(containerPhoto.photoPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  String? swipeDirection;

  ///PHOTO EDITOR///
  Widget _photoEditor() {
    return GestureDetector(
      onPanUpdate: (details) {
        swipeDirection = details.delta.dx < 0 ? 'right' : 'left';
      },
      onPanEnd: (details) {
        if (swipeDirection == null) {
          return;
        }
        if (swipeDirection == 'right') {
          log('right');
          int index = photos.indexOf(selectedPhoto!);
          if (index < photos.length - 1) {
            setState(() {
              selectedPhoto = photos[index + 1];
            });
          }
        }
        if (swipeDirection == 'left') {
          log('left');
          int index = photos.indexOf(selectedPhoto!);
          if (index >= 0) {
            setState(() {
              selectedPhoto = photos[index - 1];
            });
          }
        }
      },
      child: SingleChildScrollView(
        child: FutureBuilder<Size>(
          future: getImageSize(selectedPhoto!),
          builder: ((context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Column(
                children: [
                  mlTagsCard(),
                  imageViewer(snapshot.data!),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }

  Widget imageViewer(Size size) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(selectedPhoto!.photoPath),
              fit: BoxFit.fill,
            ),
            FutureBuilder<Size>(
                future: getImageSize(selectedPhoto!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomPaint(
                      painter: ImageObjectDetectorPainter(
                          containerPhoto: selectedPhoto!,
                          absoluteSize: snapshot.data!),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget mlTagsCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: sunbirdOrange, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _mlTagsHeading(),
            _dividerHeading(),
            mlTagsBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _mlTagsHeading() {
    return Text('AI Tags', style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget mlTagsBuilder() {
    return Builder(builder: (context) {
      List<PhotoTag> photoTags = [];
      photoTags.addAll(isarDatabase!.photoTags
          .filter()
          .photoPathMatches(selectedPhoto!.photoPath)
          .findAllSync());

      assignedTagIDs = [];
      assignedTagIDs = photoTags.map((e) => e.tagUID).toList();

      List<Widget> tags = [_addTag()];
      tags.addAll(photoTags.map((e) => photoTag(e)).toList());

      return Wrap(
        spacing: 10,
        alignment: WrapAlignment.center,
        runSpacing: 2,
        children: tags,
      );
    });
  }

  Widget _addTag() {
    return Visibility(
      visible: !showTagEditor,
      child: InputChip(
        shape: RoundedRectangleBorder(
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

  Widget photoTag(PhotoTag photoTag) {
    return Builder(builder: (context) {
      MlTag tag = isarDatabase!.mlTags.getSync(photoTag.tagUID)!;
      return ActionChip(
          avatar: Builder(builder: (context) {
            switch (tag.tagType) {
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
          backgroundColor: sunbirdOrange,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tag.tag + ' ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Icon(
                Icons.close,
                size: 12.5,
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              isarDatabase!.writeTxnSync(
                  (isar) => isar.photoTags.deleteSync(photoTag.id));
            });
          });
    });
  }

  Future<Size> getImageSize(ContainerPhoto selectedPhoto) async {
    var decodedImage = await decodeImageFromList(
        File(selectedPhoto.photoPath).readAsBytesSync());

    Size absoluteSize =
        Size(decodedImage.height.toDouble(), decodedImage.width.toDouble());

    return absoluteSize;
  }

  Widget _bottomSheet() {
    return Visibility(
      visible: showTagEditor,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: sunbirdOrange, width: 1),
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
        addTag();
        if (value.isEmpty) {
          setState(() {
            showTagEditor = false;
          });
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
            addTag();
          },
          icon: const Icon(Icons.add),
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: sunbirdOrange)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: sunbirdOrange)),
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
        backgroundColor: sunbirdOrange,
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
          // if (assignedTagIDs.contains(tagID)) {
          //   //Remove Tag
          //   PhotoTag currentPhotoTag =
          //       photoTags.where((element) => element.tagUID == tagID).first;
          //   isarDatabase!.writeTxnSync(
          //       (isar) => isar.photoTags.deleteSync(currentPhotoTag.id));
          // } else {
          //   //Add Tag
          //   isarDatabase!
          //       .writeTxnSync((isar) => isar.photoTags.putSync(PhotoTag()
          //         ..photoPath = selectedPhoto!.photoPath
          //         ..tagUID = tagID
          //         ..confidence = 1.0
          //         ..boundingBox = null));
          //   tagsController.clear();
          // }
          //updateTags();
          addTag();
          setState(() {});
        },
      );
    });
  }

  void addTag() {
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
        isarDatabase!.writeTxnSync((isar) => isar.photoTags.putSync(PhotoTag()
          ..photoPath = selectedPhoto!.photoPath
          ..tagUID = mltag.id
          ..confidence = 1.0
          ..boundingBox = null));
      } else {
        MlTag newMlTag = MlTag()
          ..tag = tagsController.text.toLowerCase().trim()
          ..tagType = mlTagType.text;

        isarDatabase!.writeTxnSync((isar) => isar.mlTags.putSync(newMlTag));

        isarDatabase!.writeTxnSync((isar) => isar.photoTags.putSync(PhotoTag()
          ..photoPath = selectedPhoto!.photoPath
          ..tagUID = newMlTag.id
          ..confidence = 1.0
          ..boundingBox = null));
      }

      tagsController.clear();
      _tagsNode.requestFocus();

      setState(() {});
    }
  }

  void updatePhotos() {
    setState(() {
      photos = isarDatabase!.containerPhotos.where().findAllSync();
    });
  }

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
}
