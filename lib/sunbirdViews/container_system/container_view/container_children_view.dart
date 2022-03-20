import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/container_system/create_containers/container_batch_create_view.dart';

import 'package:flutter_google_ml_kit/widgets/container_widgets/existing_container_widgets/container_children_widget.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

import '../create_containers/container_single_create_view.dart';

class ContainerChildrenView extends StatefulWidget {
  const ContainerChildrenView({
    Key? key,
    this.currentContainerUID,
    required this.database,
    this.currentContainerName,
  }) : super(key: key);
  final String? currentContainerUID;
  final String? currentContainerName;
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
            LightContainer(
                margin: 2.5,
                padding: 2.5,
                child: CustomOutlineContainer(
                    margin: 2.5,
                    padding: 2.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Create: ',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        InkWell(
                          onTap: (() async {
                            await Navigator.push(
                              context,
                              (MaterialPageRoute(
                                builder: (context) => SingleContainerCreateView(
                                  containerType: 'box',
                                  parentUID: widget.currentContainerUID,
                                  parentName: widget.currentContainerName,
                                  database: widget.database!,
                                ),
                              )),
                            );
                            setState(() {});
                          }),
                          child: OrangeOutlineContainer(
                            child: Text('Child',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        InkWell(
                          onTap: (() async {
                            await Navigator.push(
                              context,
                              (MaterialPageRoute(
                                builder: (context) => BatchContainerCreateView(
                                  parentContainerUID:
                                      widget.currentContainerUID,
                                  database: widget.database!,
                                ),
                              )),
                            );
                            setState(() {});
                          }),
                          child: OrangeOutlineContainer(
                            child: Text('Children',
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        )
                      ],
                    ),
                    outlineColor: Colors.deepOrange)),

            ///Children widget
            ContainerChildrenWidget(
                height: 500,
                currentContainerUID: widget.currentContainerUID!,
                database: widget.database!),
          ],
        ),
      ),
    );
  }
}
