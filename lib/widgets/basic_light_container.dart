import 'package:flutter/material.dart';

class BasicLightContainer extends StatelessWidget {
  const BasicLightContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white60, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.grey[800],
        ),
        child: child);
  }
}
