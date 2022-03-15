import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/conatiner_type_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/container_entry_adapter.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/new_container_view.dart';
import 'package:flutter_google_ml_kit/widgets/dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/light_container.dart';
import 'package:hive/hive.dart';
import '../../databaseAdapters/shelfAdapter/shelf_entry.dart';
import '../../globalValues/global_hive_databases.dart';
import '../../widgets/search_bar_widget.dart';

class ContainerSelectorView extends StatefulWidget {
  const ContainerSelectorView({Key? key, this.currentContainerUID})
      : super(key: key);

  final String? currentContainerUID;
  @override
  _ContainerSelectorViewState createState() => _ContainerSelectorViewState();
}

class _ContainerSelectorViewState extends State<ContainerSelectorView> {
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
                            Navigator.pop(context, {searchResult.containerUID});
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
    );
  }

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
                runFilter();
                Navigator.pop(_);
              },
              child: const Text('delete'))
        ],
      ),
    );
  }

  Future<void> runFilter(
      {String? enteredKeyword, ContainerType? containerType}) async {
    Box<ContainerEntry> containersBox = await Hive.openBox(containersBoxName);
    List<ContainerEntry> results = [];

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

    if (results
        .any((element) => element.containerUID == widget.currentContainerUID)) {
      results.removeWhere(
          (element) => element.containerUID == widget.currentContainerUID);
    }

    setState(() {
      searchResults = results;
    });
  }
}

class ContainerCard extends StatelessWidget {
  const ContainerCard({Key? key, required this.containerEntry})
      : super(key: key);

  final ContainerEntry containerEntry;
  @override
  Widget build(BuildContext context) {
    return LightContainer(
        margin: 2.5,
        padding: 2.5,
        child: DarkContainer(
          padding: 8,
          margin: 2.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Name: ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    containerEntry.name ?? '',
                    style:
                        TextStyle(fontSize: 18, color: Colors.deepOrange[800]),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Description: ',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    containerEntry.description ?? '',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Text(
                'UID: ${containerEntry.containerUID}',
                style: const TextStyle(
                  fontSize: 8,
                ),
              )
            ],
          ),
        ));
  }
}
