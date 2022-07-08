import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/all_globals.dart';
import 'package:flutter_google_ml_kit/isar_database/isar_export.dart';
import 'package:flutter_google_ml_kit/objects/search/search_object.dart';
import 'package:flutter_google_ml_kit/views/scan_dep/grid_view.dart';
// import 'package:flutter_google_ml_kit/views/scan/grid_view.dart';
import 'package:flutter_google_ml_kit/views/widgets/cards/default_card/defualt_card.dart';
import 'package:flutter_google_ml_kit/views/widgets/dividers/dividers.dart';

class ScanView extends StatefulWidget {
  const ScanView({Key? key}) : super(key: key);

  @override
  State<ScanView> createState() => _ScanViewState();
}

List<String> selectedFilters = ['Name'];

class _ScanViewState extends State<ScanView> {
  final TextEditingController _searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  bool isSearching = false;

  List<SearchContainer> searchResults = [];
  Color highlightColor = Colors.blueAccent;

  Map<String, String> filterTypes = {
    'Name': 'Search by Container Name',
    'Description': 'Search by Container Description',
    'Barcode': 'Search by Container Barcode'
  };

  @override
  void initState() {
    search('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _searchButton(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: !isSearching
          ? Text(
              'Grid Scan',
              style: Theme.of(context).textTheme.titleMedium,
            )
          : _searchField(),
      centerTitle: true,
      actions: [
        _helpButton(),
      ],
    );
  }

  Widget _helpButton() {
    return IconButton(
      onPressed: () {
        showHelpDialog(context);
      },
      icon: const Icon(Icons.help_outline),
    );
  }

