import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

class TagManagerView extends StatefulWidget {
  const TagManagerView({Key? key}) : super(key: key);

  @override
  State<TagManagerView> createState() => _TagManagerViewState();
}

class _TagManagerViewState extends State<TagManagerView> {
  TextEditingController tagController = TextEditingController();
  List<Tag> tags = [];

  bool showFilter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Tags', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Text('hold to delete', style: Theme.of(context).textTheme.bodySmall),
          Builder(builder: (context) {
            tags = isarDatabase!.tags
                .filter()
                .tagContains(tagController.text)
                .findAllSync();

            return tagWrapView();
          }),
          tagTextField(),
        ],
      ),
    );
  }

  Widget tagWrapView() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Wrap(
            children: tags.map((e) => tagWidget(e)).toList(),
          ),
        ),
      ),
    );
  }

  Widget tagWidget(Tag tag) {
    return InkWell(
      onLongPress: (() {
        isarDatabase!.writeTxnSync(
          (isar) {
            isar.tags.deleteSync(tag.id);
            isar.containerTags.filter().tagIDEqualTo(tag.id).deleteAllSync();
          },
        );
        setState(() {});
      }),
      child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrange, width: 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              color: Colors.black26),
          child: Text(
            tag.tag,
            style: Theme.of(context).textTheme.bodyLarge,
          )),
    );
  }

  Widget tagTextField() {
    return OrangeOutlineContainer(
      margin: 5,
      padding: 8,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: tagController,
              onChanged: (value) {
                setState(() {});
              },
              style: const TextStyle(fontSize: 18),
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                labelText: 'Tag',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
          ),
          Builder(builder: (context) {
            return InkWell(
              onTap: () {
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
                  setState(() {});
                }
              },
              child: OrangeOutlineContainer(
                child: Text(
                  'Add',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
