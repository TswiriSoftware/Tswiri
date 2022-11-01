import 'package:flutter/material.dart';
import 'package:tswiri_database/export.dart';

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
  late List<CatalogedContainer> _containers = isar!.catalogedContainers
      .filter()
      .containerTypeIDEqualTo(_containerType.id)
      .findAllSync();

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
      title: Text("${_containerType.containerTypeName}'s"),
      centerTitle: true,
      elevation: 10,
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: _containers.length,
      itemBuilder: (context, index) {
        CatalogedContainer container = _containers[index];
        List<ContainerRelationship> children = isar!.containerRelationships
            .filter()
            .parentUIDMatches(container.containerUID)
            .findAllSync();

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
            leading: Icon(_containerType.iconData.iconData),
            trailing: Text(children.length.toString()),
          ),
        );
      },
    );
  }

  void updateContainers() {
    setState(() {
      _containers = isar!.catalogedContainers
          .filter()
          .containerTypeIDEqualTo(_containerType.id)
          .findAllSync();
    });
  }
}
