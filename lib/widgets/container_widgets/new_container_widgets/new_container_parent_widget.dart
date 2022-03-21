import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';

import '../../basic_outline_containers/custom_outline_container.dart';
import '../../basic_outline_containers/light_container.dart';

class NewContainerParentWidget extends StatelessWidget {
  const NewContainerParentWidget(
      {Key? key, required this.onTap, this.parentUID, this.parentName})
      : super(key: key);
  final String? parentUID;
  final String? parentName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: Builder(builder: (context) {
        return CustomOutlineContainer(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('parentName',
                    style: Theme.of(context).textTheme.bodySmall),
                Text(parentName ?? "'",
                    style: Theme.of(context).textTheme.subtitle2),
                Text('parentUID', style: Theme.of(context).textTheme.bodySmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(parentUID ?? "'",
                        style: Theme.of(context).textTheme.subtitle2),
                    InkWell(
                      onTap: onTap,
                      child: OrangeOutlineContainer(
                        child: Text(
                          'select',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          outlineColor: Colors.white54,
        );
      }),
    );
  }
}
