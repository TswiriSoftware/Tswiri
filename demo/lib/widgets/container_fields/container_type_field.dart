import 'package:flutter/material.dart';
import 'package:tswiri/widgets/form_fields/container_type_form_field.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class ContainerTypeField extends StatelessWidget {
  const ContainerTypeField({
    super.key,
    required this.containerTypes,
    required this.initialValue,
    this.onSaved,
    this.onChanged,
  });

  final List<ContainerType> containerTypes;
  final ContainerType initialValue;
  final void Function(ContainerType?)? onSaved;
  final void Function(ContainerType)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ContainerTypeFormField(
      containerTypes: containerTypes,
      initialValue: initialValue,
      onSaved: (newValue) {
        if (newValue == null) return;
        onSaved?.call(newValue);
      },
      onChanged: (newValue) {
        onChanged?.call(newValue);
      },
      validator: containerTypeValidator,
    );
  }

  String? containerTypeValidator(ContainerType? containerType) {
    if (containerType == null) {
      return 'Container type is required';
    }
    return null;
  }
}
