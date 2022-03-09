import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/all_barcode_data.dart';
import 'package:hive/hive.dart';
import '../../databaseAdapters/scanningAdapter/real_barocode_position_entry.dart';
import 'barcode_camera_navigator_view.dart';

class BarcodeSelectionView extends StatefulWidget {
  const BarcodeSelectionView({Key? key}) : super(key: key);

  @override
  _BarcodeSelectionViewState createState() => _BarcodeSelectionViewState();
}

class _BarcodeSelectionViewState extends State<BarcodeSelectionView> {
  List<AllBarcodeData> _foundBarcodes = [];

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
          title: const Text(
            'Barcode Navigator',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            TextField(
              onChanged: (value) => runFilter(value),
              decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hoverColor: deepSpaceSparkle[700],
                  focusColor: deepSpaceSparkle[700],
                  contentPadding: const EdgeInsets.all(10),
                  labelStyle: const TextStyle(color: Colors.white),
                  labelText: 'Search',
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _foundBarcodes.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: refresh,
                      child: ListView.builder(
                          itemCount: _foundBarcodes.length,
                          itemBuilder: (context, index) {
                            return displayDataPointWidget(
                              context,
                              _foundBarcodes[index],
                            );
                          }),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ));
  }

  Future<void> refresh() async {
    setState(() {
      runFilter('');
    });
  }

  Future<void> runFilter(String enteredKeyword) async {
    Box<RealBarcodePostionEntry> realPositionDataBox =
        await Hive.openBox(realPositionsBoxName);
    //Box that contains all barcodes and Tags assigned to them.
    Box<BarcodeTagEntry> barcodeTagsBox =
        await Hive.openBox(barcodeTagsBoxName);
    //List of all scanned barcodes.
    List<RealBarcodePostionEntry> realBarcodesPositions =
        realPositionDataBox.values.toList();

    //List of all barcodes and assigned Tags.
    List<BarcodeTagEntry> barcodesAssignedTags = barcodeTagsBox.values.toList();

    //The DisplayList.
    List<AllBarcodeData> results = [];

    for (RealBarcodePostionEntry realBarcodePosition in realBarcodesPositions) {
      //To set to remove any duplicates if there are any.
      Set<BarcodeTagEntry> relevantBarcodeTagEntries = barcodesAssignedTags
          .where((element) => element.id == int.parse(realBarcodePosition.uid))
          .toSet();

      //List containing all tags relevant to current barcode.
      List<String> relevantTags =
          getRelevantBarcodes(relevantBarcodeTagEntries);

      results.add(AllBarcodeData(
          barcodeID: int.parse(realBarcodePosition.uid),
          barcodeSize: 70.0,
          isFixed: false,
          tags: relevantTags));
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

  List<String> getRelevantBarcodes(
      Set<BarcodeTagEntry> relevantBarcodeTagEntries) {
    List<String> relevantTags = [];
    for (BarcodeTagEntry barcodeTag in relevantBarcodeTagEntries) {
      relevantTags.add(barcodeTag.tag);
    }
    return relevantTags;
  }

  displayDataPointWidget(
      BuildContext context, AllBarcodeData barcodeAndTagData) {
    Color color;

    color = deeperOrange;

    return InkWell(
      onTap: () {
        Hive.close();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BarcodeCameraNavigatorView(
                    barcodeID: barcodeAndTagData.barcodeID.toString())));
      },
      child: Container(
        //Outer Container Decoration
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white60, width: 0.8),
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
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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

  //Checks if the barcode has any tags
  String checkIfEmpty(List<String> listOfTags) {
    String tags = '';

    if (listOfTags.isEmpty) {
      tags = 'WoW much empty';
    } else {
      tags = listOfTags.toString().replaceAll(']', '').replaceAll('[', '');
    }
    return tags;
  }
}
