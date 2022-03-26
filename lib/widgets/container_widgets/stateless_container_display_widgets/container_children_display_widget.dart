import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import '../../basic_outline_containers/dark_container.dart';
import '../../basic_outline_containers/light_container.dart';

class ContainerChildrenDisplayWidget extends StatelessWidget {
  const ContainerChildrenDisplayWidget(
      {Key? key,
      required this.children,
      required this.updateChildren,
      required this.currentContainerEntry})
      : super(key: key);
  final List<ContainerEntry> children;
  final ContainerEntry currentContainerEntry;

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Children:', style: Theme.of(context).textTheme.bodySmall),
            const Divider(),
            Row(
              children: [
                Text(
                  'Number of children: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  children.length.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
