import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';

class OrangeTextButton extends StatelessWidget {
  const OrangeTextButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: OrangeOutlineContainer(
          padding: 8,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          )),
    );
  }
}
