import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/views/search/search_widgets/text_painter.dart';

import 'dart:ui' as ui;
import 'image_painter.dart';
import '../search_controller/search_results.dart';

///Displays NameResult.
class NameResultCard extends StatelessWidget {
  const NameResultCard({
    Key? key,
    required this.nameResult,
  }) : super(key: key);
  final NameResult nameResult;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background[300],
      child: Chip(
        backgroundColor: sunbirdOrange,
        label: Text(
          nameResult.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

///Displays DescriptionResult.
class DescriptionResultCard extends StatelessWidget {
  const DescriptionResultCard({
    Key? key,
    required this.descriptionResult,
  }) : super(key: key);
  final DescriptionResult descriptionResult;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background[300],
      child: Chip(
        backgroundColor: sunbirdOrange,
        label: Text(
          descriptionResult.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

///Displays ContainerTagResult.
class ContainerTagResultCard extends StatelessWidget {
  const ContainerTagResultCard({
    Key? key,
    required this.containerTagResult,
  }) : super(key: key);
  final ContainerTagResult containerTagResult;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background[300],
      child: Chip(
        backgroundColor: sunbirdOrange,
        label: Text(
          containerTagResult.tag,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

///Displays PhotoLabelResult.
class PhotoLabelResultCard extends StatelessWidget {
  const PhotoLabelResultCard({
    Key? key,
    required this.photoLabelResult,
  }) : super(key: key);
  final PhotoLabelResult photoLabelResult;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background[300],
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.file(
              File(photoLabelResult.photo.getPhotoPath()),
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chip(
                backgroundColor: sunbirdOrange,
                label: Text(
                  photoLabelResult.photoLabel,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///Displays ObjectLabelResult.
class ObjectLabelResultCard extends StatelessWidget {
  const ObjectLabelResultCard({
    Key? key,
    required this.result,
  }) : super(key: key);
  final ObjectLabelResult result;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background[300],
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          FutureBuilder<ui.Image>(
            future: getUiImage(result.photo.getPhotoPath()),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: CustomPaint(
                    size: const Size(100, 100),
                    painter: ImagePainter(
                      result.mlObject,
                      snapshot.data!,
                      result.photo.photoSize,
                    ),
                  ),
                );
              } else {
                return const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chip(
                backgroundColor: sunbirdOrange,
                label: Text(
                  result.objectLabel,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///Displays MLPhotoLabelResult.
class MLPhotoLabelResultCard extends StatelessWidget {
  const MLPhotoLabelResultCard({
    Key? key,
    required this.mlphotoLabelResult,
  }) : super(key: key);
  final MLPhotoLabelResult mlphotoLabelResult;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background[300],
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.file(
              File(mlphotoLabelResult.photo.getPhotoPath()),
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chip(
                backgroundColor: sunbirdOrange,
                label: Text(
                  mlphotoLabelResult.mlPhotoLabel,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///Displays MLObjectLabelResult.
class MLObjectLabelResultCard extends StatelessWidget {
  const MLObjectLabelResultCard({
    Key? key,
    required this.result,
  }) : super(key: key);
  final MLObjectLabelResult result;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background[300],
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          FutureBuilder<ui.Image>(
            future: getUiImage(result.photo.getPhotoPath()),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: CustomPaint(
                    size: const Size(150, 150),
                    painter: ImagePainter(
                      result.mlObject,
                      snapshot.data!,
                      result.photo.photoSize,
                    ),
                  ),
                );
              } else {
                return const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chip(
                backgroundColor: sunbirdOrange,
                label: Text(
                  result.mlObjectLabel,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///Displays MLTextElementResult.
class MLTextElementResultCard extends StatelessWidget {
  const MLTextElementResultCard({
    Key? key,
    required this.result,
  }) : super(key: key);
  final MLTextResult result;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: background[300],
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          FutureBuilder<ui.Image>(
            future: getUiImage(result.photo.getPhotoPath()),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: CustomPaint(
                    size: const Size(100, 100),
                    painter: MLTextPainter(
                      result.mlTextElement,
                      snapshot.data!,
                      result.photo.photoSize,
                    ),
                  ),
                );
              } else {
                return const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chip(
                backgroundColor: sunbirdOrange,
                label: Text(
                  result.mlText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<ui.Image> getUiImage(String imageAssetPath) async {
  final decodedImage = File(imageAssetPath).readAsBytesSync();

  final codec = await ui.instantiateImageCodec(
    decodedImage,
  );

  return (await codec.getNextFrame()).image;
}
