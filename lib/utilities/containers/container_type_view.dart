import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tswiri/utilities/containers/container_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:tswiri_database_interface/functions/embedded/get_icon_data.dart';

class ContainerTypeView extends StatefulWidget {
  const ContainerTypeView({
    Key? key,
    required this.containerType,
  }) : super(key: key);
  final ContainerType containerType;

  @override
  State<ContainerTypeView> createState() => ContainerTypeViewState();
}

class ContainerTypeViewState extends State<ContainerTypeView> {
  late final ContainerType _containerType = widget.containerType;
  late List<CatalogedContainer> _containers =
      getCatalogedContainersSync(containerTypeID: _containerType.id);
  // isar!.catalogedContainers
  //     .filter()
  //     .containerTypeIDEqualTo(_containerType.id)
  //     .findAllSync();

  @override
  void initState() {
    super.initState();
    updateContainers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text("${_containerType.name}'s"),
      centerTitle: true,
      elevation: 10,
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: _containers.length,
      itemBuilder: (context, index) {
        CatalogedContainer container = _containers[index];
        List<ContainerRelationship> children =
            getContainerRelationshipsSync(parentUID: container.containerUID);
        // isar!.containerRelationships
        //     .filter()
        //     .parentUIDMatches(container.containerUID)
        //     .findAllSync();

        return OpenContainer(
          openColor: Colors.transparent,
          closedColor: Colors.transparent,
          closedBuilder: (context, action) {
            return Card(
              elevation: 5,
              child: ListTile(
                title: Text(container.name ?? container.containerUID),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      container.description ?? '-',
                    ),
                  ],
                ),
                leading: Icon(getIconData(_containerType.iconData)),
                trailing: Text(children.length.toString()),
              ),
            );
          },
          openBuilder: (context, action) {
            return ContainerView(catalogedContainer: container);
          },
        );
      },
    );
  }

  void updateContainers() {
    setState(
      () {
        _containers =
            getCatalogedContainersSync(containerTypeID: _containerType.id);
        // isar!.catalogedContainers
        //     .filter()
        //     .containerTypeIDEqualTo(_containerType.id)
        //     .findAllSync();
      },
    );
  }
}
