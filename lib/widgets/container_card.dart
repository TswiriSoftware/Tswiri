import 'package:flutter/material.dart';

import '../databaseAdapters/containerAdapter/container_entry_adapter.dart';
import 'dark_container.dart';
import 'light_container.dart';

class ContainerCard extends StatelessWidget {
  const ContainerCard({Key? key, required this.containerEntry})
      : super(key: key);

  final ContainerEntry containerEntry;
  @override
  Widget build(BuildContext context) {
    return LightContainer(
        margin: 2.5,
        padding: 2.5,
        child: DarkContainer(
          padding: 8,
          margin: 2.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Name: ',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    containerEntry.name ?? containerEntry.containerUID,
                    style:
                        TextStyle(fontSize: 18, color: Colors.deepOrange[800]),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Description: ',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    containerEntry.description ?? '',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Children: ',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    containerEntry.children?.length.toString() ?? '0',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              Text(
                'UID: ${containerEntry.containerUID}',
                style: const TextStyle(
                  fontSize: 8,
                ),
              )
            ],
          ),
        ));
  }
}
