import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/conatiner_type_adapter.dart';
import 'package:flutter_google_ml_kit/isar/container_isar.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/scan_barcode_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/all_containers_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/container_children_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/container_selector_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_description_widget.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_name_widget.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_parent_widget.dart';
import 'package:flutter_google_ml_kit/widgets/custom_container.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../widgets/light_container.dart';
import 'functions/isar_functions.dart';

class NewContainerView extends StatefulWidget {
  const NewContainerView({
    Key? key,
    this.containerType,
    this.parentUID,
  }) : super(key: key);

  ///Pass a containerType if you can.
  final ContainerType? containerType;

  ///Pass a parentUID if you can.
  final String? parentUID;

  @override
  State<NewContainerView> createState() => _NewContainerViewState();
}

class _NewContainerViewState extends State<NewContainerView> {
  String? title;
  String? parentUID;
  List<String>? children;
  ContainerType? containerType;
  String? barcodeUID;
  Isar? database;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    containerType = widget.containerType;
    parentUID = widget.parentUID;
    if (containerType != null) {
      title = containerType.toString().split('.').last;
    }

    super.initState();
  }

  @override
  void dispose() {
    if (database != null) {
      if (database!.isOpen) {
        database!.close();
        database = null;
      }
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
              ContainerNameWidget(
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
              ContainerDescriptionWidget(
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

              selectContainerType(),
              linkBarcode(),
              //addChildren(), //TODO: Implement adding children.
              ContainerParentWidget(
                parentContainerUID: parentUID,
                child: ElevatedButton(
                  onPressed: () async {
                    parentUID = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContainerSelectorView(
                          multipleSelect: false,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                  child: const Text('select'),
                ),
              ),

              createContainer()
            ],
          ),
        ),
      ),
    );
  }

  ///Add children.
  LightContainer addChildren() {
    return LightContainer(
      child: CustomOutlineContainer(
        outlineColor: Colors.deepOrange,
        padding: 0,
        margin: 0,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add children: ',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium, //TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (database != null) {
                    if (database!.isOpen) {
                      await database!.close();
                      database = null;
                    }
                  }
                  parentUID = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContainerChildrenView(),
                    ),
                  );
                },
                child:
                    Text('add', style: Theme.of(context).textTheme.bodyMedium),
              ),
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
                    '${title}_${DateTime.now().millisecondsSinceEpoch}';

                String name;
                if (nameController.text.isNotEmpty) {
                  name = nameController.text;
                } else {
                  name = containerUID;
                }

                final newContainer = ContainerEntry()
                  ..containerUID = containerUID
                  ..containerType = containerType!
                  ..name = name
                  ..description = descriptionController.text
                  ..barcodeUID = null;

                database ??= await openIsar();

                database!.writeTxnSync((isar) {
                  isar.containerIsars.putSync(newContainer);
                });

                log(newContainer.toString());

                database = closeIsar(database);

                //await database.close();

                // ContainerEntry containerEntry = ContainerEntry(
                //   containerUID: containerUID,
                //   parentUID: parentUID,
                //   name: name,
                //   description: descriptionController.text,
                //   barcodeUID: null,
                //   containerType: containerType,
                // );

                // containersBox.put(containerEntry.containerUID, containerEntry);

                // if (parentUID != null && parentUID!.isNotEmpty) {
                //   ContainerEntry? parentContainer =
                //       containersBox.get(parentUID);

                //   if (parentContainer != null) {
                //     List<String> children = parentContainer.children ?? [];
                //     children.add(containerEntry.containerUID);
                //     parentContainer.children = children;

                //     containersBox.put(parentUID, parentContainer);
                //   }
                // }

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

  ///Link a barcode to current container.
  LightContainer linkBarcode() {
    return LightContainer(
      child: Builder(builder: (context) {
        Color outlineColor = Colors.grey;
        if (barcodeUID != null) {
          outlineColor = Colors.blue;
        }

        return CustomOutlineContainer(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(builder: (context) {
                  if (barcodeUID == null) {
                    return Text('barcodeUID', style: TextStyle(fontSize: 18));
                  } else {
                    return Text(barcodeUID!, style: TextStyle(fontSize: 18));
                  }
                }),
                ElevatedButton(
                  onPressed: () async {
                    String? scannedBarcodeUID = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScanBarcodeView(),
                      ),
                    );
                    setState(() {
                      if (scannedBarcodeUID != null) {
                        barcodeUID = scannedBarcodeUID;
                      }
                    });
                  },
                  child: const Text('scan'),
                ),
              ],
            ),
          ),
          outlineColor: outlineColor,
          margin: 0,
          padding: 0,
        );
      }),
    );
  }

  ///Select container type.
  LightContainer selectContainerType() {
    return LightContainer(
      margin: 5,
      padding: 5,
      child: Builder(builder: (context) {
        Color outlineColor = Colors.grey;
        if (containerType != null) {
          outlineColor = Colors.blue;
        }
        return CustomOutlineContainer(
          outlineColor: outlineColor,
          margin: 0,
          padding: 0,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Container type:',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton<ContainerType>(
                      value: containerType,
                      items: ContainerType.values
                          .map((ContainerType containerType) =>
                              DropdownMenuItem<ContainerType>(
                                  value: containerType,
                                  child: Text(containerType
                                      .toString()
                                      .split('.')
                                      .last)))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          containerType = newValue;
                          title = containerType.toString().split('.').last;
                        });
                      },
                    )
                  ],
                ),
                Builder(
                  builder: (context) {
                    if (containerType == ContainerType.custom) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Custom Setup',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Whatever is needed ?',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
