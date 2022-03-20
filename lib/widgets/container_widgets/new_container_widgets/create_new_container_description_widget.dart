import 'package:flutter/material.dart';

import '../../basic_outline_containers/light_container.dart';
import '../../basic_outline_containers/orange_outline_container.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget(
      {Key? key, required this.name, required this.description})
      : super(key: key);
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      margin: 2.5,
      padding: 2.5,
      child: OrangeOutlineContainer(
        margin: 2.5,
        padding: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Divider(
              indent: 5,
              endIndent: 5,
              color: Colors.deepOrange,
            ),
            LightContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
