import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:tswiri_database_interface/models/image_data/image_data.dart';
import 'package:tswiri_database_interface/widgets/ml_label_paint/ml_label_photo_painter.dart';
import 'package:tswiri_theme/transitions/left_to_right_transition.dart';
import 'package:tswiri_theme/transitions/right_to_left_transition.dart';
import 'package:tswiri_database_interface/functions/isar/get_functions.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => GalleryViewState();
}

class GalleryViewState extends State<GalleryView> {
  late List<Photo> photos = isar!.photos.where().findAllSync();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          _sliverList(),
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      expandedHeight: 0,
      flexibleSpace: AppBar(
        title: const Text(
          'Gallery',
        ),
        centerTitle: true,
        elevation: 5,
      ),
    );
  }

  SliverGrid _sliverList() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150.0,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Photo photo = photos[index];
          return OpenContainer(
            openShape: const RoundedRectangleBorder(),
            closedColor: Colors.transparent,
            openColor: Colors.transparent,
            closedBuilder: (context, action) => Image.file(
              File(photo.getPhotoThumbnailPath()),
              fit: BoxFit.cover,
            ),
            openBuilder: (context, _) => PhotoView(
              index: index,
              photos: photos,
            ),
          );
        },
        childCount: photos.length,
      ),
    );
  }
}

class PhotoView extends StatefulWidget {
  const PhotoView({
    super.key,
    required this.index,
    required this.photos,
    this.showObjects,
    this.showText,
  });
  final List<Photo> photos;
  final int index;
  final bool? showObjects;
  final bool? showText;

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late int currentIndex = widget.index;
  late final Photo _photo = widget.photos[currentIndex];
  late final ImageData _imageData = ImageData.fromPhoto(_photo);

