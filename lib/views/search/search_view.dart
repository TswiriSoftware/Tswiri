import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/containers/container_view/container_view.dart';
import 'package:sunbird/views/search/navigator/navigator_view.dart';
import 'package:sunbird/views/search/searh_controller/search_controller.dart';
import 'package:sunbird/views/utilities/getting_started/getting_started_view.dart';
import 'package:sunbird/widgets/search_bar/search_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    Key? key,
    required this.isSearching,
  }) : super(key: key);
  final void Function(bool) isSearching;
  @override
  State<SearchView> createState() => _SearchViewState();
}

///Search Filters.
List<String> searchFilters = ['Tags', 'Photos'];

class _SearchViewState extends State<SearchView> {
  final SearchController _searchController =
      SearchController(filters: searchFilters);
  Map<String, String> filterTypes = {
    'Tags': 'Search by container tags',
    'ML Labels': 'Search by photo labels',
    'Photo Labels': 'Search by User Labels',
    'Name': 'Search by container Name',
    'Description': 'Search by container Description',
    'Barcode': 'Search by container Barcodes',
    'ML Text': 'Search by detected text',
  };

  bool isSearching = false;

  @override
  void initState() {
    _searchController.search();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching ? _searchBar() : _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Search',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = true;
              widget.isSearching(isSearching);
            });
          },
          icon: const Icon(
            Icons.search_sharp,
          ),
        ),
      ],
    );
  }

  PreferredSize _searchBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 50),
      child: SearchAppBar(
        filters: searchFilters,
        filterTypes: filterTypes.entries.map((e) => e.key).toList(),
        filterChange: (enteredKeyWord) {
          setState(() {
            _searchController.search(enteredKeyword: enteredKeyWord);
          });
        },
        onCancel: () {
          setState(() {
            isSearching = false;
            widget.isSearching(isSearching);
            _searchController.search();
          });
        },
        onChanged: (value) {
          setState(() {
            _searchController.search(enteredKeyword: value);
          });
        },
        onSubmitted: (value) {
          setState(() {
            _searchController.search(enteredKeyword: value);
          });
        },
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: _searchController.searchResults.length + 1,
      itemBuilder: (context, index) {
        if (index == 0 && hasShownGettingStarted == false) {
          return _gettingStarted();
        } else if (index != 0) {
          return _containerCard(
            _searchController.searchResults[index - 1],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _containerCard(SearchResult e) {
    return ContainerSearchCard(searchObject: e);
  }

  Widget _gettingStarted() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GettingStartedView(),
          ),
        );
        setState(() {
          hasShownGettingStarted = true;
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool(hasShownGettingStartedPref, true);
      },
      child: const Card(
        child: SizedBox(
          height: 150,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text('Getting Started')),
          ),
        ),
      ),
    );
  }
}

class ContainerSearchCard extends StatelessWidget {
  const ContainerSearchCard({
    Key? key,
    required this.searchObject,
  }) : super(key: key);
  final SearchResult searchObject;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  searchObject.catalogedContainer.name ??
                      searchObject.catalogedContainer.containerUID,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),

            ///Container Tags.
            Visibility(
              visible: searchObject.containerTags.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(
                    'Tags: ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 4,
                      children: [
                        for (ContainerTag containerTag
                            in searchObject.containerTags)
                          Chip(
                            label: Text(
                              isar!.tagTexts
                                  .getSync(containerTag.tagTextID)!
                                  .text,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///Photos.
            Visibility(
              visible: searchObject.photos.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 4,
                      children: [
                        for (Photo photo in searchObject.photos)
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Image.file(
                              File(photo.getPhotoPath()),
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///Photo Labels.
            Visibility(
              visible: searchObject.mlPhotoLabels.isNotEmpty ||
                  searchObject.photoLabels.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(
                    'Photo Labels: ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 4,
                      children: [
                        for (PhotoLabel photoLabel in searchObject.photoLabels)
                          Chip(
                            label: Text(
                              isar!.tagTexts
                                  .getSync(photoLabel.tagTextID)!
                                  .text,
                            ),
                            avatar: const Icon(
                              Icons.verified_user_sharp,
                              size: 15,
                            ),
                          ),
                        for (MLPhotoLabel mlPhotoLabel
                            in searchObject.mlPhotoLabels)
                          Chip(
                            label: Text(
                              isar!.mLDetectedLabelTexts
                                  .getSync(mlPhotoLabel.detectedLabelTextID)!
                                  .detectedLabelText,
                            ),
                            avatar: const Icon(
                              Icons.smart_toy_sharp,
                              size: 15,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///Object Labels.
            Visibility(
              visible: searchObject.objectLabels.isNotEmpty ||
                  searchObject.mlObjectLabels.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(
                    'Object Labels: ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 4,
                      children: [
                        for (ObjectLabel objectLabel
                            in searchObject.objectLabels)
                          Chip(
                            label: Text(
                              isar!.tagTexts
                                  .getSync(objectLabel.tagTextID)!
                                  .text,
                            ),
                            avatar: const Icon(
                              Icons.verified_user_sharp,
                              size: 15,
                            ),
                          ),
                        for (MLObjectLabel mlObjectlabel
                            in searchObject.mlObjectLabels)
                          Chip(
                            label: Text(
                              isar!.mLDetectedLabelTexts
                                  .getSync(mlObjectlabel.detectedLabelTextID)!
                                  .detectedLabelText,
                            ),
                            avatar: const Icon(
                              Icons.smart_toy_sharp,
                              size: 15,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            ///Actions.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: colorModeEnabled
                      ? ElevatedButton.styleFrom(
                          primary: searchObject.containerType.containerColor)
                      : null,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContainerView(
                          catalogedContainer: searchObject.catalogedContainer,
                          tagsExpanded: true,
                          photosExpaned: true,
                          childrenExpanded: false,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Edit',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ElevatedButton(
                  style: colorModeEnabled
                      ? ElevatedButton.styleFrom(
                          primary: searchObject.containerType.containerColor)
                      : null,
                  onPressed: () async {
                    CatalogedCoordinate? catalogedCoordiante = isar!
                        .catalogedCoordinates
                        .filter()
                        .barcodeUIDMatches(
                            searchObject.catalogedContainer.barcodeUID!)
                        .findFirstSync();

                    if (catalogedCoordiante != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigatorView(
                            catalogedContainer: searchObject.catalogedContainer,
                            gridUID: catalogedCoordiante.gridUID,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Does not belong to a grid',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Find',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
