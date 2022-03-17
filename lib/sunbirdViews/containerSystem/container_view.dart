import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar/container_relationship.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/new_container_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_children_widget.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_description_widget.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_name_widget.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_parent_widget.dart';
import 'package:isar/isar.dart';
import '../../isar/container_isar.dart';
import '../../widgets/orange_container.dart';
import 'container_selector_view.dart';
import 'functions/isar_functions.dart';

class ContainerView extends StatefulWidget {
  const ContainerView({Key? key, required this.containerUID, this.database})
      : super(key: key);
  final String containerUID;
  final Isar? database;
  @override
  State<ContainerView> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerView> {
  String? title;
  String? parentContainerUID;
  List<String>? children;
  //ContainerType? containerType;
  String? barcodeUID;
  Isar? database;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    database = widget.database;
    database ??= openIsar();
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
    return GestureDetector(
      onTap: (() => hideKeyboard(context)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            widget.containerUID.toString().split('_').first,
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
        body: FutureBuilder<ContainerEntry?>(
          future: getContainerEntry(),
          builder: ((context, snapshot) {
            if (nameController.text.isEmpty) {
              nameController.text = snapshot.data?.name ?? '';
            }
            if (descriptionController.text.isEmpty) {
              descriptionController.text = snapshot.data?.description ?? '';
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ///Container Name.
                    ContainerNameWidget(
                      nameController: nameController,
                      onChanged: (value) async {
                        setState(() {});
                        //Update name.
                        database!.writeTxnSync((isar) {
                          ContainerEntry containerEntry = snapshot.data!;
                          containerEntry.name = nameController.text;
                          isar.containerEntrys.putSync(containerEntry);
                        });
                      },
                    ),

                    ///Container Description.
                    ContainerDescriptionWidget(
                      descriptionController: descriptionController,
                      onChanged: (value) async {
                        setState(() {});
                        //Update description.
                        database!.writeTxnSync((isar) {
                          ContainerEntry containerEntry = snapshot.data!;
                          containerEntry.description =
                              descriptionController.text;
                          isar.containerEntrys.putSync(containerEntry);
                        });
                      },
                    ),

                    ///Container Parent
                    Builder(builder: (context) {
                      //Hide parent container if creating an area.
                      if (snapshot.data!.containerType == 'area') {
                        return Container();
                      }

                      String? parentContainerUID = database!
                          .containerRelationships
                          .filter()
                          .containerUIDMatches(snapshot.data!.containerUID)
                          .findFirstSync()
                          ?.parentUID;

                      String? parentContainerName;

                      if (parentContainerUID != null) {
                        parentContainerName = database!.containerEntrys
                            .filter()
                            .containerUIDMatches(parentContainerUID)
                            .findFirstSync()
                            ?.name;
                      }

                      return ContainerParentWidget(
                        parentContainerUID: parentContainerUID,
                        parentContainerName: parentContainerName,
                        button: InkWell(
                          onTap: () async {
                            parentContainerUID = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContainerSelectorView(
                                  currentContainerUID: widget.containerUID,
                                  database: database,
                                  multipleSelect: false,
                                ),
                              ),
                            );
                            setState(() {});

                            ContainerRelationship? containerRelationship =
                                database!
                                    .containerRelationships
                                    .filter()
                                    .containerUIDMatches(
                                        snapshot.data!.containerUID)
                                    .findFirstSync();

                            containerRelationship ??= ContainerRelationship()
                              ..containerUID = widget.containerUID
                              ..parentUID = parentContainerUID;

                            if (parentContainerUID != null) {
                              containerRelationship.parentUID =
                                  parentContainerUID;
                              database!.writeTxnSync((isar) => isar
                                  .containerRelationships
                                  .putSync(containerRelationship!,
                                      replaceOnConflict: true));
                            }
                          },
                          child: const OrangeOutlineContainer(
                            padding: 8,
                            child: Text('select'),
                          ),
                        ),
                      );
                    }),

                    ///Container Children
                    ContainerChildrenWidget(
                      showButton: true,
                      height: 200,
                      currentContainerUID: widget.containerUID,
                      database: database!,
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }

  Future<ContainerEntry?> getContainerEntry() async {
    ContainerEntry? containerEntry = database!.containerEntrys
        .filter()
        .containerUIDMatches(widget.containerUID)
        .findFirstSync();
    return containerEntry;
  }
}
