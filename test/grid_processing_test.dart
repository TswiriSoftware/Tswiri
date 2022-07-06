// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_google_ml_kit/functions/position_functions/average_inter_barcode_vectors.dart';
import 'package:flutter_google_ml_kit/functions/position_functions/create_inter_barcode_vectors.dart';
import 'package:flutter_google_ml_kit/functions/position_functions/create_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/functions/position_functions/generate_coordinates.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/objects/grid/interbarcode_vector.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data.dart';

//Calculation Tester.
void main() {
  //1. This checks that the fromBarcodeData works.
  OnImageBarcodeData onImageBarcode =
      OnImageBarcodeData.fromBarcodeData(barcodeDataBatches[0][0]);

  test('OnImageBarcodeData from BarcodeDataBatch', () {
    expect(onImageBarcode.barcodeUID, onImageBarcodeReference.barcodeUID);
    expect(onImageBarcode.onImageCornerPoints,
        onImageBarcodeReference.onImageCornerPoints);
    expect(onImageBarcode.timestamp, onImageBarcodeReference.timestamp);
    expect(onImageBarcode.accelerometerData.accelerometerEvent,
        onImageBarcodeReference.accelerometerData.accelerometerEvent);
    expect(onImageBarcode.accelerometerData.userAccelerometerEvent,
        onImageBarcodeReference.accelerometerData.userAccelerometerEvent);
  });

  List<BarcodeProperty> barcodeProperties =
      [for (var i = 1; i <= 50; i += 1) '$i']
          .map((e) => BarcodeProperty()
            ..barcodeUID = e
            ..size = 80)
          .toList();

  //2. This just pairs up barcodes.
  List<OnImageInterBarcodeData> onImageInterBarcodeData =
      createOnImageBarcodeData(barcodeDataBatches);

  //2.
  List<InterBarcodeVector> interBarcodeVectors =
      createInterbarcodeVectors(onImageInterBarcodeData, barcodeProperties, 1);

  //3.
  List<InterBarcodeVector> finalRealInterBarcodeData =
      averageInterbarcodeData(interBarcodeVectors);

  //4.
  ContainerEntry containerEntry = ContainerEntry()
    ..barcodeUID = '10'
    ..containerType = 'shelf'
    ..containerUID = '1'
    ..description = ''
    ..name = 'test';

  List<CoordinateEntry> coordinates =
      generateCoordinates(containerEntry, finalRealInterBarcodeData);

  List positions = [];
  for (var e in coordinates) {
    positions.add([e.x, e.y, e.z]);
  }

  test('Position Test', () {
    expect(positions, positionValues);
  });
}
