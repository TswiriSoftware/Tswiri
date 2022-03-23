import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';

import '../../../sunbird_views/container_system/container_views/container_view.dart';
import '../../basic_outline_containers/dark_container.dart';
import '../../basic_outline_containers/light_container.dart';

class ContainerChildrenDisplayWidget extends StatelessWidget {
  const ContainerChildrenDisplayWidget(
      {Key? key, required this.children, required this.updateChildren})
      : super(key: key);
  final List<ContainerEntry> children;

  final void Function() updateChildren;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      margin: 2.5,
      padding: 2.5,
      child: DarkContainer(
        margin: 0,
        padding: 8,
        borderWidth: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Children:', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(
              height: 200,
              child: Builder(builder: (context) {
                return ListView(
                  children: children
                      .map(
                        (e) => InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              (MaterialPageRoute(
                                builder: (context) => ContainerView(
                                  containerUID: e.containerUID,
                                ),
                              )),
                            );
                            updateChildren;
                          },
                          child: LightContainer(
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    (e.name ?? e.containerUID),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    e.description ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    e.containerUID,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
