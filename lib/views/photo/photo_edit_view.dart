import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/functions/isar/get_functions.dart';
import 'package:tswiri_database/models/image_data/image_data.dart';
import 'package:tswiri_database/widgets/ml_label_paint/ml_label_paint.dart';
import 'package:tswiri_database/widgets/photo/photo_display.dart';
import 'package:tswiri_database/widgets/tag_texts_search/tag_texts_search.dart';
import 'package:tswiri_widgets/colors/colors.dart';

class PhotoEditView extends StatefulWidget {
  const PhotoEditView({
    Key? key,
    required this.photo,
    required this.onLeft,
    required this.onRight,
    required this.navigationEnabeld,
  }) : super(key: key);
  final Photo photo;
  final void Function() onLeft;
  final void Function() onRight;
  final bool navigationEnabeld;

  @override
  State<PhotoEditView> createState() => PhotoEditViewState();
}

class PhotoEditViewState extends State<PhotoEditView> {
  late Photo _photo = widget.photo;
  late ImageData _imageData = ImageData.fromPhoto(_photo);

  //For Using Tag Text Predictor.
  final GlobalKey<TagTextSearchState> _key = GlobalKey();

  bool showObjects = true;
  bool showText = false;

  bool isAddingPhotoLabel = false;
  bool isAddingObjectLabel = false;

  int? currentObjectID;

