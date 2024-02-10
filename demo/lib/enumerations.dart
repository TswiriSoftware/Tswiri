import 'dart:ui';

enum BarcodeSize {
  extraSmall(Size(10, 10), 'XS', 'Extra Small'),
  small(Size(25, 25), 'S', 'Small'),
  medium(Size(50, 50), 'M', 'Medium'),
  large(Size(75, 75), 'L', 'Large'),
  custom(Size(100, 100), 'C', 'Custom'),
  ;

  const BarcodeSize(
    this.size,
    this.label,
    this.description,
  );
  final Size size;
  final String label;
  final String description;

  static BarcodeSize fromString(String value) {
    return BarcodeSize.values.firstWhere((e) => e.toString() == value);
  }
}
