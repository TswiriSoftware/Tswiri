import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:hive/hive.dart';

import '../../../databaseAdapters/barcodePhotos/barcode_photo_entry.dart';
import '../../../globalValues/global_hive_databases.dart';

class BarcodePhotoView extends StatefulWidget {
  const BarcodePhotoView({Key? key, required this.barcodeID}) : super(key: key);
  final int barcodeID;
  @override
  State<BarcodePhotoView> createState() => _BarcodePhotoViewState();
}

class _BarcodePhotoViewState extends State<BarcodePhotoView> {
  List<String> photoTags = [];

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
      body: FutureBuilder<File?>(
        future: getCurrentBarcodePhoto(widget.barcodeID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Image.file(snapshot.data!),
                const Text('Tags: '),
                Text(
                  photoTags.toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            );
          } else {
            return const Center(child: Text('no photo'));
          }
        },
      ),
    );
  }

  Future<File?> getCurrentBarcodePhoto(int barcodeID) async {
    //Get all barcode photos.
    Box<BarcodePhotoEntry> barcodePhotoEntries =
        await Hive.openBox(barcodePhotosBoxName);

    //Declaire BarcodePhotoEntry
    late BarcodePhotoEntry barcodePhotoEntry;

    if (barcodePhotoEntries.get(widget.barcodeID) != null) {
      barcodePhotoEntry = barcodePhotoEntries.get(widget.barcodeID)!;
      String photoPath = barcodePhotoEntry.photoPath;
      File photoFile = File(photoPath);

      setState(() {
        photoTags = barcodePhotoEntry.photoTags;
      });

      return photoFile;
    }

    return null;
  }
}
