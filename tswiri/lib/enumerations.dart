import 'dart:ui';

enum BarcodeSize {
  extraSmall(Size(10, 10), 'XS'),
  small(Size(25, 25), 'S'),
  medium(Size(50, 50), 'M'),
  large(Size(75, 75), 'L'),
  custom(Size(100, 100), 'C'),
  ;

  const BarcodeSize(
    this.size,
    this.label,
  );
  final Size size;
  final String label;

  static BarcodeSize fromString(String value) {
    return BarcodeSize.values.firstWhere((e) => e.toString() == value);
  }
}
