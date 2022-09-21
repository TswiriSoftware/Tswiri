import 'dart:developer';
import 'dart:io';
import 'package:tswiri/views/photo/photo_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:tswiri_database/export.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  late List<Photo> photos = isar!.photos.where().findAllSync();

  bool showObjects = true;
  bool showText = false;

  bool isAddingPhotoLabel = false;
  bool isAddingObjectLabel = false;

  int? selectedPhotoIndex;
  Photo? _photo;

  final GlobalKey<PhotoEditViewState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      resizeToAvoidBottomInset: true,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Gallery',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      actions: [
        Visibility(
          visible: selectedPhotoIndex != null,
          child: IconButton(
            onPressed: () => _deselectPhoto(),
            icon: const Icon(Icons.close_sharp),
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return selectedPhotoIndex != null ? _photoEdit() : _gridView();
  }

  Widget _gridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return _gridCard(photos[index], index);
      },
    );
  }

  Widget _gridCard(Photo photo, int index) {
    return GestureDetector(
      onTap: () => _selectPhoto(index),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(photo.getPhotoThumbnailPath()),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _photoEdit() {
    return PhotoEditView(
      key: _key,
      photo: _photo!,
      onLeft: () {
        setState(() {
          if (selectedPhotoIndex == 0) {
            selectedPhotoIndex = photos.length - 1;
          } else {
            selectedPhotoIndex = selectedPhotoIndex! - 1;
          }
        });
        _updatePhoto();
        // log('left');
      },
      onRight: () {
        setState(() {
          if (selectedPhotoIndex == photos.length - 1) {
            selectedPhotoIndex = 0;
          } else {
            selectedPhotoIndex = selectedPhotoIndex! + 1;
          }
        });
        _updatePhoto();
      },
      navigationEnabeld: true,
    );
  }

  ///Sets the Photo Index.
  void _selectPhoto(int index) {
    setState(() {
      selectedPhotoIndex = index;
      isAddingPhotoLabel = false;
      isAddingObjectLabel = false;
    });
    _updatePhoto();
  }

  ///Updates the displayed Photo.
  void _updatePhoto() {
    setState(() {
      //get the photo.
      _photo = photos[selectedPhotoIndex!];
      _key.currentState?.updatePhoto(_photo!);
      isAddingPhotoLabel = false;
      isAddingObjectLabel = false;
    });
  }

  ///Deselects the Photo.
  void _deselectPhoto() {
    setState(() {
      selectedPhotoIndex = null;
      isAddingPhotoLabel = false;
      isAddingObjectLabel = false;
    });
  }
}
