class Container {
  Container({
    required this.containerUID,
    this.barcodeUID,
    this.photoUID,
  });

  String containerUID;
  String? barcodeUID;
  List<String>? photoUID;
}
