import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tswiri/ml_kit/barcode_scanner/barcode_scanner_view.dart';
import 'package:tswiri/utilities/containers/container_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:tswiri_database_interface/functions/general/capitalize_first_character.dart';
import 'package:tswiri_database_interface/functions/isar/create_functions.dart';
import 'package:tswiri_database_interface/models/settings/global_settings.dart';
import 'package:tswiri_database_interface/functions/embedded/get_icondata.dart';

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
  CatalogedBarcode? _selectedBarcode;

  //New Barcode size
  TextEditingController _newBarcodeSizeController = TextEditingController();

  //Parent
  CatalogedContainer? _parentContainer;

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
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _containerType(),
            const Divider(),
            _name(),
            // const Divider(),
            _description(),
            const Divider(),
            _barcode(),
            const Divider(),
            _parent(),
            const Divider(),
            _create(),
          ],
        ),
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
                getIconData(e.iconData.data!),
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
        return ListTile(
          leading: _selectedBarcode == null
              ? const Icon(Icons.question_mark_rounded)
              : const Icon(Icons.qr_code_2_rounded),
          title: const Text('Barcode'),
          subtitle: _selectedBarcode == null
              ? null
              : Text(_selectedBarcode!.barcodeUID.toString()),
          trailing: _selectedBarcode == null
              ? OutlinedButton(onPressed: action, child: const Text('Scan'))
              : OutlinedButton(onPressed: action, child: const Text('Change')),
          // onTap: action,
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
            _selectedBarcode = catalogedBarcode;
          });
        }
      },
    );
  }

  Widget _parent() {
    return OpenContainer<String>(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      closedBuilder: (context, action) {
        return ListTile(
          title: const Text('Parent'),
          leading: _parentContainer == null
              ? const Icon(Icons.question_mark_rounded)
              : const Icon(Icons.qr_code_2_rounded),
          subtitle: _parentContainer == null
              ? null
              : Text(_parentContainer!.name.toString()),
          trailing: _parentContainer == null
              ? OutlinedButton(onPressed: action, child: const Text('Scan'))
              : OutlinedButton(onPressed: action, child: const Text('Change')),
        );
      },
      openBuilder: (context, action) {
        return const BarcodeScannerView();
      },
      onClosed: (barcodeUID) async {
        if (barcodeUID == null) return;

        CatalogedContainer? parentContainer = isar!.catalogedContainers
            .filter()
            .barcodeUIDMatches(barcodeUID)
            .findFirstSync();

        if (parentContainer == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Barcode not linked',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        } else {
          setState(() {
            _parentContainer = parentContainer;
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

  OutlinedButton _create() {
    return OutlinedButton(
      onPressed: () {
        if (_selectedBarcode == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Please scan a Barcode',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        } else {
          _createContainer(_selectedBarcode!);
        }
      },
      child: const Text('Create'),
    );
  }

  void _createContainer(CatalogedBarcode barcode) {
    //Container UID.
    String containerUID =
        '${selectedContainerType.containerTypeName}_${DateTime.now().millisecondsSinceEpoch}';

    //Container Name.
    String name = _nameController.text;
    if (name.isEmpty) {
      List<CatalogedContainer> containers = isar!.catalogedContainers
          .filter()
          .containerTypeIDEqualTo(selectedContainerType.id)
          .findAllSync();

      name =
          '${selectedContainerType.containerTypeName.capitalizeFirstCharacter()} ${containers.length + 1}';
    }

    //Container Description.
    String? description = _descriptionController.text.isNotEmpty
        ? _descriptionController.text
        : null;

    CatalogedContainer newCatalogedContainer = createNewCatalogedContainer(
      containerUID: containerUID,
      barcodeUID: barcode.barcodeUID,
      containerTypeID: selectedContainerType.id,
      name: name,
      description: description,
    );

    //Create container Relationship
    if (_parentContainer != null && _parentContainer != null) {
      createContainerRelationship(
        parentContainerUID: _parentContainer!.containerUID,
        containerUID: containerUID,
      );
    }

    //Create Marker
    if (selectedContainerType.enclosing == false &&
        selectedContainerType.moveable == false) {
      Marker marker = Marker()
        ..barcodeUID = barcode.barcodeUID
        ..containerUID = containerUID;

      isar!.writeTxnSync(() => isar!.markers.putSync(marker));
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ContainerView(
          catalogedContainer: newCatalogedContainer,
        ),
      ),
    );
  }
}
