//Contains a barcodeID and a list of tags
class BarcodeAndTagData {
  BarcodeAndTagData({
    required final this.barcodeID,
    final this.tags,
  });
  //BarcodeID
  final int barcodeID;
  //List of tags
  final List<String>? tags;

  @override
  String toString() {
    return '$barcodeID, $tags';
  }
}
