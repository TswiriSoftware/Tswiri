import 'package:flutter/material.dart';
import 'package:sunbird/isar/isar_database.dart';

class TagTextPredictor extends StatefulWidget {
  ///
  ///
  /// Remember to update tags with this function:
  ///
  /// *_tagTextSearchTextFieldkey.currentState?.updateAssignedTags(containerTag.tagTextID)*
  ///
  ///
  const TagTextPredictor({
    required Key? key,
    required this.excludedTags,
    required this.dismiss,
    required this.onTagAdd,
  }) : super(key: key);

  ///This is a list of tags that are not to be displayed by the widget.
  ///List of tags to Exlude from predictions.
  final List<int> excludedTags;

  ///This is called when the TagTextSearchField needs to be dismissed.
  final VoidCallback dismiss;

  ///This returns the tagTextID of the tag that needs to be added.
  final void Function(int) onTagAdd;

  @override
  State<TagTextPredictor> createState() => TagTextPredictorState();
}

class TagTextPredictorState extends State<TagTextPredictor> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late List<int> tagTextIDs = isar!.tagTexts
      .filter()
      .not()
      .group((q) =>
          q.repeat(excludedTags, (q, int tagTextID) => q.idEqualTo(tagTextID)))
      .findAllSync()
      .map((e) => e.id)
      .take(15)
      .toList();

  late List<int> excludedTags = widget.excludedTags;

  @override
  void initState() {
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 4,
                children:
                    tagTextIDs.map((tagTextID) => _tagChip(tagTextID)).toList(),
              ),
            ),
            const Divider(),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onChanged: (value) {
                      _filterTags(enteredKeyWord: value);
                    },
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        int? tagTextID = getTagTextID(value);
                        if (!excludedTags.contains(tagTextID)) {
                          widget.onTagAdd(tagTextID);
                          setState(() {
                            excludedTags.add(tagTextID);
                          });
                        }
                        _controller.clear();
                        _focusNode.requestFocus();
                      } else {
                        widget.dismiss();
                      }
                      _filterTags();
                    },
                  ),
                ),
                _controller.text.isEmpty ? _cancelButton() : _submitButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cancelButton() {
    return IconButton(
      onPressed: () {
        if (_controller.text.isEmpty) {
          widget.dismiss();
        } else {
          _controller.clear();
        }
      },
      icon: const Icon(Icons.close_sharp),
    );
  }

  Widget _submitButton() {
    return IconButton(
      onPressed: () {
        if (_controller.text.isNotEmpty) {
          int? tagTextID = getTagTextID(_controller.text);
          if (!excludedTags.contains(tagTextID)) {
            widget.onTagAdd(tagTextID);
            setState(() {
              excludedTags.add(tagTextID);
            });
          }
          _controller.clear();
          _focusNode.requestFocus();
        } else {
          widget.dismiss();
        }
        _filterTags();
      },
      icon: const Icon(Icons.check_sharp),
    );
  }

  Widget _tagChip(int tagTextID) {
    return ActionChip(
      label: Text(isar!.tagTexts.getSync(tagTextID)!.text),
      // backgroundColor: sunbirdOrange,
      onPressed: () {
        widget.onTagAdd(tagTextID);
        setState(() {
          excludedTags.add(tagTextID);
          _filterTags();
        });
      },
    );
  }

  void _filterTags({String? enteredKeyWord}) {
    if (enteredKeyWord != null && enteredKeyWord.isNotEmpty) {
      setState(() {
        tagTextIDs = isar!.tagTexts
            .filter()
            .textContains(enteredKeyWord, caseSensitive: false)
            .and()
            .not()
            .group((q) => q.repeat(
                excludedTags, (q, int tagTextID) => q.idEqualTo(tagTextID)))
            .findAllSync()
            .take(15)
            .map((e) => e.id)
            .toList();
      });
    } else {
      setState(() {
        tagTextIDs = isar!.tagTexts
            .filter()
            .not()
            .group((q) => q.repeat(
                excludedTags, (q, int tagTextID) => q.idEqualTo(tagTextID)))
            .findAllSync()
            .take(15)
            .map((e) => e.id)
            .toList();
      });
    }
  }

  ///Used to update display Tags.
  updateAssignedTags(int tagTextID) {
    setState(() {
      excludedTags.remove(tagTextID);
    });
    _filterTags();
  }

  ///Used to reset display Tags.
  resetExcludedTags(List<int> tagTextIDs) {
    setState(() {
      excludedTags = tagTextIDs;
    });
    _filterTags();
  }
}
