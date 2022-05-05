import 'dart:ui';

class PainterData {
  PainterData({
    required this.selectedBarcode,
    required this.finderCircleRadius,
    required this.arrowLineStart,
    required this.arrowLineHead,
    required this.offsetToBarcodeAngle,
    required this.canvasSize,
    required this.painterBarcodeData,
  });

  final double finderCircleRadius;
  final Offset arrowLineStart;
  final Offset arrowLineHead;
  final double offsetToBarcodeAngle;
  final Size canvasSize;
  final String selectedBarcode;
  List<PainterBarcodeData> painterBarcodeData;

  Map toJson() {
    return {
      'finderCircleRadius': finderCircleRadius,
      'arrowLineStart': [arrowLineStart.dx, arrowLineStart.dy],
      'arrowLineHead': [arrowLineHead.dx, arrowLineHead.dy],
      'offsetToBarcodeAngle': offsetToBarcodeAngle,
      'canvasSize': [canvasSize.width, canvasSize.height],
      'selectedBarcode': selectedBarcode,
      'painterBarcodeData': painterBarcodeData,
    };
  }

  factory PainterData.fromJson(dynamic json) {
    List<dynamic> lineStart = json['arrowLineStart'];
    List<dynamic> lineEnd = json['arrowLineHead'];
    List<dynamic> size = json['canvasSize'];

    List<dynamic> painterBarcodeData = json['painterBarcodeData'] ?? [];
    List<PainterBarcodeData> painterData = List<PainterBarcodeData>.from(
        painterBarcodeData.map((e) => PainterBarcodeData.fromJson(e)));

    return PainterData(
      finderCircleRadius: json['finderCircleRadius'] as double,
      arrowLineStart: Offset(lineStart[0], lineStart[1]),
      arrowLineHead: Offset(lineEnd[0], lineEnd[1]),
      offsetToBarcodeAngle: json['offsetToBarcodeAngle'] as double,
      canvasSize: Size(size[0], size[1]),
      selectedBarcode: json['selectedBarcode'],
      painterBarcodeData: painterData,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return '''___________________________________________
finderCircleRadius: $finderCircleRadius
ArrowLineStart: $arrowLineStart
ArrowLineEnd: $arrowLineHead
offsetToBarcodeAngle: $offsetToBarcodeAngle
canvasSize: $canvasSize
selectedBarcode: $selectedBarcode
painterBarcodeData: $painterBarcodeData
___________________________________________''';
  }
}

class PainterBarcodeData {
  PainterBarcodeData({
    required this.barcodeUID,
    required this.rect,
  });
  final String barcodeUID;
  final List<double> rect;

  List<Offset> offsets() {
    return [
      Offset(rect[0], rect[1]),
      Offset(rect[2], rect[3]),
      Offset(rect[4], rect[5]),
      Offset(rect[6], rect[7]),
      Offset(rect[0], rect[1]),
    ];
  }

  Map toJson() {
    return {
      'barcodeUID': barcodeUID,
      'rect': rect,
    };
  }

  factory PainterBarcodeData.fromJson(dynamic json) {
    List<dynamic> rect = json['rect'];
    return PainterBarcodeData(
      barcodeUID: json['barcodeUID'] as String,
      rect: [
        rect[0],
        rect[1],
        rect[2],
        rect[3],
        rect[4],
        rect[5],
        rect[6],
        rect[7],
      ],
    );
  }
}
