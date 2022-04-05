import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/keyboard_functions/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/add_container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';

import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

class ContainerManagerView extends StatefulWidget {
  const ContainerManagerView({Key? key}) : super(key: key);

  @override
  State<ContainerManagerView> createState() => _ContainerManagerViewState();
}

class _ContainerManagerViewState extends State<ContainerManagerView> {
  //String enteredKeyword = '';
  List<String> containerTypeList = ['area', 'shelf', 'drawer', 'box'];
  List<String> containerTypes = [];

  bool showFilter = false;

  TextEditingController searchController = TextEditingController();
  bool showFilterOptions = false;
  bool filterArea = true;

  List<ContainerEntry> searchResults = [];

  @override
  void initState() {
    containerTypes = isarDatabase!.containerTypes
        .where()
        .containerTypeProperty()
        .findAllSync();

    searchContainers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Containers',
              style: Theme.of(context).textTheme.titleMedium),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //ListView
            _listViewBuilder(),

            //SearchBar
            searchBar(),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return LightContainer(
      padding: 0,
      margin: 2.5,
      borderRadius: 27,
      child: OrangeOutlineContainer(
        padding: 10,
        margin: 2,
        borderRadius: 25,
        child: Column(
          children: [
            _searchOptions(),
            const Divider(
              height: 10,
              thickness: 2,
            ),
            _searchField(),
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              searchContainers();
            },
            autofocus: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              suffixIcon: Icon(Icons.search),
              labelText: 'Search',
              labelStyle: TextStyle(fontSize: 18),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchOptions() {
    return Builder(
      builder: (context) {
        if (showFilterOptions) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Options: ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: containerTypes
                      .map((e) => containerTypeFilterWidget(e))
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Options',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const VerticalDivider(),
                        GestureDetector(
                          onTap: () {
                            showFilterOptions = false;
                            setState(() {});
                          },
                          child: const OrangeOutlineContainer(
                            padding: 0,
                            margin: 0,
                            child: Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Options',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const VerticalDivider(),
                  GestureDetector(
                    onTap: () {
                      showFilterOptions = true;
                      setState(() {});
                    },
                    child: const OrangeOutlineContainer(
                      margin: 0,
                      padding: 0,
                      child: Icon(
                        Icons.arrow_drop_up_rounded,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddContainerView()),
                  );
                  setState(() {});
                },
                child: const OrangeOutlineContainer(
                  width: 35,
                  height: 35,
                  padding: 0,
                  margin: 0,
                  child: Center(
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _listViewBuilder() {
    return Builder(
      builder: ((context) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                ContainerEntry containerEntry = searchResults[index];
                return containerDisplayWidget(containerEntry);
              },
            ),
          ),
        );
      }),
    );
  }

  void searchContainers() {
    bool enabled = false;
    if (searchController.text.isNotEmpty) {
      enabled = true;
    }
    log(enabled.toString());
    log(searchController.text);

    if (containerTypeList.isNotEmpty) {
      searchResults = isarDatabase!.containerEntrys
          .filter()
          .repeat(
            containerTypeList,
            (q, String element) => q.containerTypeMatches(
              element,
            ),
          )
          .and()
          .optional(
              enabled,
              (q) => q.group((q) => q
                  .containerUIDContains(searchController.text.toLowerCase(),
                      caseSensitive: false)
                  .or()
                  .nameContains(searchController.text.toLowerCase(),
                      caseSensitive: false)
                  .or()
                  .descriptionContains(searchController.text.toLowerCase(),
                      caseSensitive: false)))
          .findAllSync();
    } else {
      searchResults = [];
    }

    setState(() {});
  }

  Widget containerTypeFilterWidget(String containerType) {
    return Builder(
      builder: (context) {
        Color containerTypeColor = Color(int.parse(isarDatabase!.containerTypes
                .filter()
                .containerTypeMatches(containerType)
                .findFirstSync()!
                .containerColor))
            .withOpacity(1);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  containerType,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 30,
                  child: Checkbox(
                    activeColor: containerTypeColor,
                    fillColor: MaterialStateProperty.all(containerTypeColor),
                    value: containerTypeList.contains(containerType),
                    onChanged: (value) {
                      _onSelected(value!, containerType);
                      searchContainers();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            _optionDividerLight(),
          ],
        );
      },
    );
  }

  Widget _optionDividerLight() {
    return const Divider(
      height: 10,
      thickness: 1,
    );
  }

  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        containerTypeList.add(dataName);
      });
    } else {
      setState(() {
        containerTypeList.remove(dataName);
      });
    }
  }

  Widget containerDisplayWidget(ContainerEntry containerEntry) {
    return Builder(
      builder: (context) {
        Color containerTypeColor =
            getContainerColor(containerUID: containerEntry.containerUID);
        return InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContainerView(
                  containerEntry: containerEntry,
                ),
              ),
            );
            searchContainers();
            setState(() {});
          },
          child: LightContainer(
            margin: 2.5,
            padding: 2.5,
            child: CustomOutlineContainer(
              outlineColor: containerTypeColor,
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
                    style: Theme.of(context).textTheme.labelMedium,
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
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Divider(
                    height: 5,
                  ),
                  Text(
                    'BarcodeUID',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    containerEntry.barcodeUID ?? '',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
