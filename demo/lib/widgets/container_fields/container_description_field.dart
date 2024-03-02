import 'package:flutter/material.dart';

class ContainerDescriptionField extends StatelessWidget {
  const ContainerDescriptionField({
    super.key,
    required this.controller,
    this.onFieldSubmitted,
    this.onSaved,
    this.onChanged,
    this.suffixIcon,
    this.focusNode,
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
      autocorrect: true,
      onChanged: (value) {
        onChanged?.call(value);
      },
      onSaved: (newValue) {
        onSaved?.call(newValue);
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted?.call(value);
      },
      decoration: InputDecoration(
        labelText: 'Description',
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
