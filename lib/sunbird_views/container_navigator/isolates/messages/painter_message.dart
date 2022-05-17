import 'dart:ui';

///Message sent to the painter.
class PainterMesssage {
  PainterMesssage({
    required this.averageDiagonalLength,
    required this.painterData,

    /// required this.averageOffsetToBarcode,
  });

  String identifier = 'painterMessage';
  double averageDiagonalLength;
  //Offset averageOffsetToBarcode;
  List<PainterBarcodeObject> painterData;

  List toMessage() {
    List messagePainterData = painterData.map((e) => e.toMessage()).toList();

    return [
      identifier,
      averageDiagonalLength,
      messagePainterData,
      //[averageOffsetToBarcode.dx, averageOffsetToBarcode.dy]
    ];
  }

  factory PainterMesssage.fromMessage(message) {
    List messagePainterData = message[2];

    return PainterMesssage(
      averageDiagonalLength: message[1],
      painterData: messagePainterData
          .map((e) => PainterBarcodeObject.fromMessage(e))
          .toList(),
      // averageOffsetToBarcode: Offset(
      //   message[3][0] as double,
      //   message[3][1] as double,
      // ),
    );
  }

  @override
  String toString() {
    return '''_______________________________________________
    identifier: $identifier
    averageDiagonalLength: $averageDiagonalLength
    painterData: ${painterData.length}
  averageOffsetToBarcode: averageOffsetToBarcode
_______________________________________________''';
  }
}

///Passed to the painter for drawing
class PainterBarcodeObject {
  PainterBarcodeObject({
    required this.barcodeUID,
    required this.conrnerPoints,
  });
  final String barcodeUID;
  List<Offset> conrnerPoints;

  List toMessage() {
    return [
      barcodeUID, //[0]
      [
        conrnerPoints[0].dx,
        conrnerPoints[0].dy,
        conrnerPoints[1].dx,
        conrnerPoints[1].dy,
        conrnerPoints[2].dx,
        conrnerPoints[2].dy,
        conrnerPoints[3].dx,
        conrnerPoints[3].dy,
      ], // cornerPoints
    ];
  }

  factory PainterBarcodeObject.fromMessage(List message) {
    List<Offset> cornerPoints = [
      Offset(message[1][0], message[1][1]),
      Offset(message[1][2], message[1][3]),
      Offset(message[1][4], message[1][5]),
      Offset(message[1][6], message[1][7]),
      Offset(message[1][0], message[1][1]),
    ];

    return PainterBarcodeObject(
      barcodeUID: message[0],
      conrnerPoints: cornerPoints,
    );
  }
}
