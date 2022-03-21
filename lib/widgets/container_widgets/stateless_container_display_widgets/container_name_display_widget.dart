import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import '../../basic_outline_containers/light_container.dart';

class ContainerNameDisplayWidget extends StatelessWidget {
  const ContainerNameDisplayWidget({Key? key, required this.name})
      : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return LightContainer(
      margin: 2.5,
      padding: 2.5,
      child: OrangeOutlineContainer(
        borderWidth: 0.5,
        padding: 8,
        margin: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'name',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Divider(
              height: 3,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