  TextField _searchField() {
    return TextField(
      focusNode: searchNode,
      controller: _searchController,
      cursorColor: Colors.white,
      style: Theme.of(context).textTheme.labelLarge,
      onSubmitted: (value) {
        if (value.isEmpty) {
          setState(() {
            isSearching = false;
          });
        }
      },
      onChanged: (value) {
        setState(() {
          search(value);
        });
      },
      decoration: const InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _searchButton() {
    return Visibility(
      visible: !isSearching,
      child: FloatingActionButton(
        onPressed: () {
          setState(() {
            searchNode.requestFocus();
            isSearching = true;
          });
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _results(),
        _filters(),
      ],
    );
  }

  Widget _filters() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 5,
        children: filterTypes.entries
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
          // search(_searchController.text);
        });
      },
      selected: selectedFilters.contains(filter),
      selectedColor: sunbirdOrange,
      tooltip: tooltip,
      elevation: 5,
      shadowColor: Colors.black54,
    );
  }

  void _onSelected(bool selected, String filter) {
    if (selectedFilters.contains(filter)) {
      setState(() {
        selectedFilters.removeWhere((element) => element == filter);
      });
    } else {
      setState(() {
        selectedFilters.add(filter);
      });
    }
  }

  void showHelpDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (initialDialogContext) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10),
          title: const Text('How to use Grid Scan'),
          content: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: const [
              Text(
                  "Grid Scan is used to map a set of containers onto a 2D plane.\n"),
              Text("1. Select the parent container from the list\n"),
              Text("2. Start the scan from the selected container\n"),
              Text(
                  "3. Scan all the containers that appear on the same plane as the selected container"),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(initialDialogContext);
              },
              child: const Text('close'),
            ),
          ],
        );
      },
    );
  }

  ///CONTAINERS///

  Widget _results() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 50),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        SearchContainer searchObject = searchResults.elementAt(index);
        //
        // log(searchObject.toString());
        return defaultCard(
            body: container(searchObject), borderColor: searchObject.color);
      },
    );
  }

  Widget container(SearchContainer e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        containerName(e.container.name, e.container.containerUID),
        containerDescription(e.container.description),
        containerBarcode(e.container.barcodeUID),
        containerTags(e.tags ?? [], e.color),
        mlTags(e.mlTags, e.color),
        userTags(e.userTags, e.color),
        photos(e.photos, e.color),
        options(e.container, e.color),
      ],
    );
  }

  ///NAME///
  Widget containerName(String? name, String uid) {
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          lightDivider(height: 10),
        ],
      ),
    );
  }

  ///DESCRIPTION///
  Widget containerDescription(String? description) {
    return Visibility(
      visible: selectedFilters.contains('Description'),
      child: Column(
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
          lightDivider(height: 10),
        ],
      ),
    );
  }

  ///BARCODE///
  Widget containerBarcode(String? barcodeUID) {
    return Visibility(
      visible: selectedFilters.contains('Barcode'),
      child: Column(
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
          lightDivider(height: 10),
        ],
      ),
    );
  }

  ///CONTAINER TAGS///
  Widget containerTags(List<ContainerTag> containerTags, Color color) {
    return Visibility(
      visible: selectedFilters.contains('Tags') && containerTags.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tags',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 5,
              children:
                  containerTags.map((e) => containerTag(e, color)).toList(),
            ),
          ),
          lightDivider(height: 10),
        ],
      ),
    );
  }

  Chip containerTag(ContainerTag containerTag, Color color) {
    return Chip(
      label: Text(
        isarDatabase!.tagTexts.getSync(containerTag.textID)!.text,
      ),
      backgroundColor: color,
    );
  }

  ///ML TAGS///
  Widget mlTags(List<MlTag> mlTags, Color color) {
    return Visibility(
      visible: selectedFilters.contains('Photo Tags') && mlTags.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Tags',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 5,
              children: mlTags.map((e) => mlTag(e, color)).toList(),
            ),
          ),
          lightDivider(height: 10),
        ],
      ),
    );
  }

  Chip mlTag(MlTag mlTag, Color color) {
    return Chip(
      avatar: Builder(builder: (context) {
        switch (mlTag.tagType) {
          case MlTagType.text:
            return const Icon(
              Icons.format_size,
              size: 15,
            );

          case MlTagType.objectLabel:
            return const Icon(
              Icons.emoji_objects,
              size: 15,
            );

          case MlTagType.imageLabel:
            return const Icon(
              Icons.image,
              size: 15,
            );
        }
      }),
      label: Text(
        isarDatabase!.tagTexts.getSync(mlTag.textID)!.text,
      ),
      backgroundColor: color,
    );
  }

  ///USER TAGS///
  Widget userTags(List<UserTag> userTags, Color color) {
    return Visibility(
      visible: selectedFilters.contains('Photo Tags') && userTags.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Tags',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 5,
              children: userTags.map((e) => userTag(e, color)).toList(),
            ),
          ),
          lightDivider(height: 10),
        ],
      ),
    );
  }

  Chip userTag(UserTag userTag, Color color) {
    return Chip(
      label: Text(
        isarDatabase!.tagTexts.getSync(userTag.textID)!.text,
      ),
      backgroundColor: color,
    );
  }

  ///PHOTOS///
  Widget photos(List<Photo> photos, Color color) {
    return Visibility(
      visible: selectedFilters.contains('Photos') && photos.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Photos',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 0,
              children: photos.map((e) => photoCard(e, color)).toList(),
            ),
          ),
          lightDivider(height: 10),
        ],
      ),
    );
  }

  Card photoCard(Photo photo, Color color) {
    return defaultCard(
      marginHorizontal: 2,
      marginVertical: 2,
      body: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.width / 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.file(
            File(photo.thumbnailPath),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.22,
          ),
        ),
      ),
      borderColor: highlightColor,
    );
  }

  Widget image(Photo containerPhoto) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Image.file(
        File(containerPhoto.thumbnailPath),
      ),
    );
  }

  ///OPTIONS///
  Widget options(ContainerEntry containerEntry, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    GridDisplayView(containerEntry: containerEntry),
              ),
            );
          },
          style: ElevatedButton.styleFrom(primary: color),
          child: const Text('View'),
        ),
      ],
    );
  }

  ///SEARCH///
  void search(String text) {
    text.toLowerCase();
    searchResults = [];

    if (text.isNotEmpty) {
      if (selectedFilters.contains('Name')) {
        ///Do name Search.
        List<SearchContainer> containers = isarDatabase!.containerEntrys
            .filter()
            .nameContains(text, caseSensitive: false)
            .findAllSync()
            .map((e) => SearchContainer(container: e))
            .toList();

        for (var container in containers) {
          if (!searchResults.contains(container)) {
            searchResults.add(container);
          }
        }
      }

      if (selectedFilters.contains('Description')) {
        ///Do description Search.
        List<SearchContainer> containers = isarDatabase!.containerEntrys
            .filter()
            .descriptionContains(text, caseSensitive: false)
            .findAllSync()
            .map((e) => SearchContainer(container: e))
            .toList();

        for (var container in containers) {
          if (!searchResults.contains(container)) {
            searchResults.add(container);
          }
        }
      }

      if (selectedFilters.contains('Barcode')) {
        ///Do description Search.
        List<SearchContainer> containers = isarDatabase!.containerEntrys
            .filter()
            .barcodeUIDContains(text, caseSensitive: false)
            .findAllSync()
            .map((e) => SearchContainer(container: e))
            .toList();

        for (var container in containers) {
          if (!searchResults.contains(container)) {
            searchResults.add(container);
          }
        }
      }
    } else {
      searchResults = isarDatabase!.containerEntrys
          .where()
          .findAllSync()
          .map((e) => SearchContainer(container: e))
          .toList();
    }
  }
}
