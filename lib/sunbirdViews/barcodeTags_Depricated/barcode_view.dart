import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:hive/hive.dart';

import '../barcodes/new_tag.dart';

class BarcodeView extends StatefulWidget {
  BarcodeAndTagData barcodeAndTagData;
  BarcodeView({Key? key, required this.barcodeAndTagData}) : super(key: key);

  @override
  _BarcodeViewState createState() => _BarcodeViewState();
}

class _BarcodeViewState extends State<BarcodeView> {
  List<String> allTags = ['+'];
  List<String> currentBarcodeTags = [];
  @override
  void initState() {
    runFilter('');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: deepSpaceSparkle,
        title:
            Text('Barcode:  ' + widget.barcodeAndTagData.barcodeID.toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          barcodeData(widget.barcodeAndTagData),
          assignedTags(),
          unAssignedTags(),
        ],
      ),
    );
  }

  Future<void> runFilter(String enteredKeyword) async {
    Box tagsBox = await Hive.openBox(tagsBoxName);

    Box<BarcodeTagEntry> currentTagsBox =
        await Hive.openBox(barcodeTagsBoxName);

    List<BarcodeTagEntry> barcodesAssignedTags = currentTagsBox.values
        .toList()
        .where((element) =>
            element.barcodeID == widget.barcodeAndTagData.barcodeID)
        .toList();

    List<String> assignedTags = [];
    for (BarcodeTagEntry barcodeTag in barcodesAssignedTags) {
      assignedTags.add(barcodeTag.tag);
    }

    //List of all barcodes and assigned Tags.
    List tagEntries = tagsBox.values.toList();
    //The DisplayList.
    List<String> results = [];

    for (String tagEntry in tagEntries) {
      if (!assignedTags.contains(tagEntry)) {
        results.add(tagEntry);
      }
    }

    if (enteredKeyword.isNotEmpty) {
      results = results
          .where((element) =>
              element.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    results.add('+');
    // Refresh the UI
    setState(() {
      allTags = results;
    });
  }

  Future<List<String>> getCurrentBarcodeTags(int currentBarcode) async {
    List<String> currentBarcodeTags = [];
    Box<BarcodeTagEntry> barcodeTagsBox =
        await Hive.openBox(barcodeTagsBoxName);
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

  ///This displays all tags assigned to the current barcode
  assignedTags() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: deepSpaceSparkle[200],
        border: Border.all(color: Colors.white60, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Wrap(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5, left: 10),
            child: Text(
              'Assigned Tags',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Container(
              padding: const EdgeInsets.all(3),
              width: double.infinity,
              height: 100,
              child: FutureBuilder<List>(
                  future:
                      getCurrentBarcodeTags(widget.barcodeAndTagData.barcodeID),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      List data = snapshot.data!;
                      return SingleChildScrollView(
                        child: Wrap(
                          children: data
                              .map((item) => tagContainerAssignedTags(
                                  item,
                                  widget.barcodeAndTagData.barcodeID
                                      .toString()))
                              .toList()
                              .cast<Widget>(),
                        ),
                      );
                    }
                  })),
        ],
      ),
    );
  }

  InkWell tagContainerAssignedTags(
    String tag,
    String barcodeID,
  ) {
    return InkWell(
      onTap: () async {
        Box<BarcodeTagEntry> barcodeTagsBox =
            await Hive.openBox(barcodeTagsBoxName);
        barcodeTagsBox.delete('${barcodeID}_$tag');
        setState(() {
          runFilter('');
        });
      },
      child: UnconstrainedBox(
        child: Container(
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.only(left: 14, right: 14),
          height: 35,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Center(
            child: Text(
              tag,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  //Convert to Future Builder

  unAssignedTags() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: deepSpaceSparkle[200],
        border: Border.all(color: Colors.white60, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: TextField(
              onChanged: (value) => runFilter(value),
              scrollPadding: const EdgeInsets.only(bottom: 40),
              decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: deepSpaceSparkle)),
                  hoverColor: deepSpaceSparkle[700],
                  focusColor: deepSpaceSparkle[700],
                  contentPadding: const EdgeInsets.all(10),
                  labelStyle: const TextStyle(color: Colors.white),
                  labelText: 'Search Tags',
                  suffixIcon: Icon(
                    Icons.search,
                    color: deepSpaceSparkle[700],
                  )),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Container(
            padding: const EdgeInsets.all(3),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Wrap(
                children: allTags
                    .map((tag) => tagContainerUnAssignedTags(
                        tag, widget.barcodeAndTagData.barcodeID.toString()))
                    .toList(),
                // barcodeAndTagData.tags!.map((e) => tagContainer(e)).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell tagContainerUnAssignedTags(String tag, String barcodeID) {
    Color color;

    if (tag == '+') {
      color = deeperOrange;
    } else {
      color = Colors.white;
    }

    return InkWell(
      onTap: () async {
        if (tag == '+') {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewTagView()))
              .then((value) => runFilter(''));
        } else {
          Box<BarcodeTagEntry> barcodeTagsBox =
              await Hive.openBox(barcodeTagsBoxName);
          barcodeTagsBox.put('${barcodeID}_$tag',
              BarcodeTagEntry(barcodeID: int.parse(barcodeID), tag: tag));

          setState(() {
            runFilter('');
          });
        }
      },
      child: UnconstrainedBox(
        child: Container(
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.only(left: 14, right: 14),
          height: 35,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Center(
            child: Text(
              tag,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

barcodeData(BarcodeAndTagData barcodeAndTagData) {
  return Container(
    width: double.infinity,
    height: 100,
    margin: const EdgeInsets.only(bottom: 5, top: 5),
    decoration: BoxDecoration(
      color: deepSpaceSparkle[200],
      border: Border.all(color: Colors.white60, width: 2),
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5, left: 10),
          child: Text(
            'Barcode Data',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 10),
          child: Text('Barcode ID:  ' + barcodeAndTagData.barcodeID.toString()),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5, left: 10),
          child: Text('Barcode Size:  ?? '),
        )
      ],
    ),
  );
}
