extension StringExtension on String {
  String capitalizeFirstCharacter() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
