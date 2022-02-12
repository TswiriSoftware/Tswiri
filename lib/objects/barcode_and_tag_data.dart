///Contains a barcodeID and a list of tags
class BarcodeAndTagData {
  BarcodeAndTagData({
    required final this.barcodeID,
    required final this.barcodeSize,
    final this.tags,
  });

  ///BarcodeID
  final int barcodeID;

  ///Size of the Barcode.
  final double barcodeSize;

  ///List of tags
  final List<String>? tags;

  @override
  String toString() {
    return '$barcodeID, $tags';
  }
}
