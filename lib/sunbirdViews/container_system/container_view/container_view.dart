import 'package:flutter/material.dart';

import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/existing_container_widgets/container_children_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/existing_container_widgets/container_description_widget.dart';

import 'package:flutter_google_ml_kit/widgets/container_widgets/existing_container_widgets/container_name_widget.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/container_parent_widget.dart';
import 'package:isar/isar.dart';
import '../../../functions/barcodeTools/hide_keyboard.dart';
import '../../../isar/container_isar/container_isar.dart';

import '../../barcode_scanning/barcode_value_scanning/single_barcode_scan_view_old.dart';
import '../../../isar/functions/isar_functions.dart';

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

                    //Container Parent.
                    Builder(builder: (context) {
                      //TODO: implent check database instead of hardcoded.

                      //If it is an area.
                      if (snapshot.data!.containerType == 'area') {
                        return Container();
                      }
                      return ContainerParentWidget(
                        database: database!,
                        isNewContainer: false,
                        currentBarcodeUID: widget.containerUID,
                      );
                    }),

                    //BarcodeUID
                    BarcodeUIDwidget(
                      database: database!,
                      containerUID: widget.containerUID,
                    ),

                    ///Container Children
                    ContainerChildrenWidget(
                      showButton: true,
                      currentContainerName: snapshot.data!.name,
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

class BarcodeUIDwidget extends StatefulWidget {
  const BarcodeUIDwidget({
    Key? key,
    required this.database,
    required this.containerUID,
  }) : super(key: key);
  final Isar database;
  final String containerUID;

  @override
  State<BarcodeUIDwidget> createState() => _BarcodeUIDwidgetState();
}

class _BarcodeUIDwidgetState extends State<BarcodeUIDwidget> {
  String? barcodeUID;
  ContainerEntry? containerEntry;

  @override
  void initState() {
    containerEntry = widget.database.containerEntrys
        .filter()
        .containerUIDMatches(widget.containerUID)
        .findFirstSync();

    barcodeUID = containerEntry?.barcodeUID;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LightDarkContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('barcodeUID', style: Theme.of(context).textTheme.bodySmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(barcodeUID ?? 'Scan Barcode',
                style: Theme.of(context).textTheme.bodyLarge),
            InkWell(
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
                    containerEntry?.barcodeUID = barcodeUID;
                    widget.database.writeTxnSync((isar) {
                      isar.containerEntrys.putSync(containerEntry!);
                    });
                  }
                });
              },
              child: OrangeOutlineContainer(
                child: Text(
                  'Scan',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
