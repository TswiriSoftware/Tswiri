import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';

///Generate a list of OnImageInterBarcodeData from barcodeDataBatches.
///
///   i. Iterate through barcodeDataBatches.
///
///   ii. Iterate through the barcodeDataBatch and generate IsolateRawOnImageBarcodeData.
///
///   iii.Iterate through onImageBarcodeDataBatch.
///
///   iv. Create BarcodeDataPairs.
///
List<OnImageInterBarcodeData> createOnImageBarcodeData(
    List barcodeDataBatches) {
  List<OnImageInterBarcodeData> onImageInterBarcodeData = [];

  for (int i = 0; i < barcodeDataBatches.length; i++) {
    //i. Iterate through barcodeDataBatches.
    List barcodeDataBatch = barcodeDataBatches[i];

    List<OnImageBarcodeData> onImageBarcodeDataBatch = [];

    for (int x = 0; x < barcodeDataBatch.length; x++) {
      //ii. Iterate through the barcodeDataBatch and generate IsolateRawOnImageBarcodeData.
      onImageBarcodeDataBatch
          .add(OnImageBarcodeData.fromBarcodeData(barcodeDataBatch[x]));
    }

    for (OnImageBarcodeData onImageBarcodeData in onImageBarcodeDataBatch) {
      //iii.Iterate through onImageBarcodeDataBatch.

      for (int z = 1; z < onImageBarcodeDataBatch.length; z++) {
        //iv. Create BarcodeDataPairs.
        if (onImageBarcodeData.barcodeUID !=
            onImageBarcodeDataBatch[z].barcodeUID) {
          onImageInterBarcodeData.add(
              OnImageInterBarcodeData.fromBarcodeDataPair(
                  onImageBarcodeData, onImageBarcodeDataBatch[z]));
        }
      }
    }
  }
  return onImageInterBarcodeData;
}
