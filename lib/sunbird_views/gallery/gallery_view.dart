import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/photo_view.dart';
import 'package:isar/isar.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  List<ContainerPhoto> photos = [];

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
    });
  }

  Widget photoCard(ContainerPhoto containerPhoto) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoView(
                containerPhoto: containerPhoto,
                containerColor: sunbirdOrange,
              ),
            ),
          );
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

  void updatePhotos() {
    setState(() {
      photos = isarDatabase!.containerPhotos.where().findAllSync();
    });
  }
}
