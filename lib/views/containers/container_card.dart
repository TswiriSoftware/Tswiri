import 'package:flutter/material.dart';

import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/functions/isar/get_functions.dart';
import 'package:tswiri_database/models/settings/global_settings.dart';
import 'package:tswiri_widgets/colors/colors.dart';

class ContainerCard extends StatelessWidget {
  const ContainerCard({
    Key? key,
    required this.catalogedContainer,
    required this.onTap,
    required this.onLongPress,
    required this.isSelected,
  }) : super(key: key);

  final CatalogedContainer catalogedContainer;
  final void Function() onTap;
  final void Function() onLongPress;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        shape: isSelected
            ? RoundedRectangleBorder(
                side: const BorderSide(
                  color: tswiriOrange,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    catalogedContainer.name ?? catalogedContainer.containerUID,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Icon(
                    getContainerTypeIcon(catalogedContainer.containerTypeID),
                  ),
                ],
              ),
              Divider(
                color: colorModeEnabled
                    ? isar!.containerTypes
                        .getSync(catalogedContainer.containerTypeID)!
                        .containerColor
                    : null,
                thickness: 1,
              ),
              Text(
                'Description: ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                catalogedContainer.description ?? '-',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Divider(),
              Text(
                'Barcode: ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                catalogedContainer.barcodeUID ?? 'err',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
