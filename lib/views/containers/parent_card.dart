import 'package:flutter/material.dart';

import 'package:tswiri_database/export.dart';
import 'package:tswiri_widgets/colors/colors.dart';

class ParentCardTile extends StatelessWidget {
  const ParentCardTile({
    Key? key,
    required this.containerRelationship,
    required this.initiallyExpanded,
    required this.onExpansionChanged,
    required this.onChange,
    required this.onNewParent,
  }) : super(key: key);

  final ContainerRelationship? containerRelationship;
  final bool initiallyExpanded;
  final void Function(bool? value) onExpansionChanged;
  final void Function() onChange;
  final void Function() onNewParent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        title: Text(
          'Parent',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        onExpansionChanged: (value) => onExpansionChanged(value),
        children: [
          containerRelationship != null
              ? Card(
                  color: background[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          containerRelationship!.parentUID!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        ElevatedButton(
                          onPressed: onChange,
                          child: Text(
                            'Change',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onNewParent,
                      child: Text(
                        'Scan Parent',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
