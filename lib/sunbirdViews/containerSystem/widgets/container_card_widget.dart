import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/custom_container.dart';

import '../../../isar/container_isar.dart';
import '../../../widgets/light_container.dart';

class ContainerCardWidget extends StatelessWidget {
  const ContainerCardWidget(
      {Key? key, required this.containerEntry, this.outlineColor})
      : super(key: key);
  final Color? outlineColor;

  final ContainerEntry containerEntry;
  @override
  Widget build(BuildContext context) {
    return LightContainer(
        margin: 2.5,
        padding: 2.5,
        child: CustomOutlineContainer(
          outlineColor: outlineColor ?? Colors.deepOrange,
          borderWidth: 1.5,
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
                    style: TextStyle(
                        fontSize: 18, color: outlineColor ?? Colors.deepOrange),
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
