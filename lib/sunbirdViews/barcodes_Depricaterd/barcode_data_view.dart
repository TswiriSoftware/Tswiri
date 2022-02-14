import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/functions/barcodeTools/get_data_functions.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeTags_Depricated/barcode_view.dart';
import 'package:hive/hive.dart';

import 'new_tag.dart';

class BarcodeDataView extends StatefulWidget {
  BarcodeAndTagData barcodeAndTagData;
  BarcodeDataView({Key? key, required this.barcodeAndTagData})
      : super(key: key);

  @override
  _BarcodeDataViewState createState() => _BarcodeDataViewState();
}

class _BarcodeDataViewState extends State<BarcodeDataView> {
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
          assignedTags(widget.barcodeAndTagData.barcodeID),
          unAssignedTags(),
        ],
      ),
    );
  }

  Future<void> runFilter(String enteredKeyword) async {
    //Get tags assignedTags
    List<String> assignedTags =
        await getAssignedTags(widget.barcodeAndTagData.barcodeID);

    //List of all tags that have not been assigned to the current tag
    List<String> results = await getSearchResults(assignedTags);

    //Filter search results.
    if (enteredKeyword.isNotEmpty) {
      results = results
          .where((element) =>
              element.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    //Adds the + button
    results.add('+');

    // Refresh the UI
    setState(() {
      allTags = results;
    });
  }

  ///This displays all tags assigned to the current barcode
  assignedTags(int barcodeID) {
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
                  future: getCurrentBarcodeTags(barcodeID),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      List data = snapshot.data!;
                      return SingleChildScrollView(
                        child: Wrap(
                          children: data
                              .map((item) => assignedTagContainer(
                                  item, barcodeID.toString()))
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

  ///This displays all unassigned tags.
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

  ///Contains a single tag.
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

  ///This contains a single assigned tag.
  InkWell assignedTagContainer(String tag, String barcodeID) {
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
}
