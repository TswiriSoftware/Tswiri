import 'package:flutter/material.dart';

import '../functions/keyboard_functions/hide_keyboard.dart';

///This is the searchBar widget.
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key, required this.onChanged, this.filter})
      : super(key: key);
  final void Function(String) onChanged;
  final Widget? filter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              onChanged(value);
            },
            onEditingComplete: () => hideKeyboard(context),
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
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
          ),
        ),
        Builder(builder: (context) {
          if (filter != null) {
            return filter!;
          }
          return Container();
        }),
      ],
    );
  }
}
