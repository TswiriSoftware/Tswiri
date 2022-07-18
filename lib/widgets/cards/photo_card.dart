import 'package:flutter/material.dart';

import '../../globals/globals_export.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: background[400],
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          shape: BoxShape.rectangle),
      // child: SizedBox(
      //   width: 100,
      //   height: 100,
      // ),
    );
  }
}
