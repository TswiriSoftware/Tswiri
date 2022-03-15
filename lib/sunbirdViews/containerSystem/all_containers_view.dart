import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/conatiner_type_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/container_entry_adapter.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/new_container_view.dart';
import 'package:flutter_google_ml_kit/widgets/light_container.dart';
import 'package:hive/hive.dart';
import '../../globalValues/global_hive_databases.dart';
import '../../widgets/container_card.dart';
import '../../widgets/search_bar_widget.dart';
import 'container_view.dart';

class ContainersView extends StatefulWidget {
  const ContainersView({Key? key}) : super(key: key);

  @override
  _ContainersViewState createState() => _ContainersViewState();
}

class _ContainersViewState extends State<ContainersView> {
  List<ContainerEntry> searchResults = [];

  @override
  void initState() {
    runFilter();
    super.initState();
  }

  @override
  void dispose() {
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
                              //Navigate to Container view.
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContainerView(
                                    containerUID: searchResult.containerUID,
                                  ),
                                ),
                              );
                              // On return refresh filter.
                              runFilter();
                            },
                            onLongPress: () {
                              showDeleteDialog(
                                context,
                                searchResult,
                              );
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

  ///Show the info Dialog.
  void showFilterDialog() {
    List<String> containerTypes = [];
    for (ContainerType containerType in ContainerType.values) {
      containerTypes.add(containerType.toString().split('.').last);
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Filter'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: ContainerType.values.length,
            itemBuilder: (context, index) {
              List<String> userChecked = [];
              return LightContainer(
                margin: 2,
                padding: 2,
                child: ListTile(
                    title: Text(containerTypes[index]),
                    trailing: Checkbox(
                      value: userChecked.contains(containerTypes[index]),
                      onChanged: (val) {
                        if (val == true) {
                          setState(() {
                            userChecked.add(containerTypes[index]);
                          });
                        } else {
                          setState(() {
                            userChecked.remove(containerTypes[index]);
                          });
                        }
                      },
                    )),
              );
            },
          ),
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
                Box<ContainerEntry> containersBox =
                    await Hive.openBox(containersBoxName);
                containersBox.delete(containerEntry.containerUID);
                runFilter(enteredKeyword: '');
                Navigator.pop(_);
              },
              child: const Text('delete'))
        ],
      ),
    );
  }

  ///This is the filter that runs on the list of containers.
  Future<void> runFilter(
      {String? enteredKeyword, ContainerType? containerType}) async {
    //Open hive box.
    Box<ContainerEntry> containersBox = await Hive.openBox(containersBoxName);
    List<ContainerEntry> results = [];

    //Apply filter / enteredKeyword
    if (containerType != null) {
      results = containersBox.values
          .toList()
          .where((element) =>
              element.containerType == containerType ||
              element.name!.toLowerCase().contains(enteredKeyword ?? ''))
          .toList();
    } else {
      results = containersBox.values
          .toList()
          .where((element) =>
              element.name!.toLowerCase().contains(enteredKeyword ?? '') ||
              element.description!.toLowerCase().contains(enteredKeyword ?? ''))
          .toList();
    }

    //log(results.toString());
    setState(() {
      searchResults = results;
    });
  }
}
