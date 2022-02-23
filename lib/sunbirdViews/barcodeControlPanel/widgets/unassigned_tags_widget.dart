import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:provider/provider.dart';

import '../../../objects/tags_change_notifier.dart';

class UnassignedTagsContainer extends StatefulWidget {
  final List<String> unassignedTags;
  final int barcodeID;
  const UnassignedTagsContainer(
      {Key? key, required this.unassignedTags, required this.barcodeID})
      : super(key: key);

  @override
  State<UnassignedTagsContainer> createState() =>
      _UnassignedTagsContainerState();
}

class _UnassignedTagsContainerState extends State<UnassignedTagsContainer> {
  List<String> unassignedTags = [];
  String searchValue = '';
  bool isExpanded = false;

  @override
  void initState() {
    unassignedTags = widget.unassignedTags;
    super.initState();
  }

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
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.end,
            title: const Text(
              'Unassigned Tags',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            trailing: isExpanded
                ? const Icon(
                    Icons.arrow_drop_up,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
            onExpansionChanged: (bool expanding) =>
                setState(() => isExpanded = expanding),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Wrap(
                    spacing: 5,
                    children: Provider.of<Tags>(context)
                        .filter(searchValue)
                        .map((tag) => UnassignedTagButton(
                            tag: tag,
                            barcodeID: widget.barcodeID,
                            searchValue: searchValue))
                        .toList()),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                  });
                },
                scrollPadding: const EdgeInsets.only(bottom: 40),
                decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: deepSpaceSparkle)),
                    hoverColor: deepSpaceSparkle[700],
                    focusColor: deepSpaceSparkle[700],
                    contentPadding: const EdgeInsets.all(10),
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText: 'Search Tags or Enter new tag',
                    suffixIcon: Icon(
                      Icons.search,
                      color: deepSpaceSparkle[700],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UnassignedTagButton extends StatelessWidget {
  final String tag;
  final String searchValue;
  final int barcodeID;
  const UnassignedTagButton({
    required this.tag,
    required this.barcodeID,
    required this.searchValue,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (tag != '+') {
      return ElevatedButton(
          onPressed: () {
            Provider.of<Tags>(context, listen: false).addTag(tag, barcodeID);
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
    } else {
      return ElevatedButton(
          onPressed: () {
            if (searchValue.isNotEmpty) {
              Provider.of<Tags>(context, listen: false).addNewTag(searchValue);
            }
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
}
