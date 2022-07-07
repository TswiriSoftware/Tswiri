import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';

// ignore: must_be_immutable
class GridDisplayView extends StatefulWidget {
  GridDisplayView({Key? key, required this.containerEntry}) : super(key: key);
  ContainerEntry containerEntry;

  @override
  State<GridDisplayView> createState() => _GridDisplayViewState();
}

class _GridDisplayViewState extends State<GridDisplayView> {
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
        'Grid: ${widget.containerEntry.name}',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Column();
  }
}
