import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/isar_export.dart';

import 'package:flutter_google_ml_kit/views/widgets/cards/default_card/defualt_card.dart';
import 'package:isar/isar.dart';

class DatabaseManager extends StatefulWidget {
  const DatabaseManager({Key? key}) : super(key: key);

  @override
  State<DatabaseManager> createState() => _DatabaseManagerState();
}

class _DatabaseManagerState extends State<DatabaseManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Database Manager',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _resetDatabase(),
          _loadBarcodes(),
        ],
      ),
    );
  }

  //Key: reset_database
  Card _resetDatabase() {
    return defaultCard(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                  '1. Clear the isar database\n2. Re-populate container types'),
              ElevatedButton(
                key: const Key('reset_database'),
                onPressed: () {
                  isarDatabase!.writeTxnSync((isar) => isar.clearSync());

                  createBasicContainerTypes();

                  setState(() {});
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const Divider(),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Table',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const VerticalDivider(),
                Text(
                  'Entries',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const Divider(),
          tableEntry(
            'containerEntrys',
            isarDatabase!.containerEntrys.where().findAllSync().length,
          ),
          tableEntry(
            'containerRelationships',
            isarDatabase!.containerRelationships.where().findAllSync().length,
          ),
          tableEntry(
            'containerTypes',
            isarDatabase!.containerTypes.where().findAllSync().length,
          ),
          tableEntry(
            'markers',
            isarDatabase!.markers.where().findAllSync().length,
          ),
          tableEntry(
            'barcodePropertys',
            isarDatabase!.barcodePropertys.where().findAllSync().length,
          ),
          tableEntry(
            'barcodeGenerationEntrys',
            isarDatabase!.barcodeGenerationEntrys.where().findAllSync().length,
          ),
          tableEntry(
            'barcodeSizeDistanceEntrys',
            isarDatabase!.barcodeSizeDistanceEntrys
                .where()
                .findAllSync()
                .length,
          ),
          tableEntry(
            'photos',
            isarDatabase!.photos.where().findAllSync().length,
          ),
          tableEntry(
            'containerTags',
            isarDatabase!.containerTags.where().findAllSync().length,
          ),
          tableEntry(
            'mlTags',
            isarDatabase!.mlTags.where().findAllSync().length,
          ),
          tableEntry(
            'objectBoundingBoxs',
            isarDatabase!.objectBoundingBoxs.where().findAllSync().length,
          ),
          tableEntry(
            'tagTexts',
            isarDatabase!.tagTexts.where().findAllSync().length,
          ),
          tableEntry(
            'userTags',
            isarDatabase!.userTags.where().findAllSync().length,
          ),
          tableEntry(
            'coordinateEntrys',
            isarDatabase!.coordinateEntrys.where().findAllSync().length,
          ),
        ],
      ),
      borderColor: sunbirdOrange,
    );
  }

  Widget tableEntry(String name, int length) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              length.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
              key: Key(name),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  //Key: load_barcodes
  Card _loadBarcodes() {
    return defaultCard(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('1. Load predefined barcodes'),
                ElevatedButton(
                  key: const Key('load_barcodes'),
                  onPressed: () {
                    List<String> scannedBarcodes = [
                      for (var i = 1; i <= 50; i += 1) '$i'
                    ];

                    BarcodeGenerationEntry importedBarcodeEntry =
                        BarcodeGenerationEntry()
                          ..rangeStart = 1
                          ..rangeEnd = 50
                          ..size = 80
                          ..timestamp = 0
                          ..barcodeUIDs = scannedBarcodes;

                    List<BarcodeProperty> barcodeProperties = scannedBarcodes
                        .map((e) => BarcodeProperty()
                          ..barcodeUID = e
                          ..size = 80)
                        .toList();

                    isarDatabase!.writeTxnSync((isar) {
                      isar.barcodeGenerationEntrys
                          .putSync(importedBarcodeEntry);
                      isar.barcodePropertys.putAllSync(barcodeProperties);
                    });

                    setState(() {});
                  },
                  child: const Text('load'),
                )
              ],
            ),
          ],
        ),
        borderColor: sunbirdOrange);
  }
}
