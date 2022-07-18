import 'package:flutter/material.dart';
import 'package:sunbird_v2/globals/globals_export.dart';

class CustomFilterChip extends StatelessWidget {
  const CustomFilterChip({
    Key? key,
    required this.label,
    required this.toolTip,
    required this.selected,
    required this.onSelected,
  }) : super(key: key);

  final String label;
  final String toolTip;
  final bool selected;
  final void Function(bool) onSelected;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      onSelected: onSelected,
      selected: selected,
      selectedColor: sunbirdOrange,
      tooltip: toolTip,
    );
  }
}
