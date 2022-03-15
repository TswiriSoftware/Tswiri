import 'package:flutter/material.dart';

///Container with a dark background and
class DarkContainer extends StatelessWidget {
  const DarkContainer({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final double? padding;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding ?? 5),
        margin: EdgeInsets.all(margin ?? 5),
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