  Size? imageSize;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return SingleChildScrollView(
      child: Column(
        children: [
          ///Photo display && painter.
          _photoCard(),

          ///Control Bar.
          _controlBar(),
          _photoLabelsCard(),
          _mlObjectsCard(),
          _mlTextElementCard(),
          _tagTextPredictor(),
        ],
      ),
    );
  }

  final GlobalKey _imageKey = GlobalKey();

  void postFrameCallback(_) {
    var context = _imageKey.currentContext;
    if (context == null) return;
    setState(() {
      imageSize = _imageKey.currentContext!.size!;
    });
  }

  Widget _photoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: _imageData.size.height /
              (_imageData.size.width /
                  (MediaQuery.of(context).size.width - 16)),
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: AlignmentDirectional.center,
            fit: StackFit.expand,
            children: [
              PhotoDisplay(
                photoPath: _photo.getPhotoPath(),
              ),
              MLLabelPaint(
                imageData: _imageData,
                showObjects: showObjects,
                showText: showText,
              ),
              _photoNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tagTextPredictor() {
    return Visibility(
      visible: isAddingObjectLabel || isAddingPhotoLabel,
      child: TagTextSearch(
        key: _key,
        //Spagetti monster.
        excludedTags: isAddingPhotoLabel
            ? _imageData.photoLabels.map((e) => e.tagTextID).toList()
            : isAddingObjectLabel
                ? _imageData.objectLabels
                    .where((element) => element.objectID == currentObjectID)
                    .map((e) => e.tagTextID)
                    .toList()
                : [],
        dismiss: () => setState(() {
          isAddingObjectLabel = false;
          isAddingPhotoLabel = false;
        }),
        onTagAdd: (tagTextID) {
          if (isAddingPhotoLabel) {
            //Create new Photo Label.
            PhotoLabel newPhotoLabel = PhotoLabel()
              ..photoID = _photo.id
              ..tagTextID = tagTextID;

            setState(() {
              _imageData.photoLabels.add(newPhotoLabel);
            });

            isar!.writeTxn((isar) => isar.photoLabels.put(newPhotoLabel));
          } else if (isAddingObjectLabel) {
            //Create new Object Label.
            ObjectLabel newObjectLabel = ObjectLabel()
              ..objectID = currentObjectID!
              ..tagTextID = tagTextID;

            setState(() {
              _imageData.objectLabels.add(newObjectLabel);
            });

            isar!.writeTxn((isar) => isar.objectLabels.put(newObjectLabel));
          }
        },
      ),
    );
  }

  Widget _controlBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilterChip(
          label: Text(
            'Objects',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onSelected: (value) {
            setState(() {
              showObjects = value;
            });
          },
          selected: showObjects,
        ),
        FilterChip(
          label: Text(
            'Text',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onSelected: (value) {
            setState(() {
              showText = value;
            });
          },
          selected: showText,
        ),
      ],
    );
  }

  Widget _photoLabelsCard() {
    return Visibility(
      visible: !isAddingObjectLabel,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ExpansionTile(
                title: Text(
                  'Photo Labels',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                children: [
                  Wrap(
                    spacing: 4,
                    children: [
                      for (MLPhotoLabel e in _imageData.mlPhotoLabels)
                        _mlPhotoLabelChip(e),
                      for (PhotoLabel e in _imageData.photoLabels)
                        _photoLabelChip(e),
                      Visibility(
                        visible: !isAddingPhotoLabel,
                        child: ActionChip(
                          label: Text(
                            '+',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onPressed: () {
                            setState(() {
                              isAddingPhotoLabel = true;
                            });
                            _key.currentState?.resetExcludedTags(_imageData
                                .photoLabels
                                .map((e) => e.tagTextID)
                                .toList());
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mlPhotoLabelChip(MLPhotoLabel photoLabel) {
    return Builder(builder: (context) {
      if (photoLabel.userFeedback == null) {
        return FilterChip(
          label: Text(getMLDetectedLabelText(photoLabel.detectedLabelTextID)),
          onSelected: (value) {
            setState(() {
              photoLabel.userFeedback = true;
            });
            //Write to isar.
            isar!.writeTxnSync((isar) {
              MLPhotoLabel label = isar.mLPhotoLabels.getSync(photoLabel.id)!;
              label.userFeedback = true;
              isar.mLPhotoLabels.putSync(label, replaceOnConflict: true);
            });
          },
          selected: false,
          avatar: const Icon(Icons.smart_toy),
        );
      } else if (photoLabel.userFeedback == true) {
        return FilterChip(
          label: Text(getMLDetectedLabelText(photoLabel.detectedLabelTextID)),
          onSelected: (value) {
            setState(() {
              photoLabel.userFeedback = false;
            });
            //Write to isar.
            isar!.writeTxnSync((isar) {
              MLPhotoLabel label = isar.mLPhotoLabels.getSync(photoLabel.id)!;
              label.userFeedback = false;
              isar.mLPhotoLabels.putSync(label, replaceOnConflict: true);
            });
          },
          backgroundColor: Colors.green,
          selectedColor: Colors.green,
          showCheckmark: true,
          selected: true,
        );
      } else {
        return FilterChip(
          label: Text(
            getMLDetectedLabelText(photoLabel.detectedLabelTextID),
            style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w300),
          ),
          onSelected: (value) {
            setState(() {
              photoLabel.userFeedback = null;
            });
            //Write to isar.
            isar!.writeTxnSync((isar) {
              MLPhotoLabel label = isar.mLPhotoLabels.getSync(photoLabel.id)!;
              label.userFeedback = null;
              isar.mLPhotoLabels.putSync(label, replaceOnConflict: true);
            });
          },
          avatar: const Icon(Icons.close_sharp),
          backgroundColor: background[300],
          selectedColor: background[300],
          showCheckmark: false,
          selected: false,
        );
      }
    });
  }

  Widget _photoLabelChip(PhotoLabel photoLabel) {
    return Chip(
      label: Text(
        isar!.tagTexts.getSync(photoLabel.tagTextID)?.text ?? 'err',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      avatar: const Icon(Icons.verified_user),
      backgroundColor: background[200],
      deleteIcon: const Icon(
        Icons.close_sharp,
        size: 20,
      ),
      onDeleted: () {
        setState(() {
          _imageData.photoLabels.remove(photoLabel);
        });
        //Write to isar.
        isar!.writeTxnSync((isar) {
          isar.photoLabels.deleteSync(photoLabel.id);
        });

        ///Let the TagTextPredictor know this tag has been removed.
        _key.currentState?.updateAssignedTags(photoLabel.tagTextID);
      },
      // backgroundColor: sunbirdOrange,
    );
  }

  Widget _mlObjectsCard() {
    return Visibility(
      visible: !isAddingPhotoLabel,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ExpansionTile(
                title: Text(
                  'Objects',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                children: [
                  Wrap(spacing: 4, children: [
                    for (var e in _imageData.mlObjects) _mlObjectCard(e)
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mlObjectCard(MLObject mlObject) {
    return Card(
      key: UniqueKey(),
      color: background[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'ID: ${mlObject.id}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const Divider(),
            Wrap(
              spacing: 4,
              children: [
                for (MLObjectLabel e in _imageData.mlObjectLabels
                    .where((element) => element.objectID == mlObject.id))
                  _mlObjectLabelChip(e),
                for (ObjectLabel e in _imageData.objectLabels
                    .where((element) => element.objectID == mlObject.id))
                  _objectLabelChip(e),
                Visibility(
                  key: UniqueKey(),
                  visible: !isAddingObjectLabel,
                  child: ActionChip(
                    label: Text(
                      '+',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    // backgroundColor: sunbirdOrange,
                    onPressed: () {
                      setState(() {
                        isAddingObjectLabel = true;
                        currentObjectID = mlObject.id;
                      });

                      List<int> excludedLabels = _imageData.objectLabels
                          .where((element) => element.objectID == mlObject.id)
                          .map((e) => e.tagTextID)
                          .toList();

                      setState(() {
                        _key.currentState?.resetExcludedTags(excludedLabels);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mlObjectLabelChip(MLObjectLabel mlObjectLabel) {
    return Builder(builder: (context) {
      if (mlObjectLabel.userFeedback == null) {
        return FilterChip(
          label:
              Text(getMLDetectedLabelText(mlObjectLabel.detectedLabelTextID)),
          onSelected: (value) {
            setState(() {
              mlObjectLabel.userFeedback = true;
            });
          },
          selected: false,
          // backgroundColor: background[200],
        );
      } else if (mlObjectLabel.userFeedback == true) {
        return FilterChip(
          label:
              Text(getMLDetectedLabelText(mlObjectLabel.detectedLabelTextID)),
          onSelected: (value) {
            setState(() {
              mlObjectLabel.userFeedback = false;
            });
          },
          backgroundColor: Colors.green,
          selectedColor: Colors.green,
          showCheckmark: true,
          selected: true,
        );
      } else {
        return FilterChip(
          label: Text(
            getMLDetectedLabelText(mlObjectLabel.detectedLabelTextID),
            style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w300),
          ),
          onSelected: (value) {
            setState(() {
              mlObjectLabel.userFeedback = null;
            });
          },
          backgroundColor: background[300],
          showCheckmark: false,
          selected: false,
        );
      }
    });
  }

  Widget _objectLabelChip(ObjectLabel objectLabel) {
    return Chip(
      label: Text(
        isar!.tagTexts.getSync(objectLabel.tagTextID)?.text ?? 'err',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      avatar: const Icon(Icons.verified_user),
      backgroundColor: background[200],
      deleteIcon: const Icon(
        Icons.close_sharp,
        size: 20,
      ),
      onDeleted: () {
        setState(() {
          _imageData.objectLabels.remove(objectLabel);
        });

        ///Let the TagTextPredictor know this tag has been removed.
        _key.currentState?.updateAssignedTags(objectLabel.tagTextID);
      },
      // backgroundColor: sunbirdOrange,
    );
  }

  Widget _mlTextElementCard() {
    return Visibility(
      visible: !isAddingObjectLabel && !isAddingPhotoLabel,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ExpansionTile(
                title: Text(
                  'Recognized Text',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                children: [
                  _imageData.mlTextElements.isEmpty
                      ? Text(
                          'No Text Detected',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView(
                      primary: false,
                      children: [
                        Wrap(
                          spacing: 4,
                          children: _imageData.mlTextElements
                              .map((e) => _mlTextElementChip(e))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mlTextElementChip(MLTextElement mlTextElement) {
    return Builder(builder: (context) {
      if (mlTextElement.userFeedback == null) {
        return FilterChip(
          label: Text(
              getMLDetectedElementText(mlTextElement.detectedElementTextID)),
          onSelected: (value) {
            setState(() {
              mlTextElement.userFeedback = true;
            });
          },
          selected: false,
          // backgroundColor: background[200],
        );
      } else if (mlTextElement.userFeedback == true) {
        return FilterChip(
          label: Text(
              getMLDetectedElementText(mlTextElement.detectedElementTextID)),
          onSelected: (value) {
            setState(() {
              mlTextElement.userFeedback = false;
            });
          },
          backgroundColor: Colors.green,
          selectedColor: Colors.green,
          showCheckmark: true,
          selected: true,
        );
      } else {
        return FilterChip(
          label: Text(
            getMLDetectedElementText(mlTextElement.detectedElementTextID),
            style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w300),
          ),
          onSelected: (value) {
            setState(() {
              mlTextElement.userFeedback = null;
            });
          },
          backgroundColor: background[300],
          showCheckmark: false,
          selected: false,
        );
      }
    });
  }

  Widget _photoNavigation() {
    return Visibility(
      visible: widget.navigationEnabeld,
      child: Column(
        children: [
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: background[300]!.withAlpha(150),
                  child: IconButton(
                    iconSize: 45,
                    onPressed: () {
                      widget.onLeft();
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: tswiriOrange,
                    ),
                  ),
                ),
                Card(
                  color: background[300]!.withAlpha(150),
                  child: IconButton(
                    iconSize: 45,
                    onPressed: () {
                      widget.onRight();
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: tswiriOrange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updatePhoto(Photo photo) {
    setState(() {
      _photo = photo;
      _imageData = ImageData.fromPhoto(_photo);
    });
  }
}
