import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:provider/provider.dart';

import '../../../objects/tags_change_notifier.dart';

class AssignedTagsContainer extends StatefulWidget {
  const AssignedTagsContainer(
      {Key? key, required this.assignedTags, required this.barcodeID})
      : super(key: key);
  final List<String>? assignedTags;
  final int barcodeID;

  @override
  State<AssignedTagsContainer> createState() => _AssignedTagsContainerState();
}

class _AssignedTagsContainerState extends State<AssignedTagsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: deepSpaceSparkle[200],
        border: Border.all(color: Colors.white60, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Wrap(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5, left: 10),
            child: Text(
              'Assigned Tags',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Wrap(
                spacing: 5,
                children: Provider.of<Tags>(context)
                    .assignedTags
                    .map((tag) => AssignedTagButton(
                          tag: tag,
                          barcodeID: widget.barcodeID,
                        ))
                    .toList()),
          ),
        ],
      ),
    );
  }
}

class AssignedTagButton extends StatelessWidget {
  final String tag;
  final int barcodeID;
  const AssignedTagButton({
    Key? key,
    required this.barcodeID,
    required this.tag,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Provider.of<Tags>(context, listen: false).deleteTag(tag, barcodeID);
        },
        child: Text(
          tag,
          style: const TextStyle(color: Colors.black),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(
                  color: Colors.teal,
                  width: 2.0,
                ),
              ),
            )));
  }
}
