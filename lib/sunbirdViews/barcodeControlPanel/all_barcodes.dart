import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/functions/barcodeTools/get_data_functions.dart';
import 'package:flutter_google_ml_kit/functions/barcodeTools/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/all_barcode_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/barcode_control_panel.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/scan_barcode_view.dart';
import 'package:hive/hive.dart';

import '../../globalValues/global_hive_databases.dart';

class AllBarcodesView extends StatefulWidget {
  const AllBarcodesView({Key? key}) : super(key: key);

  @override
  _AllBarcodesViewState createState() => _AllBarcodesViewState();
}

class _AllBarcodesViewState extends State<AllBarcodesView> {
  List<AllBarcodeData> foundBarcodes = [];
  List<String> unassignedTags = [];

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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.qr_code,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScanBarcodeView(
                            color: deepSpaceSparkle,
                          )));
            },
          )
        ],
      ),
      body: Column(
        children: [
          searchBar(context),
          const SizedBox(height: 10),
          Text('swipe to delete'),
          const SizedBox(height: 10),
          Expanded(
            child: foundBarcodes.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: foundBarcodes.length,
                    itemBuilder: (context, index) {
                      final foundBarcode = foundBarcodes[index];
                      return Dismissible(
                        key: Key(foundBarcode.barcodeID.toString()),
                        onDismissed: (direction) {
                          deleteBarcode(foundBarcode.barcodeID);
                          // Remove the item from the data source.
                          setState(() {
                            foundBarcodes.removeAt(index);
                          });

                          // // Then show a snackbar.
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text(
                          //         'Barcode: ${foundBarcode.barcodeID} Deleted')));
                        },
                        child: displayBarcodeDataWidget(
                            context, foundBarcodes[index], runFilter('')),
                      );
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

  void deleteBarcode(int barcodeID) async {
    //Open generatedBarcodesBox.
    Box<BarcodeDataEntry> generatedBarcodesBox =
        await Hive.openBox(allBarcodesBoxName);
    if (barcodeID != 1) {
      generatedBarcodesBox.delete(barcodeID);
    } else {}
  }

  Future<void> runFilter(String enteredKeyword) async {
    //Gets a list of all generated Barcodes.
    List<BarcodeDataEntry> allBarcodes = [];
    allBarcodes.addAll(await getGeneratedBarcodes());

    //Gets a list of all barcodeTagEntries
    List<BarcodeTagEntry> barcodeTagEntries = await getAllBarcodeTags();

    //Filter results.
    List<AllBarcodeData> results = [];

    //Iterate through generatedBarcodes and compile all relevant data and tags into a list.
    for (BarcodeDataEntry barcodeData in allBarcodes) {
      //List containing all relevant barcode tags.
      List<String> relevantTags =
          findRelevantBarcodeTags(barcodeTagEntries, barcodeData);

      results.add(AllBarcodeData(
          barcodeID: barcodeData.barcodeID,
          barcodeSize: barcodeData.barcodeSize,
          isFixed: barcodeData.isFixed,
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

  ///This is the searchBar widge where you can search for ID or Tags.
  TextField searchBar(BuildContext context) {
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

///Displays a inkwell widget containing the barcodeID and all relevant tags.
InkWell displayBarcodeDataWidget(
  BuildContext context,
  AllBarcodeData barcodeAndTagData,
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
    onTap: () async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BarcodeControlPanelView(
                    barcodeID: barcodeAndTagData.barcodeID,
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

///Checks if the barcode has any tags if false return "Wow such empty"
String checkIfEmpty(List<String> listOfTags) {
  String tags = '';

  if (listOfTags.isEmpty) {
    tags = 'WoW much empty';
  } else {
    tags = listOfTags.toString().replaceAll(']', '').replaceAll('[', '');
  }
  return tags;
}
