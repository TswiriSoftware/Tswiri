import 'package:flutter/material.dart';

class CustomOutlineContainer extends StatelessWidget {
  const CustomOutlineContainer({
    Key? key,
    required this.child,
    required this.outlineColor,
    this.margin,
    this.padding,
    this.borderWidth,
  }) : super(key: key);

  final Widget child;
  final Color outlineColor;
  final double? padding;
  final double? margin;
  final double? borderWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(padding ?? 0),
        margin: EdgeInsets.all(margin ?? 0),
        decoration: BoxDecoration(
            border: Border.all(color: outlineColor, width: borderWidth ?? 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            color: Colors.black26),
        child: child);
  }
}
