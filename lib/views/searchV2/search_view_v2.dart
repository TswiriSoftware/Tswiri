import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/collections/cataloged_container/cataloged_container.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/containers/container_view/container_view.dart';
import 'package:sunbird/views/searchV2/search_contoller_v2/image_painter.dart';
import 'package:sunbird/views/searchV2/search_contoller_v2/search_controller_v2.dart';
import 'package:sunbird/views/searchV2/search_contoller_v2/search_results.dart';
import 'package:sunbird/views/searchV2/search_widget.dart';
import 'package:sunbird/widgets/search_bar/search_bar.dart';
import '../search/searh_controller/search_controller.dart';

import 'dart:ui' as ui;

import 'search_contoller_v2/text_painter.dart';

class SearchViewV2 extends StatefulWidget {
  const SearchViewV2({
    Key? key,
    required this.isSearching,
  }) : super(key: key);
  final void Function(bool) isSearching;

  @override
  State<SearchViewV2> createState() => _SearchViewV2State();
}

///Search Filters.
List<String> searchFilters = [
  'Tags',
  'ML Labels',
  'Photo Labels',
  'Object Labels',
  'Name',
  'Description',
  'ML Text',
];

class _SearchViewV2State extends State<SearchViewV2> {
  final SearchControllerV2 _searchController =
      SearchControllerV2(filters: searchFilters);

  Map<String, String> filterTypes = {
    'Tags': 'Search by container tags',
    'ML Labels': 'Search by photo labels',
    'Photo Labels': 'Search by User Photo Labels',
    'Object Labels': 'Search by User Object Labels',
    'Name': 'Search by container Name',
    'Description': 'Search by container Description',
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
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
        ),
        itemCount: _searchController.searchResults.length,
        itemBuilder: (context, index) {
          return _searchResultCard(_searchController.searchResults[index]);
        });
  }

  Widget _searchResultCard(Result result) {
    CatalogedContainer catalogedContainer = isar!.catalogedContainers
        .filter()
        .containerUIDMatches(result.containerUID)
        .findFirstSync()!;

    return InkWell(
      onTap: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ContainerView(
              catalogedContainer: catalogedContainer,
            ),
          ),
        );
      },
      child: Builder(builder: (context) {
        switch (result.runtimeType) {
          case NameResult: //Name Result.
            return NameResultCard(nameResult: result as NameResult);

          case DescriptionResult: //Description Result.
            return DescriptionResultCard(
                descriptionResult: result as DescriptionResult);

          case ContainerTagResult: //ContainerTag Result.

            return ContainerTagResultCard(
                containerTagResult: result as ContainerTagResult);

          case PhotoLabelResult:
            return PhotoLabelResultCard(
                photoLabelResult: result as PhotoLabelResult);

          case ObjectLabelResult:
            return ObjectLabelResultCard(result: result as ObjectLabelResult);

          case MLPhotoLabelResult:
            return MLPhotoLabelResultCard(
                mlphotoLabelResult: result as MLPhotoLabelResult);

          case MLObjectLabelResult:
            return MLObjectLabelResultCard(
                result: result as MLObjectLabelResult);

          case MLTextResult:
            return MLTextElementResultCard(result: result as MLTextResult);

          default:
            return SizedBox.shrink();
        }
      }),
    );
  }
}

Future<ui.Image> getUiImage(String imageAssetPath) async {
  final decodedImage = File(imageAssetPath).readAsBytesSync();

  final codec = await ui.instantiateImageCodec(
    decodedImage,
  );

  return (await codec.getNextFrame()).image;
}
