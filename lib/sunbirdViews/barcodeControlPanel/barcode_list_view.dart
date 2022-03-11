import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/scan_barcode_view.dart';
import 'package:hive/hive.dart';

import '../../databaseAdapters/scanningAdapter/real_barocode_position_entry.dart';
import '../../databaseAdapters/shelfAdapter/shelf_entry.dart';
import '../../databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import '../../functions/barcodeTools/hide_keyboard.dart';
import '../../globalValues/global_hive_databases.dart';
import '../../objects/all_barcode_data.dart';
import 'barcode_control_panel.dart';
import 'widgets/barcode_display_widget.dart';

class BarcodeListView extends StatefulWidget {
  const BarcodeListView({Key? key, this.shelfEntry}) : super(key: key);

  ///Add this if you are looking for a specific shelf's barcodes.
  final ShelfEntry? shelfEntry;

  @override
  State<BarcodeListView> createState() => _BarcodeListViewState();
}

class _BarcodeListViewState extends State<BarcodeListView> {
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
        backgroundColor: Colors.deepOrange,
        title: Text(
          widget.shelfEntry!.name + "'s" + ' Boxes',
          style: const TextStyle(fontSize: 25),
        ),
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
                            color: Colors.deepOrange,
                          )));
            },
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          searchBar(context),
          const SizedBox(height: 5),
          const Text('Swipe down to refresh'),
          const SizedBox(height: 5),
          Expanded(
            child: _foundBarcodes.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.builder(
                        itemCount: _foundBarcodes.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              await navigateToControlPanel(context, index);
                            },
                            onLongPress: () {
                              //TODO: Implement delete functionality for boxes.
                            },
                            child: BarcodeDisplayWidget(
                              barcodeAndTagData: _foundBarcodes[index],
                            ),
                          );
                        }),
                  )
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> navigateToControlPanel(BuildContext context, int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BarcodeControlPanelView(
              barcodeID: _foundBarcodes[index].barcodeID)),
    );
    runFilter('');
  }

  Future<void> runFilter(String enteredKeyword) async {
    Box<RealBarcodePostionEntry> realPositionDataBox =
        await Hive.openBox(realPositionsBoxName);
    //Box that contains all barcodes and Tags assigned to them.
    Box<BarcodeTagEntry> barcodeTagsBox =
        await Hive.openBox(barcodeTagsBoxName);
    List<RealBarcodePostionEntry> realBarcodesPositions = [];
    //List of all scanned barcodes.
    realBarcodesPositions = realPositionDataBox.values
        .toList()
        .where((element) => element.shelfUID == widget.shelfEntry!.uid)
        .toList();

    if (realBarcodesPositions.isEmpty) {
      realBarcodesPositions = realPositionDataBox.values.toList();
    }

    log(realBarcodesPositions.toString());

    //List of all barcodes and assigned Tags.
    List<BarcodeTagEntry> barcodesAssignedTags = barcodeTagsBox.values.toList();

    //The DisplayList.
    List<AllBarcodeData> results = [];

    for (RealBarcodePostionEntry realBarcodePosition in realBarcodesPositions) {
      //To set to remove any duplicates if there are any.
      Set<BarcodeTagEntry> relevantBarcodeTagEntries = barcodesAssignedTags
          .where((element) => element.id == realBarcodePosition.uid)
          .toSet();

      //List containing all tags relevant to current barcode.
      List<String> relevantTags =
          getRelevantBarcodes(relevantBarcodeTagEntries);

      results.add(AllBarcodeData(
          barcodeID: realBarcodePosition.uid,
          barcodeSize: 70.0,
          isFixed: false,
          tags: relevantTags));

      results.sort((a, b) => a.barcodeID.compareTo(b.barcodeID));

      results.sort((a, b) => a.barcodeID.compareTo(b.barcodeID));
      results.sort((a, b) {
        if (int.tryParse(a.barcodeID) != null &&
            int.tryParse(b.barcodeID) != null) {
          return int.parse(a.barcodeID).compareTo(int.parse(b.barcodeID));
        } else {
          return a.barcodeID.compareTo(b.barcodeID);
        }
      });
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

  ///This is the searchBar widge where you can search for ID or Tags.
  TextField searchBar(BuildContext context) {
    return TextField(
      onChanged: (value) {
        runFilter(value);
      },
      onEditingComplete: () => hideKeyboard(context),
      decoration: const InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hoverColor: Colors.deepOrange,
          focusColor: Colors.deepOrange,
          contentPadding: EdgeInsets.all(10),
          labelStyle: TextStyle(color: Colors.white),
          labelText: 'Search',
          suffixIcon: Icon(
            Icons.search,
            color: Colors.white,
          )),
    );
  }

  Future<void> refresh() async {
    setState(() {
      runFilter('');
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
}
