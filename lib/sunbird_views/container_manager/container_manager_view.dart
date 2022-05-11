import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/new_container_view.dart';
import 'package:isar/isar.dart';

class ContainerManagerView extends StatefulWidget {
  const ContainerManagerView({Key? key}) : super(key: key);

  @override
  State<ContainerManagerView> createState() => _ContainerManagerViewState();
}

class _ContainerManagerViewState extends State<ContainerManagerView> {
  //Search//
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  //Containers//
  late List<ContainerEntry> containers =
      isarDatabase!.containerEntrys.where().findAllSync();

  late List<ContainerType> x =
      isarDatabase!.containerTypes.where().findAllSync();

  late Map containerColors = {
    for (var e in x)
      e.containerType: Color(int.parse(e.containerColor)).withOpacity(1)
  };

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _focusNode.hasFocus ? null : _addButton(),
    );
  }

  ///BODY///
  Widget _body() {
    return ListView.builder(
      itemCount: containers.length,
      itemBuilder: (context, index) {
        return container(containers[index],
            containerColors[containers[index].containerType]);
      },
    );
  }

  ///CONTAINER CARD///

  Widget container(ContainerEntry containerEntry, Color color) {
    return GestureDetector(
      onLongPress: () {
        //TODO: select container.
      },
      onTap: () {
        //TODO: Navigate to container screen.

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContainerView(
              containerEntry: containerEntry,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        color: Colors.white12,
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///NAME///
              name(containerEntry.name, containerEntry.containerUID),
              const Divider(),

              ///DESCRIPTION///
              description(containerEntry.description),
              const Divider(),

              ///BARCODE///
              barcode(containerEntry.barcodeUID),
              const Divider(),

              //TODO: Add Tags

              ///INFO///
              Center(
                child: Text(
                  'Hold To Select',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///NAME///
  Widget name(String? name, String uid) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                name ?? '-',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const VerticalDivider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'UID',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                uid,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget description(String? description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          description ?? '-',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget barcode(String? barcodeUID) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Barcode UID',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          barcodeUID ?? '-',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  ///APP BAR///
  AppBar _appBar() {
    return AppBar(
      backgroundColor: sunbirdOrange,
      elevation: 25,
      centerTitle: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchField(),
        ],
      ),
      shadowColor: Colors.black54,
    );
  }

  ///SEARCH FIELD///
  Widget _searchField() {
    return TextField(
      focusNode: _focusNode,
      controller: searchController,
      onChanged: (value) {
        search(value);
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

  ///ACTIONS///
  Widget _addButton() {
    return Visibility(
      visible: !isFocused,
      child: FloatingActionButton(
        elevation: 10,
        onPressed: () async {
          ///Navigate to NewContainerView
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewContainerView()),
          );
          setState(() {});
        },
        child: _addIcon(),
      ),
    );
  }

  Widget _addIcon() {
    return const Icon(
      Icons.add,
      color: Colors.white,
    );
  }

  ///FUNCTIONS///
  void search(String? enteredText) {
    if (enteredText != null && enteredText.isNotEmpty) {
      enteredText = enteredText.toLowerCase();
      setState(() {
        containers = isarDatabase!.containerEntrys
            .filter()
            .nameContains(enteredText!, caseSensitive: false)
            .or()
            .descriptionContains(enteredText, caseSensitive: false)
            .findAllSync();
      });
    } else {
      setState(() {
        containers = isarDatabase!.containerEntrys.where().findAllSync();
      });
    }
  }
}
