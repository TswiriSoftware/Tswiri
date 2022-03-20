import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/dark_container.dart';

class LightDarkContainer extends StatelessWidget {
  const LightDarkContainer(
      {Key? key,
      required this.child,
      this.margin,
      this.padding,
      this.borderWidth})
      : super(key: key);

  final Widget child;
  final double? padding;
  final double? margin;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white60, width: borderWidth ?? 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.grey[800],
        ),
        child: DarkContainer(margin: 2.50, padding: 5, child: child));
  }
}
