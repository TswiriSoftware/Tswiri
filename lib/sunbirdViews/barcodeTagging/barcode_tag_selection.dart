import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:hive/hive.dart';

class BarcodeTaggingView extends StatefulWidget {
  BarcodeAndTagData barcodeAndTagData;
  BarcodeTaggingView({Key? key, required this.barcodeAndTagData})
      : super(key: key);

  @override
  _BarcodeTaggingViewState createState() => _BarcodeTaggingViewState();
}

class _BarcodeTaggingViewState extends State<BarcodeTaggingView> {
  int currentBarcodeID = 0;
  List<BarcodeAndTagData> barcodeAndTagData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepSpaceSparkle,
        title: Text(
            'Barcode ID: ' + widget.barcodeAndTagData.barcodeID.toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [assignedTags(widget.barcodeAndTagData)],
      ),
    );
  }
}

Future<List<String>> getAllTags() async {
  List<String> possibleTags = [];
  Box<String> allTags = await Hive.openBox(tagsBoxName);
  addTagsIfBoxIsEmpty(allTags);

  Set<String> tags = allTags.values.toSet();

  for (String tag in tags) {
    possibleTags.add(tag);
  }

  return possibleTags;
}

void addTagsIfBoxIsEmpty(Box<dynamic> allTags) {
  if (allTags.isEmpty) {
    for (String tag in Tags) {
      allTags.put(tag, tag);
    }
  }
}

Future<List<String>> getCurrentBarcodeTags(int currentBarcode) async {
  List<String> currentBarcodeTags = [];
  Box<BarcodeTagEntry> barcodeTagsBox = await Hive.openBox(barcodeTagsBoxName);
  Set<BarcodeTagEntry> barcodeTags = barcodeTagsBox.values
      .toSet()
      .where((element) => element.barcodeID == currentBarcode)
      .toSet();
  barcodeTagsBox.close();

  for (BarcodeTagEntry barcodeTag in barcodeTags) {
    if (barcodeTag.barcodeID == currentBarcode) {
      currentBarcodeTags.add(barcodeTag.tag);
    }
  }

  return currentBarcodeTags;
}

List<String> Tags = [
  'Tools',
  'Chemical A',
  'Chemical B',
  'Paper Work',
  'stuffies5',
  'stuffies6',
  'stuffies7',
  'stuffies8',
  'stuffies9',
  'stuffies10',
  'stuffies11',
  'stuffies12',
  'stuffies13',
];

assignedTags(BarcodeAndTagData barcodeAndTagData) {
  return Container(
    width: double.infinity,
    height: 250,
    margin: const EdgeInsets.only(bottom: 5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white60, width: 2),
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    child: Column(
      children: const [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              'Assigned Tags',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Divider(
          color: Colors.white,
        ),
      ],
    ),
  );
}
