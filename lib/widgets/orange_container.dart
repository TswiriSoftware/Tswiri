import 'package:flutter/material.dart';

class OrangeOutlineContainer extends StatelessWidget {
  const OrangeOutlineContainer(
      {Key? key,
      required this.child,
      this.margin,
      this.padding,
      this.height,
      this.width,
      this.borderWidth})
      : super(key: key);

  final Widget child;
  final double? padding;
  final double? margin;
  final double? width;
  final double? height;
  final double? borderWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding ?? 5),
        margin: EdgeInsets.all(margin ?? 5),
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.deepOrange, width: borderWidth ?? 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            color: Colors.black26),
        child: child);
  }
}
