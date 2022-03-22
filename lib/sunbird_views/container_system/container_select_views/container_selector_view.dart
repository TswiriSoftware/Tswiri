import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/card_widgets/container_card_widget.dart';
import 'package:isar/isar.dart';
import '../../../isar_database/container_entry/container_entry.dart';
import '../../../isar_database/functions/isar_functions.dart';
import '../../../widgets/search_bar_widget.dart';

class ContainerSelectorView extends StatefulWidget {
  const ContainerSelectorView(
      {Key? key,
      required this.multipleSelect,
      this.currentContainerUID,
      this.database})
      : super(key: key);

  final Isar? database;
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
    //Open Isar
    database = widget.database;
    database ??= openIsar();
    runFilter();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.database == null) {
      database!.close();
    }
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
                            if (widget.multipleSelect == true) {
                              //Returns a set of containerUID's
                              Navigator.pop(
                                  context, {searchResult.containerUID});
                            } else {
                              //Returns a single containerUID
                              Navigator.pop(context, searchResult);
                            }
                            //Close the database.
                          },
                          //Container Card.
                          child: ContainerCardWidget(
                            database: database!,
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
  Future<void> runFilter({String? enteredKeyword}) async {
    //database ??= await openIsar(database);

    List<ContainerEntry> results = database!.containerEntrys
        .filter()
        .nameContains(enteredKeyword ?? '', caseSensitive: false)
        .findAllSync();

    results.removeWhere(
        (element) => element.containerUID == widget.currentContainerUID);

    setState(() {
      searchResults = results;
    });
  }
}
