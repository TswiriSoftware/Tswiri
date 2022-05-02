import 'package:flutter_google_ml_kit/objects/navigation/isolate_on_image_data.dart';

///Describes the "Offset" between two barcodes.
class IsolateOnImageInterBarcodeData {
  IsolateOnImageInterBarcodeData({
    required this.startBarcode,
    required this.endBarcode,
  });

  ///Data related to the start barcode.
  final IsolateOnImageBarcodeData startBarcode;

  ///Data related to the end barcode.
  final IsolateOnImageBarcodeData endBarcode;

  ///This takes 2 IsolateRawOnImageBarcodeData and returns them so that the smaller barcode is always first.
  factory IsolateOnImageInterBarcodeData.fromBarcodeDataPair(
    IsolateOnImageBarcodeData rawOnImageBarcodeData1,
    IsolateOnImageBarcodeData rawOnImageBarcodeData2,
  ) {
    int startBarcode =
        int.parse(rawOnImageBarcodeData1.barcodeUID.split('_').first);
    int endBarcode =
        int.parse(rawOnImageBarcodeData2.barcodeUID.split('_').first);

    if (startBarcode < endBarcode) {
      return IsolateOnImageInterBarcodeData(
        startBarcode: rawOnImageBarcodeData1,
        endBarcode: rawOnImageBarcodeData2,
      );
    } else {
      return IsolateOnImageInterBarcodeData(
        startBarcode: rawOnImageBarcodeData2,
        endBarcode: rawOnImageBarcodeData1,
      );
    }
  }

  ///This returns the UID of the Start and end Barcode.
  String get uid {
    return startBarcode.barcodeUID + '_' + endBarcode.barcodeUID;
  }

  @override
  bool operator ==(Object other) {
    return other is IsolateOnImageInterBarcodeData &&
        hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    return '\n${startBarcode.barcodeUID} => ${endBarcode.barcodeUID}';
  }
}
