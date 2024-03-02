import 'package:flutter/material.dart';

class ContainerNameField extends StatelessWidget {
  const ContainerNameField({
    super.key,
    required this.controller,
    this.focusNode,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.onSaved,
    this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Function(String?)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      onSaved: (newValue) {
        onSaved?.call(newValue);
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted?.call(value);
      },
      onChanged: (value) {
        onChanged?.call(value);
      },
      validator: containerNameValidator,
      autocorrect: true,
      decoration: InputDecoration(
        labelText: 'Name',
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
    );
  }

  String? containerNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }
}
