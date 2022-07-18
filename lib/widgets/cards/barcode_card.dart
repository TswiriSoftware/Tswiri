import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:sunbird_v2/isar/collections/barcode_properties/barcode_property.dart';
import 'package:sunbird_v2/isar/collections/container_entry/container_entry.dart';
import 'package:sunbird_v2/isar/isar_database.dart';

class BarcodeCard extends StatelessWidget {
  BarcodeCard({Key? key, required this.barcodeProperty}) : super(key: key);

  final BarcodeProperty barcodeProperty;

  late final ContainerEntry? linkedContainer = isar!.containerEntrys
      .filter()
      .barcodeUIDMatches(barcodeProperty.barcodeUID)
      .findFirstSync();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  barcodeProperty.barcodeUID,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const Divider(
              indent: 5,
              endIndent: 5,
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Size: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${barcodeProperty.size} x ${barcodeProperty.size} mm',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const Divider(
              indent: 5,
              endIndent: 5,
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Linked: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  (linkedContainer == null)
                      ? '-'
                      : linkedContainer!.name ?? linkedContainer!.containerUID,
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
