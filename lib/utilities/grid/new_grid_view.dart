import 'package:flutter/material.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';

class NewGridView extends StatefulWidget {
  const NewGridView({Key? key, this.originBarcodeUID}) : super(key: key);
  final String? originBarcodeUID;
  @override
  State<NewGridView> createState() => NewGridViewState();
}

class NewGridViewState extends State<NewGridView> {
  late int numOfGrids = getCatalogedGridsSync().length;
  //  isar!.catalogedGrids.where().findAllSync().length;
  late String? originBarcodeUID = widget.originBarcodeUID;
  String? parentBarcodeUID;

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
      title: Text('New Grid: ${numOfGrids + 1}'),
      centerTitle: true,
      elevation: 10,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}
