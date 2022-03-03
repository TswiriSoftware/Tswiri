import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:provider/provider.dart';

import '../../../objects/tags_change_notifier.dart';

class BarcodePhotoView extends StatefulWidget {
  const BarcodePhotoView(
      {Key? key, required this.photoPath, required this.photoTags})
      : super(key: key);
  final String photoPath;
  final List<String> photoTags;
  @override
  State<BarcodePhotoView> createState() => _BarcodePhotoViewState();
}

class _BarcodePhotoViewState extends State<BarcodePhotoView> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: deepSpaceSparkle,
          title: const Text(
            'Barcode',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          elevation: 3,
        ),
        body: Builder(
          builder: (context) {
            if (widget.photoPath != '') {
              return Column(children: [
                Image.file(File(widget.photoPath)),
                const Text('Tags: '),
                Text(
                  widget.photoTags.toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ]);
            } else {
              return Text('No Photo Yet');
            }
          },
        ));
  }
}
