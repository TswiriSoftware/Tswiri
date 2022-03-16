import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/conatiner_type_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/container_entry_adapter.dart';
import 'package:flutter_google_ml_kit/isar/container_isar.dart';

import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/new_container_view.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'functions/isar_functions.dart';
import 'widgets/container_card_widget.dart';
import '../../widgets/search_bar_widget.dart';

class ContainersView extends StatefulWidget {
  const ContainersView({Key? key}) : super(key: key);

  @override
  _ContainersViewState createState() => _ContainersViewState();
}

class _ContainersViewState extends State<ContainersView> {
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
          ///InfoButton.
          IconButton(
              onPressed: () {
                showInfoDialog();
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
            ///Create new Container.
            FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                await createNewContainer(context);
                runFilter();
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              ///Search Bar.
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

              ///ListView of containers.
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
                              //On return refresh filter.
                              runFilter();
                            },
                            onLongPress: () {
                              showDeleteDialog(context, searchResult);
                            },
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
      ),
    );
  }

  ///Navigate to NewContainerView on return update filter
  Future<void> createNewContainer(BuildContext context) async {
    database = closeIsar(database);
    await Navigator.push(
      context,
      (MaterialPageRoute(
        builder: (context) => const NewContainerView(
          containerType: ContainerType.area,
        ),
      )),
    );
    setState(() {
      runFilter();
    });
  }

  ///Show the info Dialog.
  void showInfoDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Area ?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [Text('Info Here')],
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

  ///Confirm Delete.
  Future<void> showDeleteDialog(
      BuildContext context, ContainerEntry containerEntry) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(containerEntry.containerUID),
            Text(containerEntry.name ?? ''),
          ],
        ),
        content: const Text('Do you want to delete this container ?'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                if (database != null) {
                  database!.writeTxnSync((isar) {
                    database!.containerIsars.deleteSync(containerEntry.id);
                  });
                }
                runFilter();
                Navigator.pop(_);
              },
              child: const Text('delete'))
        ],
      ),
    );
  }

  ///This is the filter that runs on the list of containers.
  Future<void> runFilter({String? enteredKeyword}) async {
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
