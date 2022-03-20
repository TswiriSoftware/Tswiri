import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcode_scanning/barcode_value_scanning/multiple_barcode_scan_view.dart';

import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_type_widget.dart';
import 'package:isar/isar.dart';
import '../../../isar/container_isar/container_isar.dart';
import '../../../isar/container_relationship/container_relationship.dart';
import '../../../isar/container_type/container_type.dart';
import '../../../widgets/container_widgets/container_parent_widget.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../widgets/container_widgets/new_container_widgets/new_container_name_widget.dart';

class ContainerBatchCreate extends StatefulWidget {
  const ContainerBatchCreate({
    Key? key,
    required this.database,
    this.parentContainerUID,
  }) : super(key: key);

  final Isar database;

  ///Pass this if you know what the parentContainerUID is.
  final String? parentContainerUID;

  @override
  State<ContainerBatchCreate> createState() => _ContainerBatchCreateState();
}

class _ContainerBatchCreateState extends State<ContainerBatchCreate> {
  String? containerType;
  String? parentContainerUID;
  int numberOfNewContainers = 5;
  final TextEditingController nameController = TextEditingController();
  String? containerName;
  int numberOfBarcodes = 0;
  Set<String?>? scannedBarcodeUIDs = {};
  bool includeScan = false;

  @override
  void initState() {
    parentContainerUID = widget.parentContainerUID;
    containerType = 'box';
    nameController.text = containerType!;
    containerName = containerType!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Batch Create',
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                //TODO: Batch create info.
              },
              icon: const Icon(Icons.info_outline_rounded))
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///ContainerParentWidget Select.
            ContainerParentWidget(
              isNewContainer: true,
              parentContainerUID: parentContainerUID,
              database: widget.database,
              updateParent: (value) {
                setState(() {
                  parentContainerUID = value;
                  log(parentContainerUID.toString());
                });
              },
            ),

            ///ContainerType Select.
            ContainerTypeWidget(
              builder: Builder(builder: (context) {
                List<ContainerType> containerTypes =
                    widget.database.containerTypes.where().findAllSync();

                return DropdownButton<String>(
                  value: containerType,
                  items: containerTypes
                      .map((containerType) => DropdownMenuItem<String>(
                          value: containerType.containerType,
                          child: Text(
                            containerType.containerType,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      containerType = newValue!;
                    });
                  },
                );
              }),
            ),

            //Containers name_increment
            NewContainerNameWidget(
              nameController: nameController,
              onChanged: (value) {
                setState(() {});
              },
              onFieldSubmitted: (value) {
                setState(() {
                  nameController.text = value.toString();
                  containerName = value;
                });
              },
              description: Text(
                "Container names will be assiged Name_number",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            //Scan Barcodes.
            Builder(builder: (context) {
              if (includeScan == false) {
                return LightDarkContainer(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Link Barcodes: ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Checkbox(
                      value: includeScan,
                      onChanged: (value) {
                        setState(
                          () {
                            includeScan = value!;
                          },
                        );
                      },
                    ),
                  ],
                ));
              }

              return LightDarkContainer(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Include Barcodes: '),
                        Checkbox(
                          value: includeScan,
                          onChanged: (value) {
                            setState(
                              () {
                                includeScan = value!;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Number: $numberOfBarcodes',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        InkWell(
                          onTap: (() async {
                            scannedBarcodeUIDs = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MultipleBarcodeScanView(),
                              ),
                            );
                            setState(() {
                              numberOfBarcodes =
                                  scannedBarcodeUIDs?.length ?? 0;
                            });
                            log(scannedBarcodeUIDs.toString());
                          }),
                          child: OrangeOutlineContainer(
                              child: Text(
                            'Scan',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }),

            //Number of new containers select.
            LightDarkContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Number of containers',
                      style: Theme.of(context).textTheme.bodyLarge),
                  OrangeOutlineContainer(
                    margin: 5,
                    child: NumberPicker(
                      haptics: true,
                      selectedTextStyle: TextStyle(
                          color: Colors.deepOrange[300], fontSize: 22),
                      itemHeight: 30,
                      itemWidth: 60,
                      minValue: 1,
                      maxValue: 100,
                      value: numberOfNewContainers,
                      onChanged: (value) {
                        setState(() {
                          numberOfNewContainers = value;
                          log(numberOfNewContainers.toString());
                        });
                      },
                    ),
                  )
                ],
              ),
            ),

            //Create Containers.
            LightDarkContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      if (includeScan == false) {
                        return InkWell(
                          onTap: () {
                            //Create without barcodes.
                            createContainersWithoutBarcodes();
                            Navigator.pop(context);
                          },
                          child: OrangeOutlineContainer(
                            child: Text(
                              'Create',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        );
                      } else if (includeScan == true &&
                          numberOfNewContainers == numberOfBarcodes) {
                        return InkWell(
                          onTap: () {
                            //Create with barcodes.
                            createContainersWithBarcodes();
                            Navigator.pop(context);
                          },
                          child: OrangeOutlineContainer(
                            child: Text(
                              'Create',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        );
                      }
                      return Text('number of containers != number of barcodes',
                          style: Theme.of(context).textTheme.bodyLarge);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createContainersWithBarcodes() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    for (var i = 0; i < numberOfBarcodes; i++) {
      String _containerUID = '${containerType!}_${timestamp + i}';
      String? _containerName;

      if (containerName!.isNotEmpty) {
        _containerName = '${containerName}_${i + 1}';
      }

      final newContainer = ContainerEntry()
        ..containerUID = _containerUID
        ..containerType = containerType!
        ..name = _containerName ?? _containerUID
        ..description = null
        ..barcodeUID = scannedBarcodeUIDs!.elementAt(i);

      widget.database.writeTxnSync((isar) {
        isar.containerEntrys.putSync(newContainer);
      });

      if (parentContainerUID != null) {
        final newContainerRelationship = ContainerRelationship()
          ..containerUID = _containerUID
          ..parentUID = parentContainerUID;

        widget.database.writeTxnSync((isar) {
          isar.containerRelationships.putSync(newContainerRelationship);
        });
      }

      log('containerNumber: ' + _containerUID);
      log('containerName: ' + _containerName.toString());
    }
  }

  void createContainersWithoutBarcodes() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    for (var i = 0; i < numberOfBarcodes; i++) {
      String _containerUID = '${containerType!}_${timestamp + i}';
      String? _containerName;

      if (containerName!.isNotEmpty) {
        _containerName = '${containerName}_${i + 1}';
      }

      final newContainer = ContainerEntry()
        ..containerUID = _containerUID
        ..containerType = containerType!
        ..name = _containerName ?? _containerUID
        ..description = null
        ..barcodeUID = null;

      widget.database.writeTxnSync((isar) {
        isar.containerEntrys.putSync(newContainer);
      });

      if (parentContainerUID != null) {
        final newContainerRelationship = ContainerRelationship()
          ..containerUID = _containerUID
          ..parentUID = parentContainerUID;

        widget.database.writeTxnSync((isar) {
          isar.containerRelationships.putSync(newContainerRelationship);
        });
      }

      log('containerNumber: ' + _containerUID);
      log('containerName: ' + _containerName.toString());
    }
  }
}
