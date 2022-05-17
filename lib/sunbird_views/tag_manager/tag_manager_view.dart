import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:googleapis/drive/v2.dart';
import 'package:isar/isar.dart';

class TagManagerView extends StatefulWidget {
  const TagManagerView({Key? key}) : super(key: key);

  @override
  State<TagManagerView> createState() => _TagManagerViewState();
}

class _TagManagerViewState extends State<TagManagerView> {
  TextEditingController tagController = TextEditingController();
  final _tagsNode = FocusNode();
  late List<TagText> allTags = isarDatabase!.tagTexts.where().findAllSync();
  late List<TagText> displayTags = allTags;
  @override
  void initState() {
    _tagsNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(),
      body: _body(),
      bottomSheet: _bottomSheet(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Tags', style: Theme.of(context).textTheme.titleMedium),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: displayTags.map((e) => tagChip(e)).toList(),
          ),
        ),
      ),
    );
  }

  Widget tagChip(TagText tag) {
    return ActionChip(
      onPressed: () {
        setState(() {});
      },
      backgroundColor: sunbirdOrange,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag.text,
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return TextField(
      controller: tagController,
      focusNode: _tagsNode,
      onChanged: (value) {
        searchTags(value);
      },
      onSubmitted: (value) {
        addTag();
      },
      style: const TextStyle(fontSize: 18),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white10,
        label: const Text('New Tag'),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        suffixIcon: IconButton(
          onPressed: () {
            addTag();
          },
          icon: const Icon(Icons.add),
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: sunbirdOrange)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: sunbirdOrange)),
      ),
    );
  }

  void searchTags(String value) {
    setState(() {
      displayTags = isarDatabase!.tagTexts
          .filter()
          .textContains(tagController.text, caseSensitive: false)
          .findAllSync();
    });
  }

  void addTag() {
    TagText? exists = isarDatabase!.tagTexts
        .filter()
        .textMatches(tagController.text.trim(), caseSensitive: false)
        .findFirstSync();

    String inputValue = tagController.text;

    if (exists == null && inputValue.isNotEmpty) {
      //Remove white spaces
      inputValue.trim();

      TagText newTag = TagText()..text = inputValue;
      isarDatabase!.writeTxnSync(
        (isar) => isar.tagTexts.putSync(newTag),
      );
      tagController.clear();
      _tagsNode.requestFocus();
      searchTags('');
      setState(() {});
    }
  }
}
