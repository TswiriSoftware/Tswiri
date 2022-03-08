import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/all_barcode_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/scan_barcode_view.dart';
import 'package:flutter_google_ml_kit/zDemoView/shelves/shelfFunctions/get_all_shelves.dart';
import 'package:hive/hive.dart';

import '../../databaseAdapters/shelfAdapter/shelf_entry.dart';
import '../../functions/barcodeTools/hide_keyboard.dart';
import 'new_shelf_view.dart';

class ShelvesView extends StatefulWidget {
  const ShelvesView({Key? key}) : super(key: key);

  @override
  _ShelvesViewState createState() => _ShelvesViewState();
}

class _ShelvesViewState extends State<ShelvesView> {
  List<ShelfEntry> searchResults = [];
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
        title: const Text(
          'Shelves',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  (MaterialPageRoute(
                    builder: (context) => NewShelfView(),
                  )),
                );
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text('swipe to delete'),
          const SizedBox(height: 10),
          Expanded(
            child: searchResults.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final searchResult = searchResults[index];
                      return Dismissible(
                        key: Key(searchResult.uid.toString()),
                        // onDismissed: (direction) {
                        //   deleteBarcode(foundBarcode.barcodeID,
                        //       foundBarcodes[index].isFixed);
                        //   // Remove the item from the data source.
                        //   setState(() {
                        //     foundBarcodes.removeAt(index);
                        //   });
                        // },
                        // child: displayBarcodeDataWidget(
                        //     context, foundBarcodes[index], runFilter('')),
                        child: Text('Shelve Card'),
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

  List<ShelfEntry>? shelfEntries;
  Future<void> runFilter(String enteredKeyword) async {
    //Gets a list of all shelves.
    shelfEntries ??= await getAllShelves();

    //Filter results.
    List<ShelfEntry> results = [];

    if (enteredKeyword.isNotEmpty) {
      //The search algorithm.
      // we use the toLowerCase() method to make it case-insensitive
      results = results
          .where((element) =>
              element.uid.toString().toLowerCase().contains(enteredKeyword) ||
              element.name
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              element.description
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    //Refresh the UI
    setState(() {
      searchResults = results;
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
