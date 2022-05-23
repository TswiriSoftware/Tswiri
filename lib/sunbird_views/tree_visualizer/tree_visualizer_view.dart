import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';
import 'package:flutter_google_ml_kit/sunbird_views/containers/container_manager/container_view.dart';
import 'package:isar/isar.dart';

class GridVisualizerView extends StatefulWidget {
  const GridVisualizerView({Key? key}) : super(key: key);

  @override
  State<GridVisualizerView> createState() => _GridVisualizerViewState();
}

class _GridVisualizerViewState extends State<GridVisualizerView> {
  MasterGrid masterGrid = MasterGrid(isarDatabase: isarDatabase!);
  late List<ContainerEntry> orphanContainers = masterGrid.orphanContainers();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _refresh(),
      appBar: _appBar(),
      body: _body(),
    );
  }

  ///APP BAR///

  AppBar _appBar() {
    return AppBar(
      backgroundColor: sunbirdOrange,
      elevation: 25,
      centerTitle: true,
      title: _title(),
      shadowColor: Colors.black54,
    );
  }

  Text _title() {
    return Text(
      'Tree Visualizer',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  ///BODY///
  Widget _body() {
    return ListView.builder(
      itemCount: orphanContainers.length,
      itemBuilder: (context, index) {
        return orphanContainer(orphanContainers[index]);
      },
    );
  }

  Widget orphanContainer(ContainerEntry containerEntry) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: sunbirdOrange, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                containerEntry.name ?? containerEntry.containerUID,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Builder(builder: (context) {
              return ExpansionTile(
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Text(
                  'Children',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                children: getChildren(containerEntry)
                    .map((e) => childBuilder(e))
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget childBuilder(ContainerEntry containerEntry) {
    return Builder(builder: (context) {
      List<ContainerEntry> children = getChildren(containerEntry);
      if (children.isNotEmpty) {
        return lowerContainer(containerEntry, children);
      } else {
        return lowerContainerEnd(containerEntry);
      }
    });
  }

  Widget lowerContainer(
      ContainerEntry containerEntry, List<ContainerEntry> children) {
    return Builder(builder: (context) {
      Color color =
          getContainerColor(containerUID: containerEntry.containerUID);
      List<ContainerEntry> children = getChildren(containerEntry);
      return Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white12,
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          title: Row(
            children: [
              Text(
                containerEntry.name ?? containerEntry.containerUID,
              ),
              edit(containerEntry),
            ],
          ),
          children: children.map((e) => childBuilder(e)).toList(),
        ),
      );
    });
  }

  Widget lowerContainerEnd(ContainerEntry containerEntry) {
    return Builder(builder: (context) {
      Color color =
          getContainerColor(containerUID: containerEntry.containerUID);
      return Card(
        margin: const EdgeInsets.all(8),
        color: Colors.white12,
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  containerEntry.name ?? containerEntry.containerUID,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                edit(containerEntry),
              ],
            )),
      );
    });
  }

  ///EDIT///
  Widget edit(ContainerEntry containerEntry) {
    return IconButton(
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
      icon: const Icon(Icons.edit),
    );
  }

  ///ACTIONS///
  Widget _refresh() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.refresh),
    );
  }

  List<ContainerEntry> getChildren(ContainerEntry parent) {
    List<ContainerRelationship> relationships = isarDatabase!
        .containerRelationships
        .filter()
        .parentUIDMatches(parent.containerUID)
        .findAllSync();

    if (relationships.isNotEmpty) {
      return isarDatabase!.containerEntrys
          .filter()
          .repeat(
              relationships,
              (q, ContainerRelationship element) =>
                  q.containerUIDMatches(element.containerUID))
          .findAllSync();
    }
    return [];
  }
}
