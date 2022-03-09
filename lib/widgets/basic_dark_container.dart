import 'package:flutter/material.dart';

class BasicDarkContainer extends StatelessWidget {
  const BasicDarkContainer({Key? key, required this.children})
      : super(key: key);
  final List<Widget> children;
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
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ],
      ),
    );
  }
}
