import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/containerAdapter/container_entry_adapter.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/new_container_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_children_widget.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_description_widget.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_name_widget.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/widgets/container_parent_widget.dart';
import 'package:flutter_google_ml_kit/widgets/orange_container.dart';
import 'package:hive/hive.dart';
import '../../databaseAdapters/containerAdapter/conatiner_type_adapter.dart';
import '../../globalValues/global_hive_databases.dart';
import 'container_selector_view.dart';
import 'functions/database_functions.dart';

class ContainerView extends StatefulWidget {
  const ContainerView({Key? key, required this.containerUID}) : super(key: key);
  final String containerUID;
  @override
  State<ContainerView> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerView> {
  String? title;
  String? parentContainerUID;
  List<String>? children;
  ContainerType? containerType;
  String? barcodeUID;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        body: FutureBuilder<ContainerEntryOLD>(
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
                        //Update container name.
                        await updateContainerName(
                            widget.containerUID, nameController.text);
                      },
                      onFieldSubmitted: (value) async {
                        setState(() {
                          nameController.text = value.toString();
                        });
                        if (nameController.text.isEmpty) {
                          nameController.text = widget.containerUID;
                        }
                        //Update container name.
                        await updateContainerName(
                            widget.containerUID, nameController.text);
                      },
                    ),

                    ///Container Description.
                    ContainerDescriptionWidget(
                      descriptionController: descriptionController,
                      onChanged: (value) async {
                        setState(() {});
                        //Update container description.
                        await updateContainerDescription(
                            widget.containerUID, descriptionController.text);
                      },
                      onFieldSubmitted: (value) async {
                        setState(() {
                          descriptionController.text = value.toString();
                        });
                        //Update container description.
                        await updateContainerDescription(
                            widget.containerUID, value.toString());
                      },
                    ),

                    ///Container Parent
                    ContainerParentWidget(
                      parentContainerUID: snapshot.data!.parentUID,
                      child: InkWell(
                        onTap: () async {
                          parentContainerUID = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContainerSelectorView(
                                multipleSelect: false,
                                currentContainerUID: widget.containerUID,
                              ),
                            ),
                          );
                          setState(() {});

                          updateContainerParent(
                              widget.containerUID, parentContainerUID);
                        },
                        child: OrangeOutlineContainer(
                          child: Text('select',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                    ),

                    ///Container Children
                    ContainerChildren(
                      currentContainerUID: widget.containerUID,
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

  Future<ContainerEntryOLD> getContainerEntry() async {
    Box<ContainerEntryOLD> containersBox =
        await Hive.openBox(containersBoxName);
    return containersBox.get(widget.containerUID)!;
  }
}
