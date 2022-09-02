extension StringExtension on String {
  String capitalizeFirstCharacter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
