import 'package:flutter/material.dart';
import 'package:sunbird_2/globals/globals_export.dart';

class CustomFilterChip extends StatelessWidget {
  ///   Chip used to display a Filter.
  /// - ```onTap()```
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2.5),
      child: FilterChip(
        label: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onSelected: onSelected,
        selected: selected,
        selectedColor: sunbirdOrange,
        tooltip: toolTip,
      ),
    );
  }
}
