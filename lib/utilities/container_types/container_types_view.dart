import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:tswiri_database_interface/functions/general/capitalize_first_character.dart';

import 'container_type_editor_view.dart';

class ContainerTypesView extends StatefulWidget {
  const ContainerTypesView({Key? key}) : super(key: key);

  @override
  State<ContainerTypesView> createState() => ContainerTypesViewState();
}

class ContainerTypesViewState extends State<ContainerTypesView> {
  late List<ContainerType> _containerTypes =
      isar!.containerTypes.where().findAllSync();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          _sliverList(),
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      expandedHeight: 0,
      flexibleSpace: AppBar(
        title: const Text(
          'Container Types',
        ),
        centerTitle: true,
        elevation: 5,
      ),
      actions: const [],
    );
  }

  SliverPadding _sliverList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          for (ContainerType containerType in _containerTypes)
            _containerType(containerType)
        ]),
      ),
    );
  }

  Widget _containerType(ContainerType containerType) {
    return OpenContainer(
      openShape: const RoundedRectangleBorder(),
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      closedBuilder: (context, action) {
        return Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                containerType.containerTypeName.capitalizeFirstCharacter(),
              ),
              trailing: Icon(containerType.iconData.iconData),
              onTap: action,
            ),
          ),
        );
      },
      openBuilder: (context, _) {
        return ContainerTypeEditorView(
          containerType: containerType,
        );
      },
      onClosed: (_) {
        setState(() {
          _containerTypes = isar!.containerTypes.where().findAllSync();
        });
      },
    );
  }
}
