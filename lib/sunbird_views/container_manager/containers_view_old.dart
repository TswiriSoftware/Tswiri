import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';

import 'package:flutter_google_ml_kit/sunbird_views/container_manager/new_container_view.dart';
import 'package:isar/isar.dart';

class ContainersView extends StatefulWidget {
  const ContainersView({Key? key}) : super(key: key);

  @override
  State<ContainersView> createState() => _ContainersViewState();
}

class _ContainersViewState extends State<ContainersView> {
  //Text Controller.
  TextEditingController searchController = TextEditingController();

  //Search FocusNode.
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  List<ContainerEntry> containers = [];

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
    search('');
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
      floatingActionButton: _focusNode.hasFocus ? null : _addButton(),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _focusNode.unfocus();
          });
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: containers.map((e) => containerCard(e)).toList(),
          ),
        ),
      ),
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

  Widget _searchIcon() {
    return const Icon(
      Icons.search,
      color: Colors.white,
    );
  }

  ///CONTAINER///

  Widget containerCard(ContainerEntry containerEntry) {
    return Builder(
      builder: (context) {
        Color containerColor =
            getContainerColor(containerUID: containerEntry.containerUID);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          color: Colors.white12,
          elevation: 5,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: containerColor, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///NAME///
                name(containerEntry),

                ///DESCRIPTION///
                description(containerEntry),

                ///TAGS///
                userTags(containerEntry, containerColor),

                ///ACTIONS///
                actions(containerEntry, containerColor),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget name(ContainerEntry containerEntry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///NAME///
        Text(
          'Name',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          containerEntry.name ?? containerEntry.containerUID,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Divider(
          height: 5,
          indent: 2,
        ),
      ],
    );
  }

  Widget description(ContainerEntry containerEntry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///DESCRIPTION///
        Text(
          'Description',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          containerEntry.description ?? '-',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Divider(
          height: 5,
          indent: 2,
        ),
      ],
    );
  }

  Widget userTags(ContainerEntry containerEntry, Color containerColor) {
    return Builder(
      builder: (context) {
        List<ContainerTag> tags = [];
        tags.addAll(isarDatabase!.containerTags
            .filter()
            .containerUIDContains(containerEntry.containerUID)
            .findAllSync());

        if (tags.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tags',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 5,
                  children:
                      tags.map((e) => tagChip(e, containerColor)).toList(),
                ),
              ),
            ],
          );
        } else {
          return Row();
        }
      },
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
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: containerColor,
      );
    });
  }

  Widget actions(ContainerEntry containerEntry, Color containerColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: TextButton.styleFrom(backgroundColor: containerColor),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContainerView(
                  containerEntry: containerEntry,
                ),
              ),
            );
            search('');
            setState(() {});
          },
          child: const Text(
            'Edit',
          ),
        ),
        ElevatedButton(
          style: TextButton.styleFrom(backgroundColor: containerColor),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContainerView(
                  containerEntry: containerEntry,
                ),
              ),
            );
            search('');
            setState(() {});
          },
          child: const Text(
            'Edit',
          ),
        )
      ],
    );
  }

  ///NEW CONTAINER///

  Widget _addButton() {
    return Visibility(
      visible: !isFocused,
      child: FloatingActionButton(
        elevation: 10,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewContainerView()),
          );

          search('');
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

  void search(String enteredKeyword) {
    if (enteredKeyword.isNotEmpty) {
      enteredKeyword = enteredKeyword.toLowerCase();
      containers = isarDatabase!.containerEntrys
          .filter()
          .nameContains(enteredKeyword, caseSensitive: false)
          .or()
          .descriptionContains(enteredKeyword, caseSensitive: false)
          .findAllSync();
    } else {
      containers = isarDatabase!.containerEntrys.where().findAllSync();
    }
  }
}
