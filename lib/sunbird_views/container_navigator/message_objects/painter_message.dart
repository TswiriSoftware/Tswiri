import 'dart:ui';

class PainterMesssage {
  PainterMesssage({
    required this.averageDiagonalLength,
    required this.painterData,
    required this.averageOffsetToBarcode,
  });
  String identifier = 'painterMessage';
  double averageDiagonalLength;
  Offset averageOffsetToBarcode;
  List painterData;

  List toMessage() {
    return [
      identifier,
      averageDiagonalLength,
      painterData,
      [averageOffsetToBarcode.dx, averageOffsetToBarcode.dy]
    ];
  }

  factory PainterMesssage.fromMessage(message) {
    return PainterMesssage(
      averageDiagonalLength: message[1],
      painterData: message[2],
      averageOffsetToBarcode:
          Offset(message[3][0] as double, message[3][1] as double),
    );
  }
}
