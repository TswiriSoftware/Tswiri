import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/navigator_view.dart';
import 'package:isar/isar.dart';

List<String> filters = ['Tags', 'AI Tags', 'Photos'];

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  //Text Controller.
  TextEditingController searchController = TextEditingController();

  //Search FocusNode.
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  Map<String, String> filterTypes = {
    'Tags': 'Search by container Tags',
    'AI Tags': 'Search by AI Tags',
    'Photos': 'Search by Photos',
    'Name': 'Search by container Name',
    'Description': 'Search by container Description',
  };

  List<SearchObject> searchResults = [];

  @override
  void initState() {
    searchFunction('');

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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: _textField(),
          shadowColor: Colors.black54,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: _focusNode.hasFocus ? null : _searchButton(),
        body: GestureDetector(
          onTap: () {
            setState(() {
              _focusNode.unfocus();
            });
          },
          child: Stack(
            children: [
              _containers(),
              _filters(),
            ],
          ),
        ));
  }

  ///SEARCH///

  Widget _textField() {
    return TextField(
      focusNode: _focusNode,
      controller: searchController,
      onChanged: (value) {
        setState(() {
          searchFunction(value);
        });
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

  Widget _searchButton() {
    return Visibility(
      visible: !isFocused,
      child: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          setState(() {
            _focusNode.requestFocus();
          });
        },
        child: _searchIcon(),
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
      },
      selected: filters.contains(filter),
      selectedColor: sunbirdOrange,
      tooltip: tooltip,
      elevation: 5,
      shadowColor: Colors.black54,
    );
  }

  void _onSelected(bool selected, String filter) {
    if (filters.contains(filter)) {
      setState(() {
        filters.removeWhere((element) => element == filter);
      });
    } else {
      setState(() {
        filters.add(filter);
      });
    }
  }

  ///CONTAINERS///

  Widget _containers() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 50),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        SearchObject containerEntry = searchResults.elementAt(index);
        return containerCard(containerEntry);
      },
    );
  }

  Widget containerCard(SearchObject searchObject) {
    return Builder(
      builder: (context) {
        Color containerColor = getContainerColor(
            containerUID: searchObject.containerEntry.containerUID);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.white12,
          elevation: 5,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: containerColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///NAME///
                Text(
                  'Name',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  searchObject.containerEntry.name ??
                      searchObject.containerEntry.containerUID,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Divider(
                  height: 5,
                  indent: 2,
                ),

                ///DESCRIPTION///
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  searchObject.containerEntry.description ?? '-',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                ///TAGS///

                Builder(
                  builder: (context) {
                    if (searchObject.tags.isNotEmpty &&
                        filters.contains('Tags')) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            height: 5,
                            indent: 2,
                          ),
                          Text(
                            'Tags',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          userTags(searchObject.tags, containerColor),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),

                ///PHOTO(S)///
                Builder(
                  builder: (context) {
                    if (searchObject.containerPhotos.isNotEmpty &&
                        filters.contains('Photos')) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            height: 5,
                            indent: 2,
                          ),
                          Text(
                            'Photos',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          photoCard(searchObject.containerPhotos.first,
                              containerColor),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),

                Builder(
                  builder: (context) {
                    if (searchObject.photoTags.isNotEmpty &&
                        filters.contains('AI Tags')) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            height: 5,
                            indent: 2,
                          ),
                          Text(
                            'Photo Tags',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          photoTags(searchObject.photoTags, containerColor),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),

                const Divider(
                  height: 5,
                  indent: 2,
                ),

                containerActions(searchObject.containerEntry, containerColor)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget containerActions(ContainerEntry containerEntry, Color containerColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: TextButton.styleFrom(backgroundColor: containerColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContainerView(
                  containerEntry: containerEntry,
                ),
              ),
            );
          },
          child: const Text('Edit'),
        ),
        ElevatedButton(
          style: TextButton.styleFrom(backgroundColor: containerColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NavigatorView(containerEntry: containerEntry),
              ),
            );
          },
          child: const Text('Find'),
        ),
      ],
    );
  }

  ///TAGS///

  Widget userTags(List<ContainerTag> tags, Color containerColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 5,
        children: tags.map((e) => tagChip(e, containerColor)).toList(),
      ),
    );
  }

  Widget tagChip(ContainerTag containerTag, Color containerColor) {
    return Builder(builder: (context) {
      String tag = isarDatabase!.tags
          .filter()
          .idEqualTo(containerTag.tagID)
          .findFirstSync()!
          .tag;
      return Chip(
        label: Text(
          tag,
        ),
        backgroundColor: containerColor,
      );
    });
  }

  ///PHOTO TAGS///

  Widget photoTags(List<PhotoTag> photoTags, Color containerColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 5,
        children: photoTags
            .map((e) => photoTagChip(e.tagUID, containerColor))
            .toList(),
      ),
    );
  }

  Widget photoTagChip(int tagUID, Color containerColor) {
    return Builder(builder: (context) {
      MlTag mlTag =
          isarDatabase!.mlTags.filter().idEqualTo(tagUID).findFirstSync()!;
      return Chip(
        avatar: Builder(builder: (context) {
          switch (mlTag.tagType) {
            case mlTagType.text:
              return const Icon(
                Icons.format_size,
                size: 15,
              );

            case mlTagType.objectLabel:
              return const Icon(
                Icons.emoji_objects,
                size: 15,
              );

            case mlTagType.imageLabel:
              return const Icon(
                Icons.photo,
                size: 15,
              );
          }
        }),
        label: Text(
          mlTag.tag,
        ),
        backgroundColor: containerColor,
      );
    });
  }

  Widget photoCard(ContainerPhoto containerPhoto, Color borderColor) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.file(
            File(containerPhoto.photoThumbnailPath),
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width * 0.22,
          ),
        ),
      ),
    );
  }

  Widget image(ContainerPhoto containerPhoto) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Image.file(
        File(containerPhoto.photoThumbnailPath),
      ),
    );
  }

  void searchFunction(String enteredKeyword) {
    //Convert to lowercase.
    enteredKeyword = enteredKeyword.toLowerCase();
    searchResults = [];

    if (filters.contains('Name')) {
      //containerEntries.
      List<SearchObject> searchObjects = [];

      //Add found containerEntries.
      searchObjects.addAll(
        isarDatabase!.containerEntrys
            .filter()
            .nameContains(enteredKeyword.toLowerCase(), caseSensitive: false)
            .findAllSync()
            .map(
              (e) => SearchObject(
                  containerEntry: e,
                  tags: [],
                  photoTags: [],
                  containerPhotos: [],
                  score: 1),
            ),
      );

      for (SearchObject searchObject in searchObjects) {
        if (searchResults.contains(searchObject)) {
          //Not used in this case.
          //searchResults.where((element) => element == searchObject).first.
        } else {
          searchResults.add(searchObject);
        }
      }
    }

    if (filters.contains('AI Tags') && enteredKeyword.isNotEmpty) {
      //MlTags.
      List<MlTag> mlTags = [];
      //Found MlTags.
      mlTags.addAll(isarDatabase!.mlTags
          .filter()
          .tagContains(enteredKeyword, caseSensitive: false)
          .findAllSync());

      //PhotoTags.
      List<PhotoTag> photoTags = [];
      //Found PhotoTags.
      photoTags.addAll(isarDatabase!.photoTags
          .filter()
          .repeat(mlTags, (q, MlTag element) => q.tagUIDEqualTo(element.id))
          .sortByConfidence()
          .findAllSync());

      //ContainerPhotos.
      List<ContainerPhoto> containerPhotos = [];
      //Found ContainerPhotos.
      containerPhotos.addAll(isarDatabase!.containerPhotos
          .filter()
          .repeat(photoTags,
              (q, PhotoTag element) => q.photoPathMatches(element.photoPath))
          .findAllSync());

      //ContainerEntries.
      List<ContainerEntry> containerEntries = [];

      //Found ContainerEntries.
      containerEntries.addAll(isarDatabase!.containerEntrys
          .filter()
          .repeat(
              containerPhotos,
              (q, ContainerPhoto element) =>
                  q.containerUIDMatches(element.containerUID))
          .findAllSync());

      for (ContainerEntry containerEntry in containerEntries) {
        List<ContainerPhoto> currentContainerPhotos = containerPhotos
            .where((element) =>
                element.containerUID == containerEntry.containerUID)
            .toList();

        List<PhotoTag> currentPhotoTags = [];
        for (ContainerPhoto currentContainerPhoto in currentContainerPhotos) {
          currentPhotoTags.addAll(photoTags
              .where((element) =>
                  element.photoPath == currentContainerPhoto.photoPath)
              .toList());
        }

        //Search Object
        SearchObject searchObject = SearchObject(
            containerEntry: containerEntry,
            tags: [],
            photoTags: [],
            containerPhotos: [],
            score: 0);

        if (searchResults.contains(searchObject)) {
          //Get search object.
          SearchObject currentSearchObject =
              searchResults.where((element) => element == searchObject).first;
          //Remove it.
          searchResults.removeWhere((element) =>
              element.containerEntry.containerUID ==
              currentSearchObject.containerEntry.containerUID);
          //Update it.
          currentSearchObject.containerPhotos.addAll(currentContainerPhotos);
          currentSearchObject.photoTags.addAll(currentPhotoTags);
          currentSearchObject.score = currentSearchObject.score + 1;

          searchResults.add(currentSearchObject);
        } else {
          SearchObject searchObject = SearchObject(
              containerEntry: containerEntry,
              tags: [],
              photoTags: currentPhotoTags,
              containerPhotos: currentContainerPhotos,
              score: 1);

          searchResults.add(searchObject);
        }
      }
    }

    if (filters.contains('Tags') && enteredKeyword.isNotEmpty) {
      //Tags.
      List<Tag> tags = [];
      //Found Tags.
      tags.addAll(isarDatabase!.tags
          .filter()
          .tagContains(enteredKeyword, caseSensitive: false)
          .findAllSync());

      List<ContainerTag> containerTags = [];

      containerTags.addAll(isarDatabase!.containerTags
          .filter()
          .repeat(tags, (q, Tag element) => q.tagIDEqualTo(element.id))
          .findAllSync());

      //log(containerTags.toString());

      //ContainerEntries.
      List<ContainerEntry> containerEntries = [];

      //Found ContainerEntries.
      containerEntries.addAll(isarDatabase!.containerEntrys
          .filter()
          .repeat(
              containerTags,
              (q, ContainerTag element) =>
                  q.containerUIDMatches(element.containerUID))
          .findAllSync());

      for (ContainerEntry containerEntry in containerEntries) {
        List<ContainerTag> currentContainerTags = containerTags
            .where((element) =>
                element.containerUID == containerEntry.containerUID)
            .toList();

        //Search Object
        SearchObject searchObject = SearchObject(
            containerEntry: containerEntry,
            tags: [],
            photoTags: [],
            containerPhotos: [],
            score: 0);

        if (searchResults.contains(searchObject)) {
          //Get search object.
          SearchObject currentSearchObject =
              searchResults.where((element) => element == searchObject).first;
          //Remove it.
          searchResults.removeWhere((element) =>
              element.containerEntry.containerUID ==
              currentSearchObject.containerEntry.containerUID);

          //Update it.
          currentSearchObject.tags.addAll(currentContainerTags);
          currentSearchObject.score = currentSearchObject.score + 1;

          searchResults.add(currentSearchObject);
        } else {
          SearchObject searchObject = SearchObject(
              containerEntry: containerEntry,
              tags: currentContainerTags,
              photoTags: [],
              containerPhotos: [],
              score: 1);

          searchResults.add(searchObject);
        }
      }
    }

    //Take the top 30
    if (searchResults.isEmpty) {
      //Posible sorting functionality ?
      searchResults.addAll(isarDatabase!.containerEntrys
          .where()
          .findAllSync()
          .take(30)
          .map((e) => SearchObject(
              containerEntry: e,
              tags: [],
              photoTags: [],
              containerPhotos: [],
              score: 0))
          .toList());
    }

    setState(() {
      searchResults.sort(((a, b) => b.score.compareTo(a.score)));
    });

    log(searchResults.toString());
  }
}

class SearchObject {
  SearchObject(
      {required this.containerEntry,
      required this.tags,
      required this.photoTags,
      required this.containerPhotos,
      required this.score});

  final ContainerEntry containerEntry;
  final List<ContainerTag> tags;
  final List<PhotoTag> photoTags;
  final List<ContainerPhoto> containerPhotos;
  int score;

  @override
  String toString() {
    // TODO: implement toString
    return '\nuid: ${containerEntry.containerUID}, tags: $tags, score: $score';
  }

  @override
  bool operator ==(Object other) {
    if (other is SearchObject && other.runtimeType == runtimeType) {
      if (other.containerEntry.containerUID == containerEntry.containerUID) {
        return true;
      }
    }
    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;




}
