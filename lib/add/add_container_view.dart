import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tswiri/ml_kit/barcode_scanner/barcode_scanner_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/models/settings/global_settings.dart';

class AddContainerView extends StatefulWidget {
  const AddContainerView({
    Key? key,
    this.containerType,
  }) : super(key: key);
  final ContainerType? containerType;

  @override
  State<AddContainerView> createState() => AddContainerViewState();
}

class AddContainerViewState extends State<AddContainerView> {
  //Container Types
  final List<ContainerType> _containerTypes =
      isar!.containerTypes.where().findAllSync();

  //Selected Container Type.
  late ContainerType selectedContainerType =
      widget.containerType ?? _containerTypes.first;

  //Name Text Field.
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();

  //Description Text Field.
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionNode = FocusNode();

  //Selected/Scanned barcode.
  CatalogedBarcode? selectedBarcode;

  //New Barcode size
  TextEditingController _newBarcodeSizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _newBarcodeSizeController.text = defaultBarcodeSize.toString();
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
      elevation: 10,
      title: Text('New ${selectedContainerType.containerTypeName}'),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _containerType(),
          // const Divider(),
          _name(),
          // const Divider(),
          _description(),
          // const Divider(),
          _barcode(),
        ],
      ),
    );
  }

  Widget _name() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Name',
          // labelStyle: TextStyle(fontSize: 15, color: Colors.white),
          border: OutlineInputBorder(borderSide: BorderSide()),
          // focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Description',
          // labelStyle: TextStyle(fontSize: 15, color: Colors.white),
          border: OutlineInputBorder(borderSide: BorderSide()),
          // focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
        ),
      ),
    );
  }

  Widget _containerType() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 4,
        children: [
          for (var e in _containerTypes)
            FilterChip(
              avatar: Icon(
                e.iconData.iconData,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              label: Text(e.containerTypeName),
              onSelected: (value) => setState(() {
                selectedContainerType = e;
              }),
              selected: selectedContainerType == e,
              tooltip: e.containerDescription,
            ),
        ],
      ),
    );
  }

  Widget _barcode() {
    return OpenContainer<String>(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      closedBuilder: (context, action) {
        return Card(
          elevation: 10,
          child: ListTile(
            leading: selectedBarcode == null
                ? const Icon(Icons.question_mark_rounded)
                : const Icon(Icons.qr_code_2_rounded),
            title: const Text('Barcode'),
            subtitle: selectedBarcode == null
                ? null
                : Text(selectedBarcode!.barcodeUID.toString()),
            trailing: selectedBarcode == null
                ? const Icon(Icons.add_rounded)
                : const Icon(Icons.change_circle_rounded),
            onTap: action,
          ),
        );
      },
      openBuilder: (context, aciton) {
        return const BarcodeScannerView();
      },
      onClosed: (barcodeUID) async {
        if (barcodeUID == null) return;

        //1. Check if this barcode exists.
        CatalogedBarcode? catalogedBarcode = isar!.catalogedBarcodes
            .filter()
            .barcodeUIDMatches(barcodeUID)
            .findFirstSync();

        if (catalogedBarcode == null) {
          //Request that the user add this barcode.
          await _addNewBarcode(context, barcodeUID);
        } else {
          //Set selected barcode.
          setState(() {
            selectedBarcode = catalogedBarcode;
          });
        }
      },
    );
  }

  Future<CatalogedBarcode?> _addNewBarcode(
      BuildContext context, String barcodeUID) {
    return showDialog<CatalogedBarcode?>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unknown Barcode'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'This is a unknown barcode please import it first.',
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Okay'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
