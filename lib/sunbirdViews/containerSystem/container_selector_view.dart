import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/conatiner_type_adapter.dart';
import 'package:isar/isar.dart';
import '../../isar/container_isar.dart';
import 'functions/isar_functions.dart';
import 'widgets/container_card_widget.dart';
import '../../widgets/search_bar_widget.dart';

class ContainerSelectorView extends StatefulWidget {
  const ContainerSelectorView(
      {Key? key, required this.multipleSelect, this.currentContainerUID})
      : super(key: key);

  final String? currentContainerUID;
  final bool multipleSelect;
  @override
  _ContainerSelectorViewState createState() => _ContainerSelectorViewState();
}

class _ContainerSelectorViewState extends State<ContainerSelectorView> {
  List<ContainerEntry> searchResults = [];
  Isar? database;

  @override
  void initState() {
    runFilter();
    super.initState();
  }

  @override
  void dispose() {
    database = closeIsar(database);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Containers",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, null);
        },
        child: const Icon(Icons.cancel_outlined),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            SearchBarWidget(
              onChanged: (value) {
                runFilter(enteredKeyword: value);
              },
            ),
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
                            if (widget.multipleSelect) {
                              //Returns a set of containerUID's
                              Navigator.pop(
                                  context, {searchResult.containerUID});
                            } else {
                              //Returns a single containerUID
                              Navigator.pop(context, searchResult.containerUID);
                            }
                            //Close the database.
                            database = closeIsar(database);
                          },
                          //Container Card.
                          child: ContainerCard(
                            containerEntry: searchResult,
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

  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Area ?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Info Here')
            // Text(
            //     'What is a shelf ? All I know is that it contains boxes and markers that are rougly on the same plane.\n '),
            // Text(
            //     'What is a marker ? it is a qrcode that is not allowed to move.\n'),
            // Text(
            //     'What is a box ? it is a box with a qrcode stuck to it that can move.\n'),
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

  ///Filter for database.
  Future<void> runFilter(
      {String? enteredKeyword, ContainerType? containerType}) async {
    database ??= await openIsar();

    List<ContainerEntry> results = database!.containerIsars
        .filter()
        .nameContains(enteredKeyword ?? '', caseSensitive: false)
        .findAllSync();

    setState(() {
      searchResults = results;
    });
  }
}
