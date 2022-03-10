import 'package:flutter/material.dart';

import '../functions/barcodeTools/hide_keyboard.dart';

///This is the searchBar widget.
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key, required this.onChanged}) : super(key: key);
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onChanged(value);
      },
      onEditingComplete: () => hideKeyboard(context),
      decoration: const InputDecoration(
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hoverColor: Colors.deepOrange,
        focusColor: Colors.deepOrange,
        suffixIconColor: Colors.deepOrange,
        contentPadding: EdgeInsets.all(10),
        labelStyle: TextStyle(color: Colors.white),
        labelText: 'Search',
        suffixIcon: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}
