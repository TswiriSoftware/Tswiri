import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:provider/provider.dart';

import '../../../objects/change_notifiers.dart';
import '../../objectIdentifier/object_detector_view.dart';

class BarcodePhotoView extends StatefulWidget {
  const BarcodePhotoView({Key? key, required this.barcodeID}) : super(key: key);
  final int barcodeID;
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

  List itemList = ['a', 'b'];
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> photos = [];

    Map<String, List<String>> x =
        Provider.of<PhotoDataChangeNotifier>(context).barcodePhotoData ?? {};
    x.forEach((key, value) {
      photos.add(PhotoItem(
        photoPath: key,
        photoTags: value,
        barcodeID: widget.barcodeID,
      ));
    });

    return Container(
        width: double.infinity,
        //height: 150,
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: deepSpaceSparkle[200],
          border: Border.all(color: Colors.white60, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Photos',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ObjectDetectorView(barcodeID: widget.barcodeID),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline_outlined)),
                ],
              ),
              for (Widget x in photos) x,
            ],
          ),
        ));
  }
}

class PhotoItem extends StatelessWidget {
  const PhotoItem(
      {Key? key,
      required this.photoPath,
      required this.photoTags,
      required this.barcodeID})
      : super(key: key);
  final int barcodeID;
  final String photoPath;
  final List<String> photoTags;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      //height: 150,
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      decoration: BoxDecoration(
        color: deepSpaceSparkle[200],
        border: Border.all(color: Colors.white60, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<PhotoDataChangeNotifier>(context,
                              listen: false)
                          .deletePhoto(barcodeID, photoPath);
                    },
                    child: const Icon(Icons.delete),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                            color: Colors.teal,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.25,
                  child: Text(photoTags.toString()),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoScreen2(photoPath: photoPath),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(0.8),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: deepSpaceSparkle[200],
                border: Border.all(color: Colors.black45, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Image.file(
                File(photoPath),
                width: width * 0.1,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PhotoScreen extends StatelessWidget {
  const PhotoScreen(this.photoPath);
  final String photoPath;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.all(0.8),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: deepSpaceSparkle[200],
            border: Border.all(color: Colors.black45, width: 2),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Image.file(
            File(photoPath),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}

class PhotoScreen2 extends StatelessWidget {
  const PhotoScreen2({required this.photoPath});
  final String photoPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Hero(tag: 'imageHero', child: Image.file(File(photoPath))),
            ),
            Text('Tap to close'),
          ],
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
