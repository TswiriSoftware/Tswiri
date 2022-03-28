import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/single_barcode_scanner/single_barcode_scanner_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/widgets/container_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

class AddContainerView extends StatefulWidget {
  const AddContainerView({Key? key, this.barcodeUID}) : super(key: key);
  final String? barcodeUID;

  @override
  State<AddContainerView> createState() => _AddContainerViewState();
}

class _AddContainerViewState extends State<AddContainerView> {
  Color? containerColor;
  ContainerType? selectedContainerType;
  String? barcodeUID;
  ContainerEntry newContainerEntry = ContainerEntry();
  String? name;
  String? description;
  ContainerEntry? parentContainer;
  Marker? marker;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    barcodeUID = widget.barcodeUID;
    if (barcodeUID != null) {
      newContainerEntry.barcodeUID = barcodeUID;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Builder(builder: (context) {
          if (selectedContainerType == null) {
            return Text(
              'New Container',
              style: Theme.of(context).textTheme.titleMedium,
            );
          } else {
            return Text(
              'New ' + selectedContainerType!.containerType.capitalize(),
              style: Theme.of(context).textTheme.titleMedium,
            );
          }
        }),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //ContainerType
            Builder(
              builder: (context) {
                if (selectedContainerType == null) {
                  return containerTypePicker();
                } else {
                  return Column(
                    children: [
                      containerTypeDisplay(selectedContainerType!),
                      //BarcodeUID
                      Builder(builder: (context) {
                        if (barcodeUID != null) {
                          return Column(
                            children: [
                              scannedBarcode(),
                              _nameAndDescription(),
                              //ParentContaienr
                              Builder(builder: (context) {
                                if (selectedContainerType!.containerType ==
                                    'area') {
                                  return _createContainer();
                                } else {
                                  return Builder(builder: (context) {
                                    if (parentContainer == null) {
                                      return scanParent();
                                    } else {
                                      return Column(
                                        children: [
                                          _parentContainer(),
                                          _createContainer(),
                                        ],
                                      );
                                    }
                                  });
                                }
                              }),
                            ],
                          );
                        } else {
                          return scanBarcode();
                        }
                      }),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _parentContainer() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: DarkContainer(
        margin: 2.5,
        padding: 5,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Parent Container',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            containerDisplayWidget(parentContainer!),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                undoParentButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createContainer() {
    return InkWell(
      onTap: () {
        //Generate container name.
        String containerUID = selectedContainerType!.containerType +
            '_' +
            DateTime.now().millisecondsSinceEpoch.toString();

        //Generate Container from data..
        ContainerEntry containerEntry = ContainerEntry()
          ..containerType = selectedContainerType!.containerType
          ..barcodeUID = barcodeUID!
          ..containerUID = containerUID
          ..name = name
          ..description = description;

        isarDatabase!.writeTxnSync(
            (isar) => isar.containerEntrys.putSync(containerEntry));

        if (selectedContainerType!.canBeOrigin && marker != null) {
          marker!
            ..parentContainerUID = containerEntry.containerUID
            ..barcodeUID = barcodeUID!;
          isarDatabase!.writeTxnSync((isar) => isar.markers.putSync(marker!));
        }

        if (parentContainer != null) {
          //Create Relationship.
          ContainerRelationship containerRelationship = ContainerRelationship()
            ..containerUID = containerUID
            ..parentUID = parentContainer!.containerUID;
          isarDatabase!.writeTxnSync((isar) =>
              isar.containerRelationships.putSync(containerRelationship));
        }

        log(containerEntry.toString());
        Navigator.pop(context);
      },
      child: CustomOutlineContainer(
        outlineColor: containerColor!,
        margin: 5,
        width: 80,
        height: 30,
        child: Center(
            child: Text(
          'Create',
          style: Theme.of(context).textTheme.bodyLarge,
        )),
      ),
    );
  }

  Widget _nameAndDescription() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
        padding: 5,
        margin: 2.5,
        outlineColor: containerColor!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: TextField(
                controller: nameController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    name = value;
                    setState(() {});
                  } else {
                    name = null;
                    setState(() {});
                  }
                },
                style: const TextStyle(fontSize: 18),
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),
            ),
            _divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: TextField(
                controller: descriptionController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    description = value;
                    setState(() {});
                  } else {
                    description = null;
                    setState(() {});
                  }
                },
                style: const TextStyle(fontSize: 18),
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  labelText: 'Description',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget scannedBarcode() {
    return LightContainer(
      padding: 0,
      margin: 2.5,
      child: CustomOutlineContainer(
        padding: 5,
        outlineColor: containerColor!,
        margin: 2.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(builder: (context) {
              if (selectedContainerType!.canBeOrigin) {
                marker = Marker()..barcodeUID = barcodeUID!;

                return Text(
                  'Marker',
                  style: Theme.of(context).textTheme.labelMedium,
                );
              } else {
                return Container();
              }
            }),
            Row(
              children: [
                Text(
                  'BarcodeUID: ',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  newContainerEntry.barcodeUID!,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                undoBarcodeUIDButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget scanParent() {
    return Column(
      children: [
        LightContainer(
          margin: 2.5,
          padding: 0,
          child: DarkContainer(
            child: Center(
              child: Text('Please Scan Parent Barcode',
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            String? scannedBarcodeUID = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SingleBarcodeScannerView()),
            );
            if (scannedBarcodeUID != null) {
              parentContainer = isarDatabase!.containerEntrys
                  .filter()
                  .barcodeUIDMatches(scannedBarcodeUID)
                  .findFirstSync();

              setState(() {});
            }
          },
          child: CustomOutlineContainer(
            outlineColor: containerColor!,
            width: 80,
            height: 30,
            child: Center(
              child: Text(
                'scan',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget scanBarcode() {
    return Column(
      children: [
        LightContainer(
          margin: 2.5,
          padding: 0,
          child: DarkContainer(
            child: Center(
              child: Text('Please scan container barcode',
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            String? scannedBarcodeUID = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SingleBarcodeScannerView()),
            );
            //TODO: implement check
            log(scannedBarcodeUID.toString());
            if (scannedBarcodeUID != null) {
              ContainerEntry? linkedContainer = isarDatabase!.containerEntrys
                  .filter()
                  .barcodeUIDMatches(scannedBarcodeUID)
                  .findFirstSync();
              if (linkedContainer == null) {
                barcodeUID = scannedBarcodeUID;
                newContainerEntry.barcodeUID = scannedBarcodeUID;
                setState(() {});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(alreadyLinked);
              }
            }
          },
          child: OrangeOutlineContainer(
            width: 80,
            height: 30,
            child: Center(
              child: Text(
                'scan',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget undoBarcodeUIDButton() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          newContainerEntry.barcodeUID = null;
          barcodeUID = null;
          setState(() {});
        },
        child: CustomOutlineContainer(
          outlineColor: containerColor!,
          width: 80,
          height: 30,
          child: Center(
            child: Text(
              'Change',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }

  Widget undoParentButton() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          parentContainer = null;
          setState(() {});
        },
        child: CustomOutlineContainer(
          outlineColor: containerColor!,
          width: 80,
          height: 30,
          child: Center(
            child: Text(
              'Change',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }

  Widget undoContainerTypeButton() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          selectedContainerType = null;
          setState(() {});
        },
        child: CustomOutlineContainer(
          outlineColor: containerColor!,
          width: 80,
          height: 30,
          child: Center(
            child: Text(
              'Change',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }

  Widget containerTypePicker() {
    return Column(
      children: [
        LightContainer(
          margin: 2.5,
          padding: 0,
          child: DarkContainer(
            child: Center(
              child: Text('Please select container type',
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
        ),
        Builder(builder: (context) {
          //Get all container types.
          List<ContainerType> containerTypes =
              isarDatabase!.containerTypes.where().findAllSync();

          return Column(
            children:
                containerTypes.map((e) => containerTypeDisplay(e)).toList(),
          );
        }),
      ],
    );
  }

  Widget containerTypeDisplay(ContainerType containerType) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            newContainerEntry.containerType = containerType.containerType;
            selectedContainerType = containerType;
            containerColor = Color(
              int.parse(containerType.containerColor),
            );
            setState(() {});
          },
          child: LightContainer(
            margin: 2.5,
            padding: 0,
            child: CustomOutlineContainer(
              padding: 5,
              margin: 2.5,
              outlineColor: Color(
                int.parse(containerType.containerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    containerType.containerType.capitalize(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Divider(),
                  Text(
                    'Can Contain: ' + containerType.canContain.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'Can be origin: ' + containerType.canBeOrigin.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Builder(builder: (context) {
                    if (selectedContainerType != null) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          undoContainerTypeButton(),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Divider(
      height: 10,
      thickness: .5,
      color: containerColor!,
    );
  }

  final alreadyLinked = const SnackBar(
    content: Text('This barcode is already linked'),
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
