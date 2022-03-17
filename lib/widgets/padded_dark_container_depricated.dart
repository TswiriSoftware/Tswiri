import 'package:flutter/material.dart';

///Container with a dark background and
class PaddedDarkContainer extends StatelessWidget {
  const PaddedDarkContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white60, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.black26,
        ),
        child: child);
  }
}
