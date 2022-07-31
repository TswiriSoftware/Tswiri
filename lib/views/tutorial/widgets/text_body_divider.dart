import 'package:flutter/material.dart';
import 'package:sunbird/globals/globals_export.dart';

class TextBodyDivider extends StatelessWidget {
  const TextBodyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: sunbirdOrange,
      thickness: 2,
    );
  }
}