  late bool showObjects = widget.showObjects ?? true;
  late bool showText = widget.showText ?? true;
  bool isAddingPhotoLabel = false;
  bool isAddingObjectLabel = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragEnd: (details) async {
          if (details.primaryVelocity! > 0) {
            navigateLeft();
          } else if (details.primaryVelocity! < 0) {
            navigateRight();
          }
        },
        onVerticalDragEnd: (details) {},
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: CustomScrollView(
            slivers: [
              _sliverAppBar(),
              _photoSliver(),
              _sliverList(),
            ],
          ),
        ));
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      expandedHeight: 0,
      flexibleSpace: AppBar(
        title: const Text(
          'Photo',
        ),
        centerTitle: true,
        elevation: 5,
      ),
      actions: const [],
    );
  }

  SliverToBoxAdapter _photoSliver() {
    return SliverToBoxAdapter(
      child: _photoDisplay(),
    );
  }

  SizedBox _photoDisplay() {
    return SizedBox(
      height: _imageData.size.height /
          (_imageData.size.width / (MediaQuery.of(context).size.width)),
      width: MediaQuery.of(context).size.width,
      child: Stack(
          alignment: AlignmentDirectional.topEnd,
          fit: StackFit.expand,
          children: [
            Image.file(
              File(_photo.getPhotoPath()),
              fit: BoxFit.scaleDown,
              frameBuilder: (BuildContext context, Widget child, int? frame,
                  bool wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                } else {
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                    child: child,
                  );
                }
              },
            ),
            CustomPaint(
              painter: MLLabePainter(
                imageData: _imageData,
                showObjects: showObjects,
                showText: showText,
                objectLabelConfidence: 0.5,
              ),
            ),
          ]),
    );
  }

  SliverPadding _sliverList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Card(
            elevation: 5,
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  color: Theme.of(context).colorScheme.onBackground,
                  child: const SizedBox(
                    width: 50,
                    height: 4,
                  ),
                ),
                _controlBar(),
                const Divider(),
                _dateTime(),
                const Divider(),
                _photoLabels(),
                const Divider(),
                _mlObjectsCard(),
                const Divider(),
                _mlTextElements(),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _photoLabels() {
    return Column(
      children: [
        const ListTile(
          title: Text('Photo Labels'),
        ),
        Wrap(
          spacing: 4,
          children: [
            for (MLPhotoLabel e in _imageData.mlPhotoLabels)
              FilterChip(
                avatar: const Icon(Icons.smart_toy_rounded),
                selected: e.userFeedback ?? true,
                label: e.userFeedback ?? true
                    ? Text(
                        getMLDetectedLabelText(e.detectedLabelTextID),
                      )
                    : Text(
                        getMLDetectedLabelText(e.detectedLabelTextID),
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      ),
                onSelected: (value) {
                  setState(() {
                    e.userFeedback = value;
                  });
                },
              ),
            for (PhotoLabel e in _imageData.photoLabels)
              Chip(
                avatar: const Icon(Icons.account_circle_rounded),
                label: Text(
                  isar!.tagTexts.getSync(e.tagTextID)?.text ?? '-',
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _mlObjectsCard() {
    return Column(
      children: [
        const ListTile(
          title: Text('Objects'),
        ),
        Wrap(
            spacing: 4,
            children: [for (var e in _imageData.mlObjects) _mlObjectCard(e)]),
      ],
    );
  }

  Widget _mlObjectCard(MLObject mlObject) {
    return Card(
      elevation: 10,
      key: UniqueKey(),
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
                  Chip(
                      label: Text(isar!.mLDetectedElementTexts
                          .filter()
                          .idEqualTo(e.detectedLabelTextID)
                          .findFirstSync()!
                          .detectedText)),
                for (ObjectLabel e in _imageData.objectLabels
                    .where((element) => element.objectID == mlObject.id))
                  Chip(
                    label: Text(
                      isar!.tagTexts
                          .filter()
                          .idEqualTo(e.tagTextID)
                          .findFirstSync()!
                          .text,
                    ),
                  ),
                // Visibility(
                //   key: UniqueKey(),
                //   visible: !isAddingObjectLabel,
                //   child: ActionChip(
                //     label: Text(
                //       '+',
                //       style: Theme.of(context).textTheme.bodyLarge,
                //     ),
                //     // backgroundColor: sunbirdOrange,
                //     onPressed: () {
                //       setState(() {
                //         isAddingObjectLabel = true;
                //         currentObjectID = mlObject.id;
                //       });

                //       List<int> excludedLabels = _imageData.objectLabels
                //           .where((element) => element.objectID == mlObject.id)
                //           .map((e) => e.tagTextID)
                //           .toList();

                //       setState(() {
                //         _key.currentState?.resetExcludedTags(excludedLabels);
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mlTextElements() {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Recognized Text',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        _imageData.mlTextElements.isEmpty
            ? Text(
                'No Text Detected',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            : const SizedBox.shrink(),
        Wrap(
          spacing: 4,
          children: _imageData.mlTextElements
              .map(
                (e) => Chip(
                  label: Text(
                    getMLDetectedElementText(e.detectedElementTextID),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  ListTile _dateTime() {
    return ListTile(
      leading: const Icon(Icons.access_time_rounded),
      title: Text(DateFormat('EE, dd MMM yy • HH:m')
          .format(
            DateTime.fromMillisecondsSinceEpoch(_photo.photoName),
          )
          .toString()),
    );
  }

  Row _controlBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilterChip(
          label: Text(
            'Objects',
            style: Theme.of(context).textTheme.titleSmall,
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
            style: Theme.of(context).textTheme.titleSmall,
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

  navigateLeft() {
    if (widget.index == 0) {
      currentIndex = widget.photos.length - 1;
    } else {
      currentIndex = currentIndex - 1;
    }
    Navigator.of(context).pushReplacement(
      rightToLeftTransition(
        PhotoView(
          index: currentIndex,
          photos: widget.photos,
          showObjects: showObjects,
          showText: showText,
        ),
      ),
    );
  }

  navigateRight() {
    if (currentIndex == widget.photos.length - 1) {
      currentIndex = 0;
    } else {
      currentIndex = currentIndex + 1;
    }
    Navigator.of(context).pushReplacement(
      leftToRightTransition(
        PhotoView(
          index: currentIndex,
          photos: widget.photos,
          showObjects: showObjects,
          showText: showText,
        ),
      ),
    );
  }
}

class PhotoViewOLD extends StatefulWidget {
  const PhotoViewOLD({
    super.key,
    required this.index,
    required this.photos,
  });
  final List<Photo> photos;
  final int index;
  @override
  State<PhotoViewOLD> createState() => _PhotoViewOLDState();
}

class _PhotoViewOLDState extends State<PhotoViewOLD> {
  late final List<Photo> _photos = widget.photos;
  late int currentIndex = widget.index;

  bool showObjects = true;
  bool showText = false;
  bool isAddingPhotoLabel = false;
  bool isAddingObjectLabel = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) async {
        if (details.primaryVelocity! > 0) {
          navigateLeft();
        } else if (details.primaryVelocity! < 0) {
          navigateRight();
        }
      },
      child: Card(
        child: Builder(builder: (context) {
          Photo photo = _photos[currentIndex];
          ImageData imageData = ImageData.fromPhoto(photo);
          return Column(
            children: [
              _appBar(),
              Expanded(
                child: Column(
                  children: [
                    _photo(photo, imageData),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 5,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ],
    );
  }

  Widget _photo(Photo photo, ImageData imageData) {
    return SizedBox(
      height: imageData.size.height /
          (imageData.size.width / (MediaQuery.of(context).size.width - 16)),
      width: MediaQuery.of(context).size.width,
      child: Stack(
          alignment: AlignmentDirectional.topEnd,
          fit: StackFit.expand,
          children: [
            Image.file(
              File(photo.getPhotoPath()),
              fit: BoxFit.scaleDown,
              frameBuilder: (BuildContext context, Widget child, int? frame,
                  bool wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                } else {
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                    child: child,
                  );
                }
              },
            ),
            CustomPaint(
              painter: MLLabePainter(
                imageData: imageData,
                showObjects: showObjects,
                showText: showText,
                objectLabelConfidence: 0.5,
              ),
            ),
          ]),
    );
  }

  void navigateLeft() {
    setState(() {
      if (currentIndex == 0) {
        currentIndex = _photos.length - 1;
      } else {
        currentIndex = currentIndex - 1;
      }
    });
  }

  void navigateRight() {
    setState(() {
      if (currentIndex == _photos.length - 1) {
        currentIndex = 0;
      } else {
        currentIndex = currentIndex + 1;
      }
    });
  }
}
