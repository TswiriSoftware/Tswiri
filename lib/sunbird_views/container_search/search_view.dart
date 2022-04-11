import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo_thumbnail/container_photo_thumbnail.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/navigator_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_search/objects/container_search_builder.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();

  bool showFilterOptions = false;
  bool mlTagSearch = true;
  bool tagSearch = true;
  bool normalSearch = true;
  bool showContainerDescriptions = true;
  bool showContainerPhotos = true;

  List<ContainerSearchBuilder> searchResults = [];

  @override
  void initState() {
    searchFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: floatingSearchBar(),
      body: Column(
        children: [
          //SearchBar with filters

          _numberOfResults(),
          _containerListView(),
          //_searchBar(),
        ],
      ),
    );
  }

  Widget floatingSearchBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrange, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              color: const Color(0xFF232323)),
          child: Column(
            children: [
              _searchOptions(),
              const Divider(
                height: 10,
                thickness: 1,
              ),
              _searchField(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _numberOfResults() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Number Of Results: ' + searchResults.length.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: (enteredKeyword) {
              searchFunction(enteredKeyword: enteredKeyword);
              setState(() {});
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Options: ',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              _optionDividerLight(),

              //1. Normal Search.
              optionWidget(
                label: 'Normal search: ',
                checkbox: Checkbox(
                  value: normalSearch,
                  onChanged: (value) {
                    normalSearch = !normalSearch;
                    setState(() {});
                  },
                ),
              ),
              _optionDividerLight(),

              //2. Tag Search.
              optionWidget(
                label: 'Tag search: ',
                checkbox: Checkbox(
                  value: tagSearch,
                  onChanged: (value) {
                    tagSearch = !tagSearch;
                    setState(() {});
                  },
                ),
              ),
              _optionDividerLight(),

              //3. Ml Tag Search.
              optionWidget(
                label: 'Photo search:',
                checkbox: Checkbox(
                  value: mlTagSearch,
                  onChanged: (value) {
                    mlTagSearch = !mlTagSearch;
                    setState(() {});
                  },
                ),
              ),
              _optionDividerHeavy(),
              Text(
                'Display Options: ',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              _optionDividerLight(),

              //4. Show Container Descriptions.
              optionWidget(
                label: 'Show container descriptions: ',
                checkbox: Checkbox(
                  value: showContainerDescriptions,
                  onChanged: (value) {
                    showContainerDescriptions = !showContainerDescriptions;
                    setState(() {});
                  },
                ),
              ),
              _optionDividerLight(),

              //4. Show Container photos.
              optionWidget(
                label: 'Show container photos: ',
                checkbox: Checkbox(
                  value: showContainerPhotos,
                  onChanged: (value) {
                    showContainerPhotos = !showContainerPhotos;
                    setState(() {});
                  },
                ),
              ),

              _optionDividerHeavy(),
              //Option button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Options',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
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
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Options',
                style: Theme.of(context).textTheme.bodySmall,
              ),
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
          );
        }
      },
    );
  }

  Widget optionWidget({required String label, required Widget checkbox}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 30, child: checkbox),
          ],
        ),
      ],
    );
  }

  Widget _optionDividerLight() {
    return const Divider(
      height: 10,
      thickness: 1,
    );
  }

  Widget _optionDividerHeavy() {
    return const Divider(
      height: 15,
      thickness: 2,
      color: Colors.white54,
    );
  }

  void searchFunction({String? enteredKeyword}) {
    searchResults = [];

    //Empty search.
    if (enteredKeyword == null || enteredKeyword.isEmpty) {
      searchResults = isarDatabase!.containerEntrys
          .where()
          .findAllSync()
          .map((e) => ContainerSearchBuilder(containerEntry: e))
          .toList();
    }

    if (enteredKeyword != null) {
      //Normal Search.
      if (enteredKeyword.isNotEmpty && normalSearch) {
        List<ContainerSearchBuilder> containerSearchBuilders = isarDatabase!
            .containerEntrys
            .filter()
            .group((q) => q
                .nameContains(enteredKeyword, caseSensitive: false)
                .or()
                .descriptionContains(enteredKeyword, caseSensitive: false)
                .or()
                .containerUIDContains(
                  enteredKeyword,
                ))
            .findAllSync()
            .map((e) => ContainerSearchBuilder(containerEntry: e))
            .toList();

        searchResults.addAll(containerSearchBuilders);
      }

      //Ml Tag Search.
      if (mlTagSearch) {
        List<MlTag> mlTags = isarDatabase!.mlTags
            .filter()
            .tagContains(enteredKeyword, caseSensitive: false)
            .findAllSync();

        if (mlTags.isNotEmpty) {
          List<PhotoTag> photoTags = [];
          photoTags.addAll(isarDatabase!.photoTags
              .filter()
              .repeat(mlTags, (q, MlTag element) => q.tagUIDEqualTo(element.id))
              .sortByConfidence()
              .findAllSync());

          List<ContainerPhoto> containerPhotos = [];
          containerPhotos.addAll(isarDatabase!.containerPhotos
              .filter()
              .repeat(
                  photoTags,
                  (q, PhotoTag element) =>
                      q.photoPathMatches(element.photoPath))
              .findAllSync());

          List<ContainerEntry> containerEntries = [];
          containerEntries.addAll(isarDatabase!.containerEntrys
              .filter()
              .repeat(
                  containerPhotos,
                  (q, ContainerPhoto element) =>
                      q.containerUIDMatches(element.containerUID))
              .findAllSync());

          if (containerEntries.isNotEmpty) {
            List<ContainerSearchBuilder> containerSearchBuilders = [];

            for (ContainerEntry containerEntry in containerEntries) {
              List<ContainerPhoto> currentContainerPhoto = containerPhotos
                  .where((element) =>
                      element.containerUID == containerEntry.containerUID)
                  .toList();
              List<ContainerPhotoThumbnail> thumbnails = [];

              thumbnails.addAll(isarDatabase!.containerPhotoThumbnails
                  .filter()
                  .repeat(
                      currentContainerPhoto,
                      (q, ContainerPhoto element) =>
                          q.photoPathMatches(element.photoPath))
                  .findAllSync());

              containerSearchBuilders.add(ContainerSearchBuilder(
                  containerEntry: containerEntry,
                  containerThumbnails: thumbnails));
            }

            searchResults.addAll(containerSearchBuilders);
          }
        }
      }

      //Tag Search.
      if (tagSearch) {
        //Here we have an option of tagContains or tagStartsWith
        List<Tag> tags = isarDatabase!.tags
            .filter()
            .tagContains(enteredKeyword, caseSensitive: false)
            .findAllSync();

        List<ContainerTag> containerTags = [];
        containerTags.addAll(isarDatabase!.containerTags
            .filter()
            .repeat(tags, (q, Tag element) => q.idEqualTo(element.id))
            .findAllSync());

        //Not sure why but need to check if its empty ?
        if (containerTags.isNotEmpty) {
          List<ContainerSearchBuilder> containerSearchBuilders = isarDatabase!
              .containerEntrys
              .filter()
              .repeat(
                  containerTags,
                  (q, ContainerTag element) =>
                      q.containerUIDMatches(element.containerUID))
              .findAllSync()
              .map((e) => ContainerSearchBuilder(containerEntry: e))
              .toList();

          searchResults.addAll(containerSearchBuilders);
        }
      }
    }

    //Remove any duplicates from List.
    searchResults.unique(((element) => element.containerEntry.containerUID));
  }

  Widget _containerListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          ContainerSearchBuilder containerEntry =
              searchResults.elementAt(index);
          return containerListViewTile(containerEntry);
        },
      ),
    );
  }

  Widget containerListViewTile(ContainerSearchBuilder element) {
    return Builder(
      builder: (context) {
        Color containerColor =
            getContainerColor(containerUID: element.containerEntry.containerUID)
                .withOpacity(0.9);

        return LightContainer(
            margin: 2.5,
            padding: 1,
            borderRadius: 12,
            borderWidth: 0.8,
            borderColor: Colors.white,
            child: CustomOutlineContainer(
              padding: 5,
              margin: 1,
              borderRadius: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Name / UID
                  containerName(element: element),

                  //Description
                  containerDescription(
                      description: element.containerEntry.description),

                  //Photos
                  containerPhotos(element: element),

                  //Actions
                  containerActions(
                      element: element, containerColor: containerColor),
                ],
              ),
              outlineColor: containerColor,
            ));
      },
    );
  }

  Widget containerName({required ContainerSearchBuilder element}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (context) {
            if (element.containerEntry.name != null) {
              return Text(
                'Name',
                style: Theme.of(context).textTheme.bodySmall,
              );
            } else {
              return Text(
                'UID',
                style: Theme.of(context).textTheme.bodySmall,
              );
            }
          },
        ),
        Text(
          element.containerEntry.name ?? element.containerEntry.containerUID,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Divider(
          height: 5,
        ),
      ],
    );
  }

  Widget containerDescription({required String? description}) {
    return Builder(
      builder: (context) {
        if (showContainerDescriptions) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                description ?? '-',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(
                height: 5,
              ),
            ],
          );
        } else {}
        return Container();
      },
    );
  }

  Widget containerPhotos({required ContainerSearchBuilder element}) {
    return Builder(
      builder: (context) {
        if (showContainerPhotos &&
            element.containerThumbnails != null &&
            element.containerThumbnails!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: element.containerThumbnails!
                    .map((e) => photoWidget(e))
                    .toList(),
              ),
              const Divider(
                height: 5,
              ),
            ],
          );
        } else if (showContainerPhotos) {
          //BUG HERE :D:D:D:D:D:D: fix it @049er
          List<ContainerPhoto> containerPhotos = [];

          if (isarDatabase!.containerPhotos
              .filter()
              .containerUIDMatches(element.containerEntry.containerUID)
              .findAllSync()
              .isNotEmpty) {
            containerPhotos.addAll(isarDatabase!.containerPhotos
                .filter()
                .containerUIDMatches(element.containerEntry.containerUID)
                .findAllSync());
          }

          List<ContainerPhotoThumbnail> thumbnails = [];
          if (containerPhotos.isNotEmpty) {
            thumbnails = isarDatabase!.containerPhotoThumbnails
                .filter()
                .repeat(
                    containerPhotos,
                    (q, ContainerPhoto element) =>
                        q.photoPathMatches(element.photoPath))
                .findAllSync();
          }

          //log(containerPhotos.toString());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: thumbnails.map((e) => photoWidget(e)).toList(),
              ),
              const Divider(
                height: 5,
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget photoWidget(ContainerPhotoThumbnail containerPhotoThumbnail) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: OrangeOutlineContainer(
        padding: 2,
        child: Image.file(
          File(containerPhotoThumbnail.thumbnailPhotoPath),
        ),
      ),
    );
  }

  Widget containerActions(
      {required ContainerSearchBuilder element,
      required Color containerColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ContainerView(containerEntry: element.containerEntry),
              ),
            );
          },
          child: CustomOutlineContainer(
            padding: 5,
            margin: 5,
            width: 75,
            child: Center(
              child: Text(
                'Edit',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            outlineColor: containerColor,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NavigatorView(containerEntry: element.containerEntry),
              ),
            );
          },
          child: CustomOutlineContainer(
            padding: 5,
            margin: 5,
            width: 75,
            child: Center(
              child: Text(
                'Find',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            outlineColor: containerColor,
          ),
        )
      ],
    );
  }
}

//List extension for removing duplicates
extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
