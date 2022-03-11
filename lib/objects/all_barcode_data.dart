///Contains a barcodeID and a list of tags
class AllBarcodeData {
  AllBarcodeData(
      {required final this.barcodeID,
      required final this.barcodeSize,
      required final this.isFixed,
      final this.tags,
      final this.unassignedTags,
      final this.barcodePhotoData,
      final this.description});

  ///BarcodeID
  final String barcodeID;

  ///Size of the Barcode.
  final double barcodeSize;

  final bool isFixed;

  ///List of tags
  final List<String>? tags;

  ///List of unassigned Tags.
  final List<String>? unassignedTags;

  ///Barcode Photo Entries.
  final Map<String, List<String>>? barcodePhotoData;

  ///Barcode's description.
  final String? description;

  @override
  String toString() {
    return '$barcodeID, $barcodeSize, $tags';
  }
}
