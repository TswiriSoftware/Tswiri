import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar/container_isar/container_isar.dart';

import 'package:flutter_google_ml_kit/widgets/container_widgets/container_card_widget%20.dart';

import 'package:isar/isar.dart';

import '../../sunbirdViews/containerSystem/container_children_view.dart';
import '../../sunbirdViews/containerSystem/container_view.dart';
import '../../sunbirdViews/containerSystem/functions/isar_functions.dart';
import '../basic_outline_containers/custom_outline_container.dart';
import '../basic_outline_containers/light_container.dart';
import '../basic_outline_containers/orange_outline_container.dart';

class ContainerChildrenWidget extends StatefulWidget {
  const ContainerChildrenWidget(
      {Key? key,
      required this.currentContainerUID,
      this.children,
      this.height,
      required this.database,
      this.showButton,
      this.currentContainerName})
      : super(key: key);

  final String currentContainerUID;
  final List<String>? children;
  final String? currentContainerName;
  final Isar database;
  final double? height;
  final bool? showButton;

  @override
  State<ContainerChildrenWidget> createState() =>
      _ContainerChildrenWidgetState();
}

class _ContainerChildrenWidgetState extends State<ContainerChildrenWidget> {
  List<String>? children;
  String? currentContainerName;

  double? height;
  bool? showButton;

  @override
  void initState() {
    children = widget.children;
    currentContainerName = widget.currentContainerName;
    height = widget.height;
    showButton = widget.showButton;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: Builder(builder: (context) {
        Color outlineColor = Colors.grey;
        if (widget.children != null) {
          outlineColor = Colors.blue;
        }
        return CustomOutlineContainer(
          outlineColor: outlineColor,
          padding: 0,
          margin: 0,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(
                  builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Children',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Builder(
                          builder: (context) {
                            if (widget.showButton != null &&
                                widget.showButton == true) {
                              return InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ContainerChildrenView(
                                        database: widget.database,
                                        currentContainerUID:
                                            widget.currentContainerUID,
                                        currentContainerName:
                                            currentContainerName,
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: OrangeOutlineContainer(
                                  child: Text('Edit Children',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: widget.height ?? 100,
                  child: Builder(builder: (context) {
                    //Find currentContainers children.
                    //TODO: Shorten this code XD

                    List<String>? children = getContainerChildren(
                        database: widget.database,
                        currentContainerUID: widget.currentContainerUID);

                    List<ContainerEntry> containerEntries = [];

                    for (String child in children ?? []) {
                      containerEntries.add(widget.database.containerEntrys
                          .filter()
                          .containerUIDMatches(child)
                          .findFirstSync()!);
                    }

                    List<Widget> containerChildren = containerEntries
                        .map(
                          (e) => InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                (MaterialPageRoute(
                                  builder: (context) => ContainerView(
                                    database: widget.database,
                                    containerUID: e.containerUID,
                                  ),
                                )),
                              );
                              setState(() {});
                            },
                            child: ContainerCardWidget(
                                containerEntry: e, database: widget.database),
                          ),
                        )
                        .toList();

                    //Return the widgets.
                    return ListView(
                      children: containerChildren,
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
