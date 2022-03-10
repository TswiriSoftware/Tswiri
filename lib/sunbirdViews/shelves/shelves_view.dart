import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/shelves/get_all_shelves.dart';
import 'package:flutter_google_ml_kit/widgets/shelf_card_widget.dart';
import 'package:hive/hive.dart';
import '../../databaseAdapters/shelfAdapter/shelf_entry.dart';
import '../../globalValues/global_hive_databases.dart';
import '../../widgets/search_bar_widget.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                showInfoDialog(context);
              },
              icon: const Icon(Icons.info_outline_rounded))
        ],
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
                await navigateToNewShelf(context);
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
            SearchBarWidget(onChanged: (value) {
              runFilter(value);
            }),
            const SizedBox(height: 10),
            const Text(
              'Hold for more options',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: searchResults.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final searchResult = searchResults[index];
                        return InkWell(
                          onTap: () async {
                            //Navigate to shelfView.
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShelfView(
                                  shelfEntry: searchResult,
                                ),
                              ),
                            );
                            //On return refresh filter.
                            runFilter('');
                          },
                          onLongPress: () {
                            showDeleteDialog(context, searchResult);
                          },
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

  Future<void> navigateToNewShelf(BuildContext context) async {
    await Navigator.push(
      context,
      (MaterialPageRoute(
        builder: (context) => const NewShelfView(),
      )),
    );
    setState(() {
      runFilter('');
    });
  }

  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Shelf ?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
                'What is a shelf ? All I know is that it contains boxes and markers that are rougly on the same plane.\n '),
            Text(
                'What is a marker ? it is a qrcode that is not allowed to move.\n'),
            Text(
                'What is a box ? it is a box with a qrcode stuck to it that can move.\n'),
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(_);
              },
              child: const Text('ok'))
        ],
      ),
    );
  }

  Future<void> showDeleteDialog(
      BuildContext context, ShelfEntry searchResult) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(searchResult.name),
        content: const Text('Do you want to delete this shelf ?'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                Box<ShelfEntry> shelfEntriesBox =
                    await Hive.openBox(shelvesBoxName);
                shelfEntriesBox.delete(searchResult.uid);
                runFilter('');
                Navigator.pop(_);
              },
              child: const Text('delete'))
        ],
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
}
