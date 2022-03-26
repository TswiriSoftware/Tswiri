import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

class ContainerManagerView extends StatefulWidget {
  const ContainerManagerView({Key? key}) : super(key: key);

  @override
  State<ContainerManagerView> createState() => _ContainerManagerViewState();
}

class _ContainerManagerViewState extends State<ContainerManagerView> {
  String enteredKeyword = '';
  List<String> filterList = ['area', 'shelf', 'drawer'];
  List<String> containerTypes = [];
  bool showFilter = false;

  @override
  void initState() {
    containerTypes = isarDatabase!.containerTypes
        .where()
        .containerTypeProperty()
        .findAllSync();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Container Manager',
              style: Theme.of(context).textTheme.titleMedium),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            //SearchBar
            _searchBar(),
            //ListView
            _listViewBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _listViewBuilder() {
    return Builder(
      builder: ((context) {
        List<ContainerEntry> searchResults = searchContainers();

        return Expanded(
          child: ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              ContainerEntry containerEntry = searchResults[index];
              return containerDisplayWidget(containerEntry);
            },
          ),
        );
      }),
    );
  }

  Widget containerDisplayWidget(ContainerEntry containerEntry) {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: OrangeOutlineContainer(
        margin: 2.5,
        padding: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Container Name/UID',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              containerEntry.name ?? containerEntry.containerUID,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(
              height: 5,
            ),
            Text(
              'Description',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              containerEntry.description ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            //TODO: what else to add here ? @049er
          ],
        ),
      ),
    );
  }

  List<ContainerEntry> searchContainers() {
    bool enabled = false;
    if (enteredKeyword.isNotEmpty) {
      enabled = true;
    }
    //My filter
    List<ContainerEntry> results = isarDatabase!.containerEntrys
        .filter()
        .optional(
          enabled,
          (q) => q.group(
            (q) => q
                .nameContains(enteredKeyword, caseSensitive: false)
                .or()
                .descriptionContains(enteredKeyword, caseSensitive: false),
          ),
        )
        .repeat(
            filterList, (q, String element) => q.containerTypeMatches(element))
        .findAllSync();

    return results;
  }

  Widget _searchBar() {
    return CustomOutlineContainer(
      outlineColor: Colors.deepOrange,
      margin: 2.5,
      padding: 5,
      child: Builder(
        builder: ((context) {
          if (showFilter) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Filter: ',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showFilter = !showFilter;
                              setState(() {});
                            },
                            icon: const Icon(Icons.filter_alt_outlined),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: containerTypes
                            .map((e) => containerTypeFilterWidget(e))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 18),
                    onEditingComplete: (() => hideKeyboard(context)),
                    onChanged: (value) {
                      enteredKeyword = value;
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      icon: Icon(Icons.search),
                      labelText: 'search',
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showFilter = !showFilter;
                      setState(() {});
                    },
                    icon: const Icon(Icons.filter_alt_outlined))
              ],
            );
          }
        }),
      ),
    );
  }

  Widget containerTypeFilterWidget(String containerType) {
    return LightContainer(
      padding: 0,
      margin: 2.5,
      child: DarkContainer(
        margin: 2.5,
        padding: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              containerType,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Checkbox(
                value: filterList.contains(containerType),
                onChanged: (value) {
                  _onSelected(value!, containerType);
                })
          ],
        ),
      ),
    );
  }

  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        filterList.add(dataName);
      });
    } else {
      setState(() {
        filterList.remove(dataName);
      });
    }
  }
}
