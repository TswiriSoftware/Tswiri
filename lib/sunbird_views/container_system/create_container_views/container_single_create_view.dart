import 'dart:developer';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
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
  const SingleContainerCreateView({Key? key, this.parentContainer})
      : super(key: key);

  final ContainerEntry? parentContainer;

  @override
  State<SingleContainerCreateView> createState() =>
      _SingleContainerCreateViewState();
}

class _SingleContainerCreateViewState extends State<SingleContainerCreateView> {
  String? title;
  String? containerType;
  String? barcodeUID;
  ContainerEntry? parentContainerEntry;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    parentContainerEntry = widget.parentContainer;
    log(parentContainerEntry.toString());

    super.initState();
  }

  @override
  void dispose() {
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
              _newContainerNameWidget(),

              //Description
              _newContainerDescriptionWidget(),

              //ParentUID
              _newContainerParentWidget(),

              //Type
              _newContainerTypeWidget(),

              //BarcodeUID
              _newContainerBarcodeScanWidget(),

              //Create container.s
              _createContainerButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _newContainerNameWidget() {
    return NewContainerNameWidget(
      nameController: nameController,
      onChanged: (value) {
        setState(() {});
      },
      onFieldSubmitted: (value) {
        setState(() {
          nameController.text = value.toString();
        });
      },
    );
  }

  Widget _newContainerDescriptionWidget() {
    return NewContainerDescriptionWidget(
      descriptionController: descriptionController,
      onChanged: (value) {
        setState(() {});
      },
      onFieldSubmitted: (value) {
        setState(() {
          descriptionController.text = value.toString();
        });
      },
    );
  }

  Widget _newContainerTypeWidget() {
    return NewContainerTypeWidget(
      containerType: containerType,
      builder: Builder(builder: (context) {
        //List of containerTypes.
        List<ContainerType> containerTypes = [];

        //Can contain logic.
        if (parentContainerEntry?.containerUID == null) {
          containerTypes = isarDatabase!.containerTypes
              .filter()
              .containerTypeMatches('area')
              .findAllSync();
        } else if (parentContainerEntry?.containerType != null) {
          //Get all the container Types that the parent container can container.
          List<String> canContain = isarDatabase!.containerTypes
              .filter()
              .containerTypeMatches(parentContainerEntry!.containerType)
              .findFirstSync()!
              .canContain;

          containerTypes = isarDatabase!.containerTypes
              .where()
              .repeat(
                  canContain,
                  (q, String element) =>
                      q.filter().containerTypeMatches(element))
              .findAllSync();

          if (!canContain.contains(containerType)) {
            containerType = containerTypes.first.containerType;
          }
        }

        return DropdownButton<String>(
          value: containerType ?? containerTypes.first.containerType,
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
    );
  }

  Widget _newContainerBarcodeScanWidget() {
    return NewContainerScanBarcodeWidget(
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
    );
  }

  Widget _newContainerParentWidget() {
    return Builder(
      builder: (context) {
        //If a container is an area it cannot have a parent.
        if (containerType == 'area') {
          return Container();
        } else {
          return NewContainerParentWidget(
            parentUID: parentContainerEntry?.containerUID,
            parentName: parentContainerEntry?.name,
            onTap: (() async {
              ContainerEntry? selectedParentContainer = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContainerSelectorView(
                    multipleSelect: false,
                  ),
                ),
              );
              if (selectedParentContainer != null) {
                parentContainerEntry = selectedParentContainer;
                setState(() {});
              } else {
                //parentUID = "'";
                //parentName = "'";
                parentContainerEntry = null;
                setState(() {});
              }
            }),
          );
        }
      },
    );
  }

  ///Create the container.
  Widget _createContainerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Builder(
          builder: (context) {
            if (containerType != null) {
              final containerTypeProperties = isarDatabase!.containerTypes
                  .filter()
                  .containerTypeMatches(containerType!)
                  .findFirstSync();

              if (containerTypeProperties!.canBeOrigin == false &&
                  parentContainerEntry != null) {
                return _createContainerWithParent();
              } else if (containerTypeProperties.canBeOrigin == true &&
                  barcodeUID != null &&
                  nameController.text.isNotEmpty) {
                return _createContainer();
              }
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget _createContainer() {
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

        isarDatabase!.writeTxnSync((isar) {
          isar.containerEntrys.putSync(newContainer);
        });

        if (parentContainerEntry?.containerUID != null) {
          final newContainerRelationship = ContainerRelationship()
            ..containerUID = containerUID
            ..parentUID = parentContainerEntry!.containerUID;
          isarDatabase!.writeTxnSync((isar) {
            isar.containerRelationships.putSync(newContainerRelationship);
          });
        }

        Navigator.pop(context);
      },
    );
  }

  Widget _createContainerWithParent() {
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
          ..parentUID = parentContainerEntry!.containerUID;

        isarDatabase!.writeTxnSync((isar) {
          isar.containerEntrys.putSync(newContainer);
          isar.containerRelationships.putSync(newContainerRelationship);
        });

        Navigator.pop(context);
      },
    );
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
