import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';

class BarcodeManagerObject {
  BarcodeManagerObject(
      {required this.barcodeProperty, required this.containerEntry});
  final BarcodeProperty barcodeProperty;
  final ContainerEntry? containerEntry;

  //TODO: implement custom sorting etc. @049er
  //Filtering and searching these objects :D

}
