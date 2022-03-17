import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar/container_isar.dart';
import 'package:flutter_google_ml_kit/isar/container_relationship.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/container_card_widget%20.dart';

import 'package:isar/isar.dart';

import '../basic_outline_containers/custom_outline_container.dart';
import '../basic_outline_containers/light_container.dart';
import '../basic_outline_containers/orange_outline_container.dart';
import '../../sunbirdViews/containerSystem/container_children_view.dart';
import '../../sunbirdViews/containerSystem/container_view.dart';

class ContainerChildrenWidget extends StatelessWidget {
  const ContainerChildrenWidget(
      {Key? key,
      required this.currentContainerUID,
      this.children,
      this.height,
      required this.database,
      this.showButton})
      : super(key: key);
  final String currentContainerUID;
  final List<String>? children;
  final Isar database;
  final double? height;
  final bool? showButton;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: Builder(builder: (context) {
        Color outlineColor = Colors.grey;
        if (children != null) {
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
                            if (showButton != null && showButton == true) {
                              return InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ContainerChildrenView(
                                        database: database,
                                        currentContainerUID:
                                            currentContainerUID,
                                      ),
                                    ),
                                  );
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
                  height: height ?? 100,
                  child: Builder(builder: (context) {
                    //Find currentContainers children.
                    //TODO: Shorten this code XD

                    Set<String> children = database.containerRelationships
                        .filter()
                        .parentUIDMatches(currentContainerUID)
                        .containerUIDProperty()
                        .findAllSync()
                        .toSet();

                    List<ContainerEntry> x = [];

                    for (String child in children) {
                      x.add(database.containerEntrys
                          .filter()
                          .containerUIDMatches(child)
                          .findFirstSync()!);
                    }

                    List<Widget> containerChildren = x
                        .map(
                          (e) => InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                (MaterialPageRoute(
                                  builder: (context) => ContainerView(
                                    database: database,
                                    containerUID: e.containerUID,
                                  ),
                                )),
                              );
                            },
                            child: ContainerCardWidget(
                                containerEntry: e, database: database),
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
