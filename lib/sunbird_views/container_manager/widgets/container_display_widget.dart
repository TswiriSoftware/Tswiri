import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';

Widget containerDisplayWidget(ContainerEntry containerEntry) {
  return Builder(
    builder: (context) {
      Color containerTypeColor =
          getContainerColor(containerUID: containerEntry.containerUID);
      return InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContainerView(
                containerEntry: containerEntry,
              ),
            ),
          );
        },
        child: LightContainer(
          margin: 2.5,
          padding: 2.5,
          child: CustomOutlineContainer(
            outlineColor: containerTypeColor,
            margin: 2.5,
            padding: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Container Name/UID',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  containerEntry.name ?? containerEntry.containerUID,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const Divider(
                  height: 5,
                ),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  containerEntry.description ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const Divider(
                  height: 5,
                ),
                Text(
                  'BarcodeUID',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  containerEntry.barcodeUID ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
