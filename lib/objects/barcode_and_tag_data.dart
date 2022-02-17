///Contains a barcodeID and a list of tags
class BarcodeAndTagData {
  BarcodeAndTagData({
    required final this.barcodeID,
    required final this.barcodeSize,
    required final this.fixed,
    final this.tags,
  });

  ///BarcodeID
  final int barcodeID;

  ///Size of the Barcode.
  final double barcodeSize;

  final bool fixed;

  ///List of tags
  final List<String>? tags;

  @override
  String toString() {
    return '$barcodeID, $barcodeSize, $tags';
  }
}
