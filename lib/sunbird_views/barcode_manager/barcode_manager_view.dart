import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/mathfunctions/round_to_double.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/search_bar_widget.dart';
import 'package:isar/isar.dart';

class BarcodeManagerView extends StatefulWidget {
  const BarcodeManagerView({Key? key}) : super(key: key);

  @override
  State<BarcodeManagerView> createState() => _BarcodeManagerViewState();
}

class _BarcodeManagerViewState extends State<BarcodeManagerView> {
  String? enteredKeyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Manager',
            style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          ///Search Bar.
          _searchBar(),
          const SizedBox(height: 10),
          _optionsText(),
          const SizedBox(height: 5),
          Builder(
            builder: (context) {
              List<BarcodeProperty> allBarcodes =
                  isarDatabase!.barcodePropertys.where().findAllSync();
              //log(allBarcodes.toString());
              return Expanded(
                child: ListView.builder(
                  itemCount: allBarcodes.length,
                  itemBuilder: ((context, index) {
                    BarcodeProperty barcodeProperty = allBarcodes[index];
                    ContainerEntry? linkedContainer = isarDatabase!
                        .containerEntrys
                        .filter()
                        .barcodeUIDMatches(barcodeProperty.barcodeUID)
                        .findFirstSync();
                    return barcodeTile(
                        barcodeProperty: barcodeProperty,
                        linkedContainer: linkedContainer);
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget barcodeTile(
      {required BarcodeProperty barcodeProperty,
      ContainerEntry? linkedContainer}) {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: Builder(builder: (context) {
        Color color = Colors.white54;
        if (linkedContainer != null) {
          color = Colors.deepOrange;
        }
        return CustomOutlineContainer(
          outlineColor: color,
          margin: 5,
          padding: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BarcodeUID',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                barcodeProperty.barcodeUID,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(
                height: 5,
              ),
              Text(
                'Barcode Size',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                roundDouble(barcodeProperty.size, 2).toString() + 'mm',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(
                height: 5,
              ),
              Builder(builder: (context) {
                if (linkedContainer != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ContainerUID',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        linkedContainer.containerUID,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  );
                }
                return Container();
              }),
            ],
          ),
        );
      }),
    );
  }

  Widget _searchBar() {
    return SearchBarWidget(
      onChanged: (value) {
        setState(() {
          enteredKeyword = value;
        });
      },
    );
  }

  Widget _optionsText() {
    return const Text(
      'Swipe for more options',
      style: TextStyle(fontSize: 12),
    );
  }
}
