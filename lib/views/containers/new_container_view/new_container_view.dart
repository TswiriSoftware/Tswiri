import 'package:flutter/material.dart';
import 'package:sunbird/extentions/string_extentions.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/containers/container_view/container_view.dart';

import '../barcode_scanner/single_scanner_view.dart';

class NewContainerView extends StatefulWidget {
  ///This view is used to create new containers.
  const NewContainerView({
    Key? key,
    this.parentContainerUID,
    this.preferredContainerType,
  }) : super(key: key);

  final CatalogedContainer? parentContainerUID;
  final ContainerType? preferredContainerType;

  @override
  State<NewContainerView> createState() => _NewContainerViewState();
}

class _NewContainerViewState extends State<NewContainerView> {
  //Name Text Field.
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();

  //Description Text Field.
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionNode = FocusNode();

  //Container Types.
  late List<ContainerType> containerTypes =
      isar!.containerTypes.where().findAllSync();

  late ContainerType selectedContainerType =
      widget.preferredContainerType ?? containerTypes[0];

  late Color selectedContainerColor = selectedContainerType.containerColor;

  //BarcodeUID.
  String? barcodeUID;

  //Parent Container.
  late CatalogedContainer? parentContainer = widget.parentContainerUID;

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
          'New ${selectedContainerType.containerTypeName.capitalizeFirstCharacter()}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true);
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _containerType(),
          _name(),
          _description(),
          _barcode(),
          _parent(),
          _createButton(),
        ],
      ),
    );
  }

  Widget _containerType() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Wrap(
              spacing: 4,
              children: [
                for (ContainerType e in containerTypes)
                  ChoiceChip(
                    label: Text(
                      e.containerTypeName.capitalizeFirstCharacter(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    avatar: Icon(
                      e.iconData,
                      size: 15,
                    ),
                    selectedColor:
                        colorModeEnabled ? selectedContainerColor : null,
                    selected: selectedContainerType.id == e.id,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: colorModeEnabled
                            ? selectedContainerColor
                            : sunbirdOrange,
                        width: 0.5,
                      ),
                    ),
                    onSelected: (value) {
                      setState(() {
                        selectedContainerType = e;
                        selectedContainerColor = e.containerColor;
                      });
                    },
                    tooltip: e.containerDescription,
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '(hold for more info)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
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
        focusNode: _nameNode,
        onSubmitted: (value) {
          _descriptionNode.requestFocus();
        },
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Name',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: sunbirdOrange)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: sunbirdOrange)),
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _descriptionController,
        focusNode: _descriptionNode,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Description',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: sunbirdOrange)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: sunbirdOrange)),
        ),
      ),
    );
  }

  Widget _barcode() {
    return Card(
      shape: RoundedRectangleBorder(
        side: barcodeUID == null
            ? BorderSide(
                color:
                    colorModeEnabled ? selectedContainerColor : sunbirdOrange,
                width: 1,
              )
            : const BorderSide(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Barcode UID: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                barcodeUID == null
                    ? Text(
                        '(Required)',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    barcodeUID ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          colorModeEnabled ? selectedContainerColor : null,
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      String? scannedBarcodeUID = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SingleBarcodeScannerView(),
                        ),
                      );
                      if (scannedBarcodeUID != null) {
                        CatalogedContainer? catalogedContainer = isar!
                            .catalogedContainers
                            .filter()
                            .barcodeUIDMatches(scannedBarcodeUID)
                            .findFirstSync();

                        if (catalogedContainer != null && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Barcode in use',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            barcodeUID = scannedBarcodeUID;
                          });
                        }
                      }
                    },
                    child: Text(
                      'Scan',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _parent() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Parent: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      parentContainer == null
                          ? const SizedBox.shrink()
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  parentContainer = null;
                                });
                              },
                              icon: const Icon(Icons.cancel_outlined),
                            ),
                      Text(
                        parentContainer?.name ??
                            parentContainer?.containerUID ??
                            '-',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          colorModeEnabled ? selectedContainerColor : null,
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      String? scannedBarcodeUID = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SingleBarcodeScannerView(),
                        ),
                      );
                      if (scannedBarcodeUID != null) {
                        CatalogedContainer? catalogedContainer = isar!
                            .catalogedContainers
                            .filter()
                            .barcodeUIDMatches(scannedBarcodeUID)
                            .findFirstSync();

                        if (catalogedContainer != null && mounted) {
                          setState(() {
                            parentContainer = catalogedContainer;
                          });
                        } else {
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
                        }
                      }
                    },
                    child: Text(
                      'Scan',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createButton() {
    return ActionChip(
      label: const Text(
        'Create',
      ),
      labelStyle: Theme.of(context).textTheme.titleMedium,
      labelPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      backgroundColor: barcodeUID == null
          ? background[400]
          : colorModeEnabled
              ? selectedContainerColor
              : null,
      shape: StadiumBorder(
        side: BorderSide(
          color: colorModeEnabled ? selectedContainerColor : sunbirdOrange,
        ),
      ),
      onPressed: () async {
        if (barcodeUID != null) {
          _createContainer(barcodeUID!);
        } else {
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
        }
      },
    );
  }

  void _createContainer(String barcodeUID) {
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
      barcodeUID: barcodeUID,
      containerTypeID: selectedContainerType.id,
      name: name,
      description: description,
    );

    //Create container Relationship
    if (parentContainer != null && parentContainer != null) {
      createContainerRelationship(
        parentContainerUID: parentContainer!.containerUID,
        containerUID: containerUID,
      );
    }

    //Create Marker
    if (selectedContainerType.enclosing == false &&
        selectedContainerType.moveable == false) {
      Marker marker = Marker()
        ..barcodeUID = barcodeUID
        ..containerUID = containerUID;

      isar!.writeTxnSync((isar) => isar.markers.putSync(marker));
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ContainerView(
          catalogedContainer: newCatalogedContainer,
          tagsExpanded: true,
          photosExpaned: true,
        ),
      ),
    );
  }
}
