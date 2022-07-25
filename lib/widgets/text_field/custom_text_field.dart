import 'package:flutter/material.dart';

import '../../globals/globals_export.dart';

class CustomTextField extends StatefulWidget {
  ///   CustomTextField.
  ///  - ```label```
  ///  - ```initialValue```
  ///  - ```onSubmitted()```
  const CustomTextField({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onSubmitted,
  }) : super(key: key);

  final String label;
  final String? initialValue;
  final void Function(String) onSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _controller.text = widget.initialValue ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onSubmitted: widget.onSubmitted,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          filled: true,
          fillColor: background[500],
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: widget.label,
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: sunbirdOrange)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: sunbirdOrange)),
        ),
      ),
    );
  }
}
