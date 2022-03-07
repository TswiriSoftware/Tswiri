import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:provider/provider.dart';

import '../../../objects/change_notifiers.dart';

class TagsContainerWidget extends StatefulWidget {
  const TagsContainerWidget({Key? key, required this.barcodeID})
      : super(key: key);

  final int barcodeID;

  @override
  State<TagsContainerWidget> createState() => _TagsContainerWidgetState();
}

class _TagsContainerWidgetState extends State<TagsContainerWidget> {
  String searchValue = '';
  bool isExpanded = false;

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
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: const Text(
                'Tags:',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              trailing: isExpanded
                  ? const Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.add_circle_outline_outlined,
                      color: Colors.white,
                    ),
              subtitle: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Wrap(
                    spacing: 5,
                    children: Provider.of<PhotosAndTags>(context)
                        .assignedTags
                        .map((tag) => AssignedTagButton(
                              tag: tag,
                              barcodeID: widget.barcodeID,
                            ))
                        .toList()),
              ),
              onExpansionChanged: (bool expanding) =>
                  setState(() => isExpanded = expanding),
              children: [
                const Divider(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Wrap(
                      spacing: 5,
                      children: Provider.of<PhotosAndTags>(context)
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
          Provider.of<PhotosAndTags>(context, listen: false)
              .deleteTag(tag, barcodeID);
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
          Provider.of<PhotosAndTags>(context, listen: false)
              .addTag(tag, barcodeID);
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
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 40,
        child: ElevatedButton(
            onPressed: () {
              if (searchValue.isNotEmpty) {
                Provider.of<PhotosAndTags>(context, listen: false)
                    .addNewTag(searchValue);
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
                ))),
      );
    }
  }
}
