import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';

import '../../basic_outline_containers/orange_outline_container.dart';

class ContainerChildrenPositionEdit extends StatefulWidget {
  ContainerChildrenPositionEdit({Key? key}) : super(key: key);

  @override
  State<ContainerChildrenPositionEdit> createState() =>
      _ContainerChildrenPositionEditState();
}

class _ContainerChildrenPositionEditState
    extends State<ContainerChildrenPositionEdit> {
  Color outlineColor = Colors.white54;
  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: CustomOutlineContainer(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Children Grid',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.width,
              //   child: const LightContainer(
              //     child: Text('position grid ?'),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      //Navigate to position Scan page.
                    },
                    child: OrangeOutlineContainer(
                      child: Text(
                        'scan',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //View map of children.
                    },
                    child: OrangeOutlineContainer(
                      child: Text(
                        'view',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        outlineColor: outlineColor,
      ),
    );
  }
}
