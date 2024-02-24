import 'package:flutter/material.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class ContainerScreen extends ConsumerStatefulWidget {
  final CatalogedContainer _container;

  const ContainerScreen({
    required CatalogedContainer container,
    super.key,
  }) : _container = container;

  @override
  AbstractScreen<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends AbstractScreen<ContainerScreen> {
  String get _containerName => widget._container.name.toString();
  late ContainerType? _type;
  late ContainerRelationship? _relationship;

  @override
  void initState() {
    super.initState();
    _type = dbUtils.getContainerType(widget._container.typeUUID);

    _relationship = dbUtils.getParentRelationShip(
      widget._container.containerUUID,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_type?.name.toString() ?? "error"),
      ),
      body: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: _containerName),
                  readOnly: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: _containerName),
                  readOnly: true,
                ),
              ),
              ListTile(
                title: const Text('Name'),
                subtitle: Text(_containerName.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
