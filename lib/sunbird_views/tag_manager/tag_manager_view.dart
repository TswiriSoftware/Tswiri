import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:isar/isar.dart';

class TagManagerView extends StatefulWidget {
  const TagManagerView({Key? key}) : super(key: key);

  @override
  State<TagManagerView> createState() => _TagManagerViewState();
}

class _TagManagerViewState extends State<TagManagerView> {
  TextEditingController tagController = TextEditingController();
  List<Tag> tags = [];
  final _tagsNode = FocusNode();

  bool showFilter = false;

  @override
  void initState() {
    _tagsNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Tags', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        elevation: 0,
      ),
      body: tagWrapView(),
      bottomSheet: _bottomSheet(),
    );
  }

  Widget tagWrapView() {
    return Builder(builder: (context) {
      tags = isarDatabase!.tags
          .filter()
          .tagContains(tagController.text)
          .findAllSync();
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
              children: tags.map((e) => tagChip(e)).toList(),
            ),
          ),
        ),
      );
    });
  }

  Widget tagChip(Tag tag) {
    return ActionChip(
      onPressed: () {
        isarDatabase!.writeTxnSync(
          (isar) {
            isar.tags.deleteSync(tag.id);
            isar.containerTags.filter().tagIDEqualTo(tag.id).deleteAllSync();
          },
        );
        setState(() {});
      },
      backgroundColor: sunbirdOrange,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag.tag,
          ),
          const Icon(
            Icons.delete,
            size: 15,
          )
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: tagController,
          focusNode: _tagsNode,
          onChanged: (value) {
            setState(() {});
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
        ),
      ],
    );
  }

  void addTag() {
    Tag? exists = isarDatabase!.tags
        .filter()
        .tagMatches(tagController.text.trim(), caseSensitive: false)
        .findFirstSync();

    String inputValue = tagController.text;

    if (exists == null && inputValue.isNotEmpty) {
      //Remove white spaces
      inputValue.trim();

      Tag newTag = Tag()..tag = inputValue;
      isarDatabase!.writeTxnSync(
        (isar) => isar.tags.putSync(newTag),
      );
      tagController.text = '';
      _tagsNode.requestFocus();
      setState(() {});
    }
  }
}
