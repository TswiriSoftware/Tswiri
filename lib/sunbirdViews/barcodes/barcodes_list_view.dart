import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/functions/barcodeTools/get_data_functions.dart';
import 'package:flutter_google_ml_kit/functions/barcodeTools/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodes/barcode_data_view.dart';
import 'package:hive/hive.dart';

class BarcodesListView extends StatefulWidget {
  const BarcodesListView({Key? key}) : super(key: key);

  @override
  _BarcodesViewListState createState() => _BarcodesViewListState();
}

class _BarcodesViewListState extends State<BarcodesListView> {
  List<BarcodeAndTagData> foundBarcodes = [];

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
          searchBar(context),
          const SizedBox(height: 10),
          Expanded(
            child: foundBarcodes.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: foundBarcodes.length,
                    itemBuilder: (context, index) {
                      return displayBarcodeDataWidget(
                          context, foundBarcodes[index], runFilter(''));
                    })
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> runFilter(String enteredKeyword) async {
    //Gets a list of all generated Barcodes.
    List<BarcodeDataEntry> generatedBarcodes = [];
    generatedBarcodes.addAll(await getGeneratedBarcodes());

    //Gets a list of all barcodeTagEntries
    List<BarcodeTagEntry> barcodeTagEntries = await getAllBarcodeTags();

    //Filter results.
    List<BarcodeAndTagData> results = [];

    //Iterate through generatedBarcodes and compile all relevant data and tags into a list.
    for (BarcodeDataEntry barcodeData in generatedBarcodes) {
      //List containing all relevant barcode tags.
      List<String> relevantTags =
          findRelevantBarcodeTags(barcodeTagEntries, barcodeData);

      results.add(BarcodeAndTagData(
          barcodeID: barcodeData.barcodeID,
          barcodeSize: barcodeData.barcodeSize,
          tags: relevantTags));

      results.sort((a, b) => a.barcodeID.compareTo(b.barcodeID));
    }

    if (enteredKeyword.isNotEmpty) {
      //The search algorithm.
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

    //Refresh the UI
    setState(() {
      foundBarcodes = results;
    });
  }

  searchBar(BuildContext context) {
    return TextField(
      onChanged: (value) {
        runFilter(value);
      },
      onEditingComplete: () => hideKeyboard(context),
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
    );
  }
}

//Displays a inkwell widget containing the barcodeID and
displayBarcodeDataWidget(
  BuildContext context,
  BarcodeAndTagData barcodeAndTagData,
  Future<void> runFilter,
) {
  //Create a Color Pattern.
  Color color;
  if (barcodeAndTagData.barcodeID.isEven) {
    color = darkPinkish;
  } else {
    color = deepSpaceSparkle;
  }

  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BarcodeDataView(
                    barcodeAndTagData: barcodeAndTagData,
                  ))).then((value) => runFilter);
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
