import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/container_selector_view.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/container_children_widget.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

class ContainerChildrenView extends StatefulWidget {
  const ContainerChildrenView(
      {Key? key, this.currentContainerUID, required this.database})
      : super(key: key);
  final String? currentContainerUID;
  final Isar? database;

  @override
  State<ContainerChildrenView> createState() => _ContainerChildrenViewState();
}

class _ContainerChildrenViewState extends State<ContainerChildrenView> {
  Set<String>? children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Children',
          style: TextStyle(fontSize: 25),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContainerChildrenWidget(
                height: 500,
                currentContainerUID: widget.currentContainerUID!,
                database: widget.database!),

            ///Scan Children.
            LightContainer(
              child: CustomOutlineContainer(
                outlineColor: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Scan Children's Barcodes",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      InkWell(
                        onTap: () {},
                        child: const OrangeOutlineContainer(
                          width: 40,
                          height: 40,
                          padding: 0,
                          margin: 0,
                          child: Icon(
                            Icons.qr_code_2_rounded,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            ///Select Children.
            LightContainer(
              child: CustomOutlineContainer(
                outlineColor: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Children",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      InkWell(
                        onTap: () async {
                          children = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContainerSelectorView(
                                currentContainerUID: widget.currentContainerUID,
                                database: widget.database,
                                multipleSelect: true,
                              ),
                            ),
                          );
                        },
                        child: const OrangeOutlineContainer(
                          width: 40,
                          height: 40,
                          padding: 0,
                          margin: 0,
                          child: Icon(
                            Icons.select_all_rounded,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
