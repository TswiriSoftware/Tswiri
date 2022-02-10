import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeTagging/new_tag.dart';
import 'package:hive/hive.dart';
import 'package:simple_tags/simple_tags.dart';

class BarcodeTaggingView extends StatefulWidget {
  String title;
  BarcodeTaggingView({Key? key, required this.title}) : super(key: key);

  @override
  _BarcodeTaggingViewState createState() => _BarcodeTaggingViewState();
}

class _BarcodeTaggingViewState extends State<BarcodeTaggingView> {
  int currentBarcodeID = 0;
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    currentBarcodeID = int.parse(widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepSpaceSparkle,
        title: Text('Barcode ID: ' + widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Current Tags
          Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white60, width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            width: double.infinity,
            height: 300,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: deepSpaceSparkle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Barcode Tags',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<String>>(
                      future: getCurrentBarcodeTags(currentBarcodeID),
                      builder: (context, snapshot) {
                        List<String> content = snapshot.data ?? [];
                        return Container(
                          height: 250,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: content.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () async {
                                    Box<BarcodeTagEntry> barcodeTagsBox =
                                        await Hive.openBox(barcodeTagsBoxName);
                                    barcodeTagsBox.delete(
                                        '${currentBarcodeID}_${content[index]}');

                                    setState(() {});
                                  },
                                  title: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white60, width: 2),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        content[index],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                ),
              ],
            ),
          ),
          //Tags
          Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white60, width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.5,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: deepSpaceSparkle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Tags',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<String>>(
                      future: getAllTags(),
                      builder: (context, snapshot) {
                        List<String> content = snapshot.data ?? [];
                        return Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: content.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () async {
                                    Box<BarcodeTagEntry> barcodeTagsBox =
                                        await Hive.openBox(barcodeTagsBoxName);
                                    barcodeTagsBox.put(
                                        '${currentBarcodeID}_${content[index]}',
                                        BarcodeTagEntry(
                                            barcodeID: currentBarcodeID,
                                            tag: content[index]));

                                    setState(() {});
                                  },
                                  title: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white60, width: 2),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        content[index],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                ),
              ],
            ),
          ),
          //Add a Tag
          Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: deepSpaceSparkle,
              border: Border.all(color: Colors.white60, width: 2),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            width: double.infinity,
            height: 50,
            child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewTagView()));
                },
                child: Center(child: Icon(Icons.add))),
          )
        ],
      ),
    );
  }
}

Future<List<String>> getAllTags() async {
  List<String> possibleTags = [];
  Box<String> allTags = await Hive.openBox(tagsBoxName);
  addTagsIfBoxIsEmpty(allTags);
  print(allTags.length);
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
