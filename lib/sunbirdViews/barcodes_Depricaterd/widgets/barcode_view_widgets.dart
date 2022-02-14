import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/functions/barcodeTools/get_data_functions.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:hive/hive.dart';

barcodeData(BarcodeAndTagData barcodeAndTagData) {
  return Container(
    width: double.infinity,
    height: 100,
    margin: const EdgeInsets.only(bottom: 5, top: 5),
    decoration: BoxDecoration(
      color: deepSpaceSparkle[200],
      border: Border.all(color: Colors.white60, width: 2),
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5, left: 10),
          child: Text(
            'Barcode Data',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 10),
          child: Text('Barcode ID:  ' + barcodeAndTagData.barcodeID.toString()),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5, left: 10),
          child: Text('Barcode Size:  ?? '),
        )
      ],
    ),
  );
}
