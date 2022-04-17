import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/grid/container_grid_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/new_container_view.dart';
import 'package:isar/isar.dart';

class ContainerView2 extends StatefulWidget {
  const ContainerView2({Key? key, required this.containerEntry})
      : super(key: key);
  final ContainerEntry containerEntry;

  @override
  State<ContainerView2> createState() => _ContainerView2State();
}

class _ContainerView2State extends State<ContainerView2> {
  late ContainerEntry _containerEntry;
  late Color _containerColor;

  //Name.
  TextEditingController nameController = TextEditingController();
  final _nameNode = FocusNode();
  bool nameIsFocused = false;

  //Description.
  TextEditingController descriptionController = TextEditingController();
  final _descriptionNode = FocusNode();
  bool descriptionIsFocused = false;

  //Tags
  TextEditingController tagsController = TextEditingController();
  final _tagsNode = FocusNode();
  bool showTagEditor = false;

  @override
  void initState() {
    _containerEntry = widget.containerEntry;
    _containerColor =
        getContainerColor(containerUID: _containerEntry.containerUID);
    nameController.text = _containerEntry.name ?? '';
    descriptionController.text = _containerEntry.description ?? '';

    _nameNode.addListener(() {
      setState(() {
        nameIsFocused = _nameNode.hasFocus;
      });
    });

    _descriptionNode.addListener(() {
      setState(() {
        descriptionIsFocused = _descriptionNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameNode.dispose();
    _descriptionNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  ///APP BAR///

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: _title(),
      shadowColor: Colors.black54,
    );
  }

  Text _title() {
    return Text(
      _containerEntry.name ?? _containerEntry.containerUID,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  ///BODY///
  ListView _body() {
    return ListView(
      children: [
        //Container info.
        _info(),

        //Container children.
        _children(),

        //Tags
        _tags(),
      ],
    );
  }

  ///CONTAINER INFO///
  Widget _info() {
    return Card(
      key: const Key('_info'),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _containerColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoHeading(),
            _dividerHeading(),
            _name(),
            _divider(),
            _description(),
            _divider(),
            _infoToolTip(),
          ],
        ),
      ),
    );
  }

  Widget _infoHeading() {
    return Text('Info', style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _name() {
    return InkWell(
      onTap: () {
        setState(() {
          nameIsFocused = !nameIsFocused;
          if (nameIsFocused) {
            _nameNode.requestFocus();
          }
        });
      },
      child: Builder(builder: (context) {
        if (nameIsFocused) {
          return _nameEdit();
        } else {
          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    _containerEntry.name ?? _containerEntry.containerUID,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _description() {
    return InkWell(
      onTap: () {
        setState(() {
          descriptionIsFocused = !descriptionIsFocused;
          if (descriptionIsFocused) {
            _descriptionNode.requestFocus();
          }
        });
      },
      child: Builder(builder: (context) {
        if (descriptionIsFocused) {
          return _descriptionEdit();
        } else {
          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    _containerEntry.description ?? '-',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _nameEdit() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: nameController,
        focusNode: _nameNode,
        onSubmitted: (value) {
          saveName(value);
        },
        style: const TextStyle(fontSize: 18),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Name',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          suffixIcon: IconButton(
            onPressed: () {
              saveName(nameController.text);
            },
            icon: const Icon(Icons.save),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: _containerColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _containerColor)),
        ),
      ),
    );
  }

  Widget _descriptionEdit() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: descriptionController,
        focusNode: _descriptionNode,
        onSubmitted: (value) {
          saveDescription(value);
        },
        style: const TextStyle(fontSize: 18),
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Description',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          suffixIcon: IconButton(
            onPressed: () {
              saveDescription(nameController.text);
            },
            icon: const Icon(Icons.save),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: _containerColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _containerColor)),
        ),
      ),
    );
  }

  Widget _infoToolTip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('tap to edit', style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }

  void saveName(String value) {
    if (value.isNotEmpty) {
      _nameNode.unfocus();
      _containerEntry.name = value;
    } else {
      nameController.text =
          _containerEntry.name ?? _containerEntry.containerUID;
    }
    isarDatabase!
        .writeTxnSync((isar) => isar.containerEntrys.putSync(_containerEntry));
  }

  void saveDescription(String value) {
    if (value.isNotEmpty) {
      _descriptionNode.unfocus();
      _containerEntry.description = value;
    } else {
      descriptionController.text = _containerEntry.description ?? '';
    }
    isarDatabase!
        .writeTxnSync((isar) => isar.containerEntrys.putSync(_containerEntry));
  }

  ///CHILDREN///

  Widget _children() {
    return Card(
      key: const Key('_children'),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _containerColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _childrenHeading(),
            _dividerHeading(),
            _childrenListView(),
            _divider(),
            _childrenActions(),
          ],
        ),
      ),
    );
  }

  Widget _childrenHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Contains', style: Theme.of(context).textTheme.headlineSmall),
        ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContainerGridView(
                      containerEntry: _containerEntry,
                      containerTypeColor: _containerColor),
                ),
              );
              setState(() {});
            },
            child: _gridButton()),
      ],
    );
  }

  Widget _gridButton() {
    return Row(
      children: [
        Text('Grid ', style: Theme.of(context).textTheme.bodyMedium),
        const Icon(
          Icons.grid_4x4,
          size: 20,
        ),
      ],
    );
  }

  Widget _childrenListView() {
    return Builder(builder: (context) {
      List<ContainerRelationship> relationships = [];
      relationships.addAll(isarDatabase!.containerRelationships
          .filter()
          .parentUIDMatches(_containerEntry.containerUID)
          .findAllSync());

      if (relationships.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: relationships.length,
          itemBuilder: (context, index) {
            return _childCard(relationships[index]);
          },
        );
      } else {
        return const Text('-');
      }
    });
  }

  Widget _childCard(ContainerRelationship containerRelationship) {
    return Builder(builder: (context) {
      ContainerEntry containerEntry =
          getContainerEntry(containerUID: containerRelationship.containerUID);
      Color containerColor =
          getContainerColor(containerUID: containerRelationship.containerUID);

      return Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: containerColor, width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  containerEntry.name ?? containerRelationship.containerUID,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContainerView2(
                                containerEntry: containerEntry,
                              )),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _childrenActions() {
    return Row(
      children: [
        _multipleContainers(),
        _newContainer(),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  ElevatedButton _newContainer() {
    return ElevatedButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewContainerView(
              parentContainer: _containerEntry,
            ),
          ),
        );
        setState(() {});
      },
      child: Row(
        children: [
          Text(
            'New',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Icon(Icons.add),
        ],
      ),
    );
  }

  ElevatedButton _multipleContainers() {
    return ElevatedButton(
      onPressed: () async {
        //TODO: implement multiple scan.
      },
      child: Row(
        children: [
          Text(
            'Scan',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Icon(Icons.add),
        ],
      ),
    );
  }

  ///TAGS///

  Widget _tags() {
    return Card(
      key: const Key('_tags'),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _containerColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tagsHeading(),
            _dividerHeading(),
            _tagsWrap(),
          ],
        ),
      ),
    );
  }

  Widget _tagsHeading() {
    return Text('Tags', style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _tagsWrap() {
    return Builder(builder: (context) {
      List<ContainerTag> containerTags = [];
      containerTags.addAll(isarDatabase!.containerTags
          .filter()
          .containerUIDMatches(_containerEntry.containerUID)
          .findAllSync());
      List<Widget> tags = [addTag()];
      tags.addAll(containerTags.map((e) => tag(e)).toList());

      return Wrap(
        children: tags,
      );
    });
  }

  Widget addTag() {
    return InputChip(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _containerColor, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: () {},
      label: Text('+'),
    );
  }

  Widget _bottomSheet() {
    return Visibility(
      child: Row(
        children: [],
      ),
    );
  }

  Widget tag(ContainerTag containerTag) {
    return Builder(builder: (context) {
      Tag tag = isarDatabase!.tags.getSync(containerTag.tagID)!;
      return Chip(
        backgroundColor: _containerColor,
        label: Text(
          tag.tag,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    });
  }

  ///MISC///

  Divider _divider() {
    return const Divider(
      height: 8,
      indent: 2,
      color: Colors.white30,
    );
  }

  Divider _dividerHeading() {
    return const Divider(
      height: 8,
      thickness: 1,
      color: Colors.white,
    );
  }
}

//  Widget _children() {
  // return Card(
  //   key: const Key('_containerInfo'),
  //   margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //   color: Colors.white12,
  //   elevation: 5,
  //   shadowColor: Colors.black26,
  //   shape: RoundedRectangleBorder(
  //     side: BorderSide(color: _containerColor, width: 1.5),
  //     borderRadius: BorderRadius.circular(10),
  //   ),
  //   child: Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('Container Info',
  //             style: Theme.of(context).textTheme.headlineSmall),
  //         _dividerHeading(),

  //       ],
  //     ),
  //   ),
  // );
// }
