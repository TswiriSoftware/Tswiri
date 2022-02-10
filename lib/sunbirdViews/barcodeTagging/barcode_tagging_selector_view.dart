import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeTagging/barcode_tag_selection.dart';
import 'package:hive/hive.dart';

class BarcodeSelectionTagView extends StatefulWidget {
  const BarcodeSelectionTagView({Key? key}) : super(key: key);

  @override
  _BarcodeSelectionTagViewState createState() =>
      _BarcodeSelectionTagViewState();
}

class _BarcodeSelectionTagViewState extends State<BarcodeSelectionTagView> {
  @override
  void initState() {
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
            'Barcode Tagging',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<BarcodeAndTagData>>(
                future: consolidateData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List<BarcodeAndTagData> barcodeAndTagData = snapshot.data!;

                    return RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: ListView.builder(
                          itemCount: barcodeAndTagData.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: <Widget>[
                                  displayDataHeader(['UID', 'Tags'], context),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  displayDataPointWidget(
                                    context,
                                    barcodeAndTagData[index],
                                  )
                                ],
                              );
                            } else {
                              return displayDataPointWidget(
                                context,
                                barcodeAndTagData[index],
                              );
                            }
                          }),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }

  Future<List<BarcodeAndTagData>> consolidateData() async {
    //Box containing all scanned barcodes.
    Box<RealBarcodePostionEntry> realPositionDataBox =
        await Hive.openBox(realPositionDataBoxName);
    //Box that contains all barcodes and Tags assigned to them.
    Box<BarcodeTagEntry> barcodeTagsBox =
        await Hive.openBox(barcodeTagsBoxName);
    //List of all scanned barcodes.
    List<RealBarcodePostionEntry> realBarcodesPositions =
        realPositionDataBox.values.toList();
    //List of all barcodes and Tags.
    List<BarcodeTagEntry> barcodeTags = barcodeTagsBox.values.toList();

    //The DisplayList.
    List<BarcodeAndTagData> displayList = [];

    for (RealBarcodePostionEntry realBarcodePosition in realBarcodesPositions) {
      //To set to remove any duplicates if there are any.
      Set<BarcodeTagEntry> relevantBarcodeTagEntries = barcodeTags
          .where((element) =>
              element.barcodeID == int.parse(realBarcodePosition.uid))
          .toSet();

      //List containing all tags relevant to current barcode.
      List<String> relevantTags =
          getRelevantBarcodes(relevantBarcodeTagEntries);

      displayList.add(BarcodeAndTagData(
          barcodeID: int.parse(realBarcodePosition.uid), tags: relevantTags));
    }
    //Sort the display list in descending order.
    displayList.sort((a, b) => a.barcodeID.compareTo(b.barcodeID));
    print(displayList);
    return displayList;
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
        builder: (BuildContext context) => BarcodeTaggingView(
              title: barcodeAndTagData.barcodeID.toString(),
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
              child: Text(checkIfEmpty(barcodeAndTagData.tags!)),
            ),
          )
        ],
      ),
    ),
  );
}

displayDataPoint(BarcodeAndTagData barcodeAndTagData, BuildContext context) {
  return Column(
    children: [
      InkWell(
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => BarcodeTaggingView(
                  title: barcodeAndTagData.barcodeID.toString(),
                )),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white60, width: 0.5),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          //padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        color: deepSpaceSparkle,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      barcodeAndTagData.barcodeID.toString(),
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    width: (MediaQuery.of(context).size.width - 1) * 0.15),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    checkIfEmpty(barcodeAndTagData.tags ?? []),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                  width: ((MediaQuery.of(context).size.width - 1) * 0.75),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      )
    ],
  );
}

displayDataHeader(List<String> dataHeader, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white60, width: 0.5),
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    //padding: EdgeInsets.all(5),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white60, width: 0.2),
            color: deepSpaceSparkle,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Text(
            dataHeader[0],
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          width: (MediaQuery.of(context).size.width - 1) * 0.2,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white60, width: 0.2),
              color: deepSpaceSparkle,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                dataHeader[1],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const Text(
                ' (hold to edit tags)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          width: (MediaQuery.of(context).size.width - 1) * 0.8,
        ),
      ],
    ),
  );
}

String checkIfEmpty(List<String> listOfTags) {
  String tags = '';
  if (tags.isEmpty) {
    tags = 'wow such empty';
  } else {
    tags = listOfTags.toString().replaceAll(']', '').replaceAll('[', '');
  }
  print(tags);
  return tags;
}
