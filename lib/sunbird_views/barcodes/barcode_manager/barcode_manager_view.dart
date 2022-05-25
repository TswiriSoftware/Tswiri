import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/sunbird_views/containers/container_view/new_container_view.dart';

import 'package:flutter_google_ml_kit/sunbird_views/containers/container_view/container_view.dart';
import 'package:isar/isar.dart';

import '../../../isar_database/containers/container_entry/container_entry.dart';

class BarcodeManagerView extends StatefulWidget {
  const BarcodeManagerView({Key? key}) : super(key: key);

  @override
  State<BarcodeManagerView> createState() => _BarcodeManagerViewState();
}

List<String> barcodeFilters = ['Assigned', 'Unassigned'];

class _BarcodeManagerViewState extends State<BarcodeManagerView> {
  List<BarcodeProperty> allBarcodes = [];

  Map<String, String> barcodeFilterTypes = {
    'Assigned': 'Assigned Barcodes',
    'Unassigned': 'Unassigned Barcodes',
  };

  String enteredKeyword = '';

  //Text Controller.
  TextEditingController searchController = TextEditingController();

  //Search FocusNode.
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    search(enteredKeyword);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _focusNode.unfocus();
          });
        },
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            _barcodes(),
            _filters(),
          ],
        ),
      ),
    );
  }

  ///APP BAR///

  AppBar _appBar() {
    return AppBar(
      title: _textField(),
      centerTitle: true,
      elevation: 0,
    );
  }

  ///SEARCH///

  Widget _textField() {
    return TextField(
      focusNode: _focusNode,
      controller: searchController,
      onChanged: (value) {
        search(value);
        setState(() {});
      },
      cursorColor: Colors.white,
      style: Theme.of(context).textTheme.labelLarge,
      decoration: InputDecoration(
        suffixIcon: isFocused ? null : _searchIcon(),
        hintText: 'Search',
        hintStyle: const TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _searchIcon() {
    return const Icon(
      Icons.search,
      color: Colors.white,
    );
  }

  ///FILTER///

  Widget _filters() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 5,
        children: barcodeFilterTypes.entries
            .map((e) => fliterChip(filter: e.key, tooltip: e.value))
            .toList(),
      ),
    );
  }

  FilterChip fliterChip({required String filter, required String tooltip}) {
    return FilterChip(
      label: Text(
        filter,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onSelected: (selected) {
        _onSelected(selected, filter);
        setState(() {
          search(enteredKeyword);
        });
      },
      selected: barcodeFilters.contains(filter),
      selectedColor: sunbirdOrange,
      tooltip: tooltip,
      elevation: 5,
      shadowColor: Colors.black54,
    );
  }

  void _onSelected(bool selected, String filter) {
    if (barcodeFilters.contains(filter)) {
      setState(() {
        barcodeFilters.removeWhere((element) => element == filter);
      });
    } else {
      setState(() {
        barcodeFilters.add(filter);
      });
    }
  }

  ///BARCODES///

  Widget _barcodes() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 50),
      itemCount: allBarcodes.length,
      itemBuilder: (context, index) {
        return barcodeBuilder(allBarcodes[index]);
      },
    );
  }

  Widget barcodeBuilder(BarcodeProperty barcodeProperty) {
    return Builder(builder: (context) {
      ContainerEntry? containerEntry = isarDatabase!.containerEntrys
          .filter()
          .barcodeUIDMatches(barcodeProperty.barcodeUID)
          .findFirstSync();
      Color containerColor = Colors.grey;
      if (containerEntry != null) {
        containerColor =
            getContainerColor(containerUID: containerEntry.containerUID);
      }

      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.white12,
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: containerColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UID',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                barcodeProperty.barcodeUID,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(),
              Text(
                'Container',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                containerEntry?.name ??
                    containerEntry?.containerUID ??
                    'un-linked',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(),
              barcodeActions(containerEntry, containerColor, barcodeProperty),
            ],
          ),
        ),
      );
    });
  }

  Widget barcodeActions(ContainerEntry? containerEntry, Color? color,
      BarcodeProperty barcodeProperty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Builder(builder: (context) {
          if (containerEntry != null) {
            return ElevatedButton(
              style: TextButton.styleFrom(backgroundColor: color),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContainerView(
                      containerEntry: containerEntry,
                    ),
                  ),
                );
                search(enteredKeyword);
                setState(() {});
              },
              child: const Text('Edit'),
            );
          } else {
            return ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewContainerView(
                            barcodeUID: barcodeProperty.barcodeUID,
                          )),
                );
              },
              child: const Text('Link'),
            );
          }
        })
      ],
    );
  }

  ///SEARCH///
  void search(String enteredKeyword) {
    allBarcodes = [];
    List<BarcodeProperty> barcodes = isarDatabase!.barcodePropertys
        .filter()
        .barcodeUIDContains(enteredKeyword)
        .findAllSync();

    log(barcodes.toString());

    if (barcodeFilters.contains('Assigned')) {
      for (BarcodeProperty item in barcodes) {
        ContainerEntry? containerEntry = isarDatabase!.containerEntrys
            .filter()
            .barcodeUIDMatches(item.barcodeUID)
            .findFirstSync();
        if (containerEntry != null) {
          allBarcodes.add(item);
        }
      }
    }

    if (barcodeFilters.contains('Unassigned')) {
      for (BarcodeProperty item in barcodes) {
        ContainerEntry? containerEntry = isarDatabase!.containerEntrys
            .filter()
            .barcodeUIDMatches(item.barcodeUID)
            .findFirstSync();
        if (containerEntry == null) {
          allBarcodes.add(item);
        }
      }
    }
    setState(() {});

    //log(allBarcodes.toString());
  }
}
