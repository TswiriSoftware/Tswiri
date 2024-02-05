import 'package:intl/intl.dart';

extension StringExt on String {
  int get barcodeNumber {
    return int.parse(split('_').first);
  }
}

extension DateTimeExt on DateTime {
  String get formatted {
    return DateFormat('yyyy-MM-dd - HH:mm').format(this);
  }
}
