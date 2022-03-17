import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar/container_relationship.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/new_container_view.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/container_children_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/container_description_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/new_container_widgets/new_container_description_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/container_name_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/container_parent_widget.dart';
import 'package:isar/isar.dart';
import '../../isar/container_isar.dart';
import '../../widgets/basic_outline_containers/orange_outline_container.dart';
import '../../widgets/container_widgets/new_container_widgets/new_container_parent_widget.dart';
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
  String? parentContainerName;
  List<String>? children;
  String? barcodeUID;
  Isar? database;

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
          title: Builder(builder: (context) {
            return Text(title ?? widget.containerUID);
          }),
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
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    //Container Name.
                    ContainerNameWidget(
                      containerUID: widget.containerUID,
                      database: database!,
                    ),

                    //Container Description.
                    ContainerDescriptionWidget(
                      containerUID: widget.containerUID,
                      database: database!,
                    ),

                    ContainerParentWidget(
                        currentContainerUID: widget.containerUID,
                        database: database!),

                    // ///Container Parent.
                    // Builder(builder: (context) {
                    //   //Hide parent container if creating an area.
                    //   if (snapshot.data!.containerType == 'area') {
                    //     return Container();
                    //   }

                    //   String? parentContainerUID = database!
                    //       .containerRelationships
                    //       .filter()
                    //       .containerUIDMatches(snapshot.data!.containerUID)
                    //       .findFirstSync()
                    //       ?.parentUID;

                    //   if (parentContainerUID != null) {
                    //     parentContainerName = database!.containerEntrys
                    //         .filter()
                    //         .containerUIDMatches(parentContainerUID)
                    //         .findFirstSync()
                    //         ?.name;
                    //   }

                    //   return NewContainerParentWidget(
                    //     parentContainerUID: parentContainerUID,
                    //     parentContainerName: parentContainerName,
                    // button: InkWell(
                    //   onTap: () async {
                    // List<String?>? parentContainerData =
                    //     await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ContainerSelectorView(
                    //       currentContainerUID: widget.containerUID,
                    //       database: database,
                    //       multipleSelect: false,
                    //     ),
                    //   ),
                    // );
                    // setState(() {
                    //   parentContainerUID = parentContainerData![0];
                    //   parentContainerName = parentContainerData[1];
                    // });

                    //         ContainerRelationship? containerRelationship =
                    //             database!
                    //                 .containerRelationships
                    //                 .filter()
                    //                 .containerUIDMatches(
                    //                     snapshot.data!.containerUID)
                    //                 .findFirstSync();

                    //         containerRelationship ??= ContainerRelationship()
                    //           ..containerUID = widget.containerUID
                    //           ..parentUID = parentContainerUID;

                    //         if (parentContainerUID != null) {
                    //           containerRelationship.parentUID =
                    //               parentContainerUID;
                    //           database!.writeTxnSync((isar) => isar
                    //               .containerRelationships
                    //               .putSync(containerRelationship!,
                    //                   replaceOnConflict: true));
                    //         }
                    //       },
                    // child: const OrangeOutlineContainer(
                    //   padding: 8,
                    //   child: Text('select'),
                    // ),
                    //     ),
                    //   );
                    // }),

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
    setState(() {
      title = containerEntry!.name ?? containerEntry.containerType;
    });
    return containerEntry;
  }
}
