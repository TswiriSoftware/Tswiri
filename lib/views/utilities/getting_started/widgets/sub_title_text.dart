import 'package:flutter/material.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({Key? key, required this.subTitle}) : super(key: key);
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
