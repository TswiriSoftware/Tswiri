import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/user_tag/user_tag.dart';
import 'package:flutter_google_ml_kit/objects/search/search_object.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/navigator_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/default_card/defualt_card.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/dividers/dividers.dart';
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
    'Photos': 'Search by Photos',
    'Photo Tags': 'Search by Photo Tags',
    'Name': 'Search by container Name',
    'Description': 'Search by container Description',
    'Barcode': 'Search by container Barcodes'
  };
  List<SContainer> searchR = [];
  Color highlightColor = Colors.blueAccent;

  @override
  void initState() {
    search('');
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
        appBar: _appBar(),
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

  ///APP BAR///
  AppBar _appBar() {
    return AppBar(
      title: _textField(),
      shadowColor: Colors.black54,
    );
  }

  ///SEARCH///

  Widget _textField() {
    return TextField(
      focusNode: _focusNode,
      controller: searchController,
      onChanged: (value) {
        setState(() {
          search(value);
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
        setState(() {
          search(searchController.text);
        });
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
      itemCount: searchR.length,
      itemBuilder: (context, index) {
        SContainer searchObject = searchR.elementAt(index);
        //
        //log(searchObject.toString());
        return defaultCard(
            body: container(searchObject), color: searchObject.color);
      },
    );
  }

  Widget container(SContainer sContainer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        containerName(
            sContainer.container.name, sContainer.container.containerUID),
        containerDescription(sContainer.container.description),
        containerBarcode(sContainer.container.barcodeUID),
        containerTags(sContainer.tags ?? [], sContainer.color),
        mlTags(sContainer.mlTags, sContainer.color),
        userTags(sContainer.userTags, sContainer.color),
        photos(sContainer.photos, sContainer.color),
        options(sContainer.container, sContainer.color),
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
                    style: filters.contains('Name')
                        ? TextStyle(
                            color: highlightColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)
                        : Theme.of(context).textTheme.bodyLarge,
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
      visible: filters.contains('Description'),
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
      visible: filters.contains('Barcode'),
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
      visible: filters.contains('Tags') && containerTags.isNotEmpty,
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
      visible: filters.contains('Photo Tags') && mlTags.isNotEmpty,
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
      visible: filters.contains('Photo Tags') && userTags.isNotEmpty,
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
      visible: filters.contains('Photos') && photos.isNotEmpty,
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
      color: highlightColor,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ContainerView(containerEntry: containerEntry),
              ),
            );
            search(searchController.text);
          },
          child: const Text('Edit'),
          style: ElevatedButton.styleFrom(primary: color),
        ),
        ElevatedButton(
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
          style: ElevatedButton.styleFrom(primary: color),
        ),
      ],
    );
  }

  ///SEARCH///
  void search(String text) {
    text.toLowerCase();
    searchR = [];
    if (text.isNotEmpty) {
      List<TagText> tagTextMatches = isarDatabase!.tagTexts
          .filter()
          .textContains(text, caseSensitive: false)
          .findAllSync();

      if (filters.contains('Name')) {
        ///Do name Search.
        List<SContainer> containers = isarDatabase!.containerEntrys
            .filter()
            .nameContains(text, caseSensitive: false)
            .findAllSync()
            .map((e) => SContainer(container: e))
            .toList();

        for (var container in containers) {
          if (!searchR.contains(container)) {
            searchR.add(container);
          }
        }
      }

      if (filters.contains('Description')) {
        ///Do description Search.
        List<SContainer> containers = isarDatabase!.containerEntrys
            .filter()
            .descriptionContains(text, caseSensitive: false)
            .findAllSync()
            .map((e) => SContainer(container: e))
            .toList();

        for (var container in containers) {
          if (!searchR.contains(container)) {
            searchR.add(container);
          }
        }
      }

      if (filters.contains('Tags')) {
        //Do containerTag search.
        List<ContainerTag> containerTags = isarDatabase!.containerTags
            .filter()
            .repeat(tagTextMatches,
                (q, TagText textID) => q.textIDEqualTo(textID.id))
            .findAllSync();

        if (containerTags.isNotEmpty) {
          List<SContainer> containers = isarDatabase!.containerEntrys
              .filter()
              .repeat(
                  containerTags,
                  (q, ContainerTag element) =>
                      q.containerUIDMatches(element.containerUID))
              .findAllSync()
              .map((e) => SContainer(
                  container: e,
                  tags: containerTags
                      .where(
                          (element) => element.containerUID == e.containerUID)
                      .toList()))
              .toList();

          for (var container in containers) {
            if (searchR.contains(container)) {
              searchR
                  .firstWhere((element) =>
                      element.container.containerUID ==
                      container.container.containerUID)
                  .merge(container);
            } else {
              searchR.add(container);
            }
          }
        }
      }

      if (filters.contains('Barcode')) {
        ///Do description Search.
        List<SContainer> containers = isarDatabase!.containerEntrys
            .filter()
            .barcodeUIDContains(text, caseSensitive: false)
            .findAllSync()
            .map((e) => SContainer(container: e))
            .toList();

        for (var container in containers) {
          if (!searchR.contains(container)) {
            searchR.add(container);
          }
        }
      }

      if (filters.contains('Photo Tags') || filters.contains('Photos')) {
        //log(tagTextMatches.toString());
        List<MlTag> mlTags = isarDatabase!.mlTags
            .filter()
            .repeat(
                tagTextMatches,
                (q, TagText tagText) =>
                    q.textIDEqualTo(tagText.id).and().blackListedEqualTo(false))
            .findAllSync();

        List<UserTag> userTags = isarDatabase!.userTags
            .filter()
            .repeat(tagTextMatches,
                (q, TagText tagText) => q.textIDEqualTo(tagText.id))
            .findAllSync();

        List<Photo> photos = [];

        photos.addAll(isarDatabase!.photos
            .filter()
            .optional(
                mlTags.isNotEmpty,
                (q) => q.repeat(
                    mlTags, (q, MlTag element) => q.idEqualTo(element.photoID)))
            .optional(
                userTags.isNotEmpty,
                (q) => q.repeat(userTags,
                    (q, UserTag userTag) => q.idEqualTo(userTag.photoID)))
            .findAllSync());

        photos.toSet().toList();

        List<SPhoto> sPhotos = photos
            .map(
              (e) => SPhoto(
                photo: e,
                mlTags: mlTags
                    .where((mlTag) =>
                        mlTag.photoID == e.id && mlTag.blackListed == false)
                    .toSet()
                    .toList(),
                userTags: userTags
                    .where((userTag) => userTag.photoID == e.id)
                    .toList(),
              ),
            )
            .toList();

        List<SContainer> containers = isarDatabase!.containerEntrys
            .filter()
            .repeat(
                sPhotos,
                (q, SPhoto sphoto) =>
                    q.containerUIDMatches(sphoto.photo.containerUID))
            .findAllSync()
            .map(
              (e) => SContainer(
                container: e,
                sPhotos: sPhotos
                    .where((_sPhoto) =>
                        _sPhoto.photo.containerUID == e.containerUID)
                    .toList(),
              ),
            )
            .toList();

        for (var container in containers) {
          if (searchR.contains(container)) {
            searchR
                .firstWhere((element) =>
                    element.container.containerUID ==
                    container.container.containerUID)
                .merge(container);
          } else {
            searchR.add(container);
          }
        }
      }
    } else {
      searchR = isarDatabase!.containerEntrys
          .where()
          .findAllSync()
          .map((e) => SContainer(container: e))
          .toList();
    }
  }
}
