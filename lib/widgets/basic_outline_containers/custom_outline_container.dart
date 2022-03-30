import 'package:flutter/material.dart';

class CustomOutlineContainer extends StatelessWidget {
  const CustomOutlineContainer(
      {Key? key,
      required this.child,
      required this.outlineColor,
      this.margin,
      this.padding,
      this.borderWidth,
      this.width,
      this.height,
      this.borderRadius,
      this.backgroundColor})
      : super(key: key);

  final Widget child;
  final Color outlineColor;
  final double? padding;
  final double? margin;
  final double? borderWidth;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding ?? 0),
        margin: EdgeInsets.all(margin ?? 0),
        decoration: BoxDecoration(
            border: Border.all(color: outlineColor, width: borderWidth ?? 1),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 5),
            ),
            color: backgroundColor ?? Colors.black26),
        child: child);
  }
}
