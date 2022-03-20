import 'package:flutter_google_ml_kit/isar/container_relationship/container_relationship.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar/container_isar/container_isar.dart';
import 'package:flutter_google_ml_kit/isar/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcode_scanning/barcode_value_scanning/single_barcode_scan_view_old.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_description_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_name_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/container_parent_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_scan_barcode.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_type_widget.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';
import '../../../isar/functions/isar_functions.dart';

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
  String? title;
  String? parentUID;
  List<String>? children;
  String? containerType;
  String? barcodeUID;
  Isar? database;

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
              ContainerTypeWidget(
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
              ScanBarcodeWidget(
                barcodeUID: barcodeUID,
                button: InkWell(
                  onTap: () async {
                    String? scannedBarcodeUID = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingleBarcodeScanView(),
                      ),
                    );
                    setState(() {
                      if (scannedBarcodeUID != null) {
                        barcodeUID = scannedBarcodeUID;
                      }
                    });
                  },
                  child: const OrangeOutlineContainer(
                    padding: 8,
                    child: Text('scan'),
                  ),
                ),
              ),

              //ContainerParentUID
              ContainerParentWidget(
                database: database!,
                isNewContainer: true,
                updateParent: (value) {
                  //log(value.toString());
                  parentUID = value;
                },
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

                //Write to ContainerEntrys.
                final newContainer = ContainerEntry()
                  ..containerUID = containerUID
                  ..containerType = containerType!
                  ..name = name
                  ..description = descriptionController.text
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
