import 'package:flutter/material.dart';
import 'package:sunbird/isar/collections/container_relationship/container_relationship.dart';

class ChangeParentView extends StatefulWidget {
  const ChangeParentView({
    Key? key,
    required this.containerRelationship,
  }) : super(key: key);
  final ContainerRelationship containerRelationship;

  @override
  State<ChangeParentView> createState() => _ChangeParentViewState();
}

class _ChangeParentViewState extends State<ChangeParentView> {
  late final ContainerRelationship _containerRelationship =
      widget.containerRelationship;

  @override
  void initState() {
    super.initState();
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
      title: Text(
        'Parent',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Scan'),
        ),
      ],
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _parentContainerCard(),
        ],
      ),
    );
  }

  Widget _parentContainerCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_containerRelationship.parentUID!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
