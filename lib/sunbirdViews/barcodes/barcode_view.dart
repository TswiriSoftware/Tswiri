import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:hive/hive.dart';

import 'barcode_tag_selection.dart';

class BarcodesView extends StatefulWidget {
  const BarcodesView({Key? key}) : super(key: key);

  @override
  _BarcodesViewState createState() => _BarcodesViewState();
}

class _BarcodesViewState extends State<BarcodesView> {
  List<String> allTags = [];
  List<BarcodeAndTagData> _foundBarcodes = [];
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
        appBar: AppBar(
          backgroundColor: deepSpaceSparkle,
          title: const Text(
            'Barcodes',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            TextField(
              onChanged: (value) => runFilter(value),
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: deepSpaceSparkleBright)),
                  hoverColor: deepSpaceSparkleBright,
                  focusColor: deepSpaceSparkleBright,
                  contentPadding: EdgeInsets.all(10),
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Search',
                  suffixIcon: Icon(
                    Icons.search,
                    color: deepSpaceSparkleBright,
                  )),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _foundBarcodes.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundBarcodes.length,
                      itemBuilder: (context, index) {
                        return displayDataPointWidget(
                          context,
                          _foundBarcodes[index],
                        );
                      })
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ));
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }

  Future<void> runFilter(String enteredKeyword) async {
    Box<RealBarcodePostionEntry> realPositionDataBox =
        await Hive.openBox(realPositionDataBoxName);
    //Box that contains all barcodes and Tags assigned to them.
    Box<BarcodeTagEntry> barcodeTagsBox =
        await Hive.openBox(barcodeTagsBoxName);
    //List of all scanned barcodes.
    List<RealBarcodePostionEntry> realBarcodesPositions =
        realPositionDataBox.values.toList();
    //List of all barcodes and assigned Tags.
    List<BarcodeTagEntry> barcodesAssignedTags = barcodeTagsBox.values.toList();

    //The DisplayList.
    List<BarcodeAndTagData> results = [];

    for (RealBarcodePostionEntry realBarcodePosition in realBarcodesPositions) {
      //To set to remove any duplicates if there are any.
      Set<BarcodeTagEntry> relevantBarcodeTagEntries = barcodesAssignedTags
          .where((element) =>
              element.barcodeID == int.parse(realBarcodePosition.uid))
          .toSet();

      //List containing all tags relevant to current barcode.
      List<String> relevantTags =
          getRelevantBarcodes(relevantBarcodeTagEntries);

      results.add(BarcodeAndTagData(
          barcodeID: int.parse(realBarcodePosition.uid), tags: relevantTags));
      results.sort((a, b) => a.barcodeID.compareTo(b.barcodeID));
    }

    if (enteredKeyword.isNotEmpty) {
      results = results
          .where((element) =>
              element.barcodeID
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword) ||
              element.tags
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundBarcodes = results;
    });
  }
}

List<String> getRelevantBarcodes(
    Set<BarcodeTagEntry> relevantBarcodeTagEntries) {
  List<String> relevantTags = [];
  for (BarcodeTagEntry barcodeTag in relevantBarcodeTagEntries) {
    relevantTags.add(barcodeTag.tag);
  }
  return relevantTags;
}

displayDataPointWidget(
    BuildContext context, BarcodeAndTagData barcodeAndTagData) {
  return InkWell(
    onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => BarcodeView(
              barcodeAndTagData: barcodeAndTagData,
            )),
    child: Container(
      //Outer Container Decoration
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white60, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          //Barcode ID
          Container(
            margin: const EdgeInsets.all(4),
            height: 60,
            width: (MediaQuery.of(context).size.width * 0.13),
            decoration: const BoxDecoration(
                color: deepSpaceSparkle, shape: BoxShape.circle),
            child: Center(
              child: Text(barcodeAndTagData.barcodeID.toString()),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            height: 55,
            width: (MediaQuery.of(context).size.width * 0.82),
            child: Center(
              child: Text(
                checkIfEmpty(barcodeAndTagData.tags!),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

displayDataHeaderWidget(BuildContext context, List<String> dataHeader) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white60, width: 0.5),
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(dataHeader[0]),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, right: 150),
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(dataHeader[1]),
          ),
        )
      ],
    ),
  );
}

String checkIfEmpty(List<String> listOfTags) {
  String tags = '';

  if (listOfTags.isEmpty) {
    tags = 'wow such empty';
  } else {
    tags = listOfTags.toString().replaceAll(']', '').replaceAll('[', '');
  }
  print(tags);
  return tags;
}
