import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/demoViews/shelves/shelfFunctions/get_all_shelves.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/demoViews/shelves/shelfWidgets/shelf_card_widget.dart';

import '../../../databaseAdapters/shelfAdapter/shelf_entry.dart';
import '../../../functions/barcodeTools/hide_keyboard.dart';
import 'new_shelf_view.dart';
import 'shelf_view.dart';

class ShelvesView extends StatefulWidget {
  const ShelvesView({Key? key}) : super(key: key);

  @override
  _ShelvesViewState createState() => _ShelvesViewState();
}

class _ShelvesViewState extends State<ShelvesView> {
  List<ShelfEntry> searchResults = [];
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
              onPressed: () async {
                await Navigator.push(
                  context,
                  (MaterialPageRoute(
                    builder: (context) => NewShelfView(),
                  )),
                );
                setState(() {
                  runFilter('');
                });
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text('Hold for more options'),
            const SizedBox(height: 10),
            searchBar(context),
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
                          child: ShelfCard(
                            shelfEntry: searchResult,
                          ),
                        );
                      })
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<ShelfEntry>? shelfEntries;
  Future<void> runFilter(String enteredKeyword) async {
    //Gets a list of all shelves.
    shelfEntries = await getAllShelves();

    //Filter results.
    List<ShelfEntry> results = [];

    if (enteredKeyword.isNotEmpty) {
      // The search algorithm.
      // we use the toLowerCase() method to make it case-insensitive
      results = shelfEntries!
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
    } else {
      results.addAll(shelfEntries!);
    }

    //Refresh the UI
    setState(() {
      searchResults = results;
      log(searchResults.toString());
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
