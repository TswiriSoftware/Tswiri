import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar/container_isar/container_isar.dart';
import 'package:flutter_google_ml_kit/isar/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/container_view.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/container_card_widget%20.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:isar/isar.dart';

import '../../functions/barcodeTools/hide_keyboard.dart';
import 'container_modification/new_container_setup.dart';
import 'functions/isar_functions.dart';

import '../../widgets/search_bar_widget.dart';

class ContainersView extends StatefulWidget {
  const ContainersView({Key? key}) : super(key: key);

  @override
  _ContainersViewState createState() => _ContainersViewState();
}

class _ContainersViewState extends State<ContainersView> {
  List<ContainerEntry> searchResults = [];
  Isar? database;
  String enteredKeyword = '';

  @override
  void initState() {
    database = openIsar();

    super.initState();
  }

  @override
  void dispose() {
    database = closeIsar(database);
    super.dispose();
  }

  void refresh() {
    setState(() {});
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
                setState(() {});
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
              ///Search Bar.
              SearchBarWidget(
                onChanged: (value) {
                  setState(() {
                    enteredKeyword = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Swipe for more options',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 5),

              Builder(
                builder: (context) {
                  List<ContainerEntry> results = database!.containerEntrys
                      .filter()
                      .nameContains(enteredKeyword, caseSensitive: false)
                      .or()
                      .containerTypeContains(enteredKeyword)
                      .sortByBarcodeUID()
                      .findAllSync();

                  return Expanded(
                    child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: ((context, index) {
                          ContainerEntry containerEntry = results[index];
                          return InkWell(
                              onTap: () async {
                                //Push ContainerView
                                await Navigator.push(
                                  context,
                                  (MaterialPageRoute(
                                    builder: (context) => ContainerView(
                                      database: database,
                                      containerUID: containerEntry.containerUID,
                                    ),
                                  )),
                                );
                                //Update all entires
                                setState(() {});
                              },
                              //Allows for slide action/options.
                              child: Slidable(
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        // An action can be bigger than the others.
                                        flex: 1,
                                        onPressed: (context) {
                                          database!.writeTxnSync(
                                            (isar) {
                                              isar.containerEntrys.deleteSync(
                                                  containerEntry.id);

                                              isar.containerRelationships
                                                  .filter()
                                                  .containerUIDMatches(
                                                      containerEntry
                                                          .containerUID)
                                                  .deleteAllSync();
                                            },
                                          );
                                          refresh();
                                        },
                                        backgroundColor: Colors.deepOrange,
                                        foregroundColor: Colors.white,
                                        icon: Icons.archive,
                                        label: 'Delete',
                                      ),
                                    ]),
                                child: ContainerCardWidget(
                                    containerEntry: containerEntry,
                                    database: database!),
                              ));
                        })),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Navigate to NewContainerView on return update filter
  Future<void> createNewContainer(BuildContext context) async {
    await Navigator.push(
      context,
      (MaterialPageRoute(
        builder: (context) => NewContainerCreateView(
          database: database!,
        ),
      )),
    );
    setState(() {});
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
}
