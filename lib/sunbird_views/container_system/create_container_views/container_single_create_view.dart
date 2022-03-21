import 'dart:developer';

import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container/container_isar.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/single_barcode_scanner/single_barcode_scanner_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_system/container_select_views/container_selector_view.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_description_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_name_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_parent_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_scan_barcode.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_type_widget.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';
import '../../../isar_database/functions/isar_functions.dart';

class SingleContainerCreateView extends StatefulWidget {
  const SingleContainerCreateView(
      {Key? key,
      this.database,
      this.containerType,
      this.parentUID,
      this.parentName})
      : super(key: key);

  ///Isar
  final Isar? database;

  ///Pass a containerType if you can.
  final String? containerType;

  ///Pass a parentUID if you can.
  final String? parentUID;
  final String? parentName;

  @override
  State<SingleContainerCreateView> createState() =>
      _SingleContainerCreateViewState();
}

class _SingleContainerCreateViewState extends State<SingleContainerCreateView> {
  Isar? database;
  String? title;
  String? parentUID;
  String? parentName;
  String? containerType;
  String? barcodeUID;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    //Open Isar
    database = widget.database;
    database ??= openIsar();

    containerType = widget.containerType ?? 'area';
    parentUID = widget.parentUID;

    super.initState();
  }

  @override
  void dispose() {
    if (widget.database == null) {
      database!.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "New ${title ?? 'Container'}",
          style: const TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                //showInfoDialog(context);
              },
              icon: const Icon(Icons.info_outline_rounded))
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          hideKeyboard(context);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Name
              NewContainerNameWidget(
                nameController: nameController,
                onChanged: (value) {
                  setState(() {});
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    nameController.text = value.toString();
                  });
                },
              ),

              //Description
              NewContainerDescriptionWidget(
                descriptionController: descriptionController,
                onChanged: (value) {
                  setState(() {});
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    descriptionController.text = value.toString();
                  });
                },
              ),

              //Type
              NewContainerTypeWidget(
                containerType: containerType,
                builder: Builder(builder: (context) {
                  List<ContainerType> containerTypes =
                      database!.containerTypes.where().findAllSync();

                  return DropdownButton<String>(
                    value: containerType,
                    items: containerTypes
                        .map((containerType) => DropdownMenuItem<String>(
                            value: containerType.containerType,
                            child: Text(containerType.containerType)))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        containerType = newValue!;
                        title = newValue;
                      });
                    },
                  );
                }),
              ),

              //BarcodeUID
              NewContainerScanBarcodeWidget(
                barcodeUID: barcodeUID,
                button: InkWell(
                  onTap: () async {
                    String? scannedBarcodeUID = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingleBarcodeScannerView(),
                      ),
                    );
                    log(scannedBarcodeUID.toString());
                    if (scannedBarcodeUID != null) {
                      barcodeUID = scannedBarcodeUID;
                    } else if (scannedBarcodeUID == null) {
                      barcodeUID = null;
                    }
                    setState(() {});
                  },
                  child: const OrangeOutlineContainer(
                    padding: 8,
                    child: Text('scan'),
                  ),
                ),
              ),

              //ParentUID
              NewContainerParentWidget(
                parentUID: parentUID,
                parentName: parentName,
                onTap: (() async {
                  ContainerEntry? selectedParentContainer =
                      await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContainerSelectorView(
                        database: widget.database,
                        multipleSelect: false,
                      ),
                    ),
                  );
                  if (selectedParentContainer != null) {
                    parentUID = selectedParentContainer.containerUID;
                    parentName = selectedParentContainer.name;
                    setState(() {});
                  } else {
                    parentUID = "'";
                    parentName = "'";
                    setState(() {});
                  }
                }),
              ),

              createContainer()
            ],
          ),
        ),
      ),
    );
  }

  ///Create the container.
  Row createContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Builder(builder: (context) {
          if (containerType != null) {
            return InkWell(
              child: const CustomOutlineContainer(
                child: Text('Create'),
                margin: 5,
                padding: 10,
                outlineColor: Colors.blue,
              ),
              onTap: () async {
                String containerUID =
                    '${containerType!}_${DateTime.now().millisecondsSinceEpoch}';

                String name;
                if (nameController.text.isNotEmpty) {
                  name = nameController.text;
                } else {
                  name = containerUID;
                }
                String? description;
                if (descriptionController.text.isNotEmpty) {
                  description = descriptionController.text;
                } else {
                  description = null;
                }

                //Write to ContainerEntrys.
                final newContainer = ContainerEntry()
                  ..containerUID = containerUID
                  ..containerType = containerType!
                  ..name = name
                  ..description = description
                  ..barcodeUID = null;

                final newContainerRelationship = ContainerRelationship()
                  ..containerUID = containerUID
                  ..parentUID = parentUID;

                database!.writeTxnSync((isar) {
                  isar.containerEntrys.putSync(newContainer);
                  isar.containerRelationships.putSync(newContainerRelationship);
                });

                Navigator.pop(context);
              },
            );
          }
          return const CustomOutlineContainer(
            child: Text('Create'),
            margin: 5,
            padding: 10,
            outlineColor: Colors.deepOrange,
          );
        }),
      ],
    );
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
