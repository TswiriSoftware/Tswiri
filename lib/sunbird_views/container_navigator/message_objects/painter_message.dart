class PainterMesssage {
  PainterMesssage({
    required this.diagonalLength,
    required this.painterData,
  });
  String identifier = 'painterMessage';
  double diagonalLength;
  List painterData;

  List toMessage() {
    return [
      identifier,
      diagonalLength,
      painterData,
    ];
  }

  factory PainterMesssage.fromMessage(message) {
    return PainterMesssage(
      diagonalLength: message[1],
      painterData: message[2],
    );
  }
}
