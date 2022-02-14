import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:hive/hive.dart';

class NewTagView extends StatefulWidget {
  const NewTagView({Key? key}) : super(key: key);

  @override
  _NewTagViewState createState() => _NewTagViewState();
}

class _NewTagViewState extends State<NewTagView> {
  List<String> allTags = [];
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void initState() {
    runFilter('');
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, 'Passed Value');

        /// It's important that returned value (boolean) is false,
        /// otherwise, it will pop the navigator stack twice;
        /// since Navigator.pop is already called above ^
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: deepSpaceSparkle,
          title: const Text('New Tag'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            unAssignedTags(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  onChanged: (value) => runFilter(value),
                  controller: myController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      contentPadding: EdgeInsets.all(5),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: deepSpaceSparkle,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: deepSpaceSparkle,
                      )),
                      labelText: 'Enter New Tag',
                      labelStyle: TextStyle(color: Colors.white)),
                  cursorColor: Colors.white,
                  keyboardAppearance: Brightness.dark,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: deepSpaceSparkle,
                border: Border.all(color: Colors.white60, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  Box allTags = await Hive.openBox(tagsBoxName);
                  allTags.put(myController.text, myController.text);

                  setState(() {
                    runFilter('');
                  });
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  unAssignedTags() {
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
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: TextField(
              onChanged: (value) => runFilter(value),
              controller: myController,
              scrollPadding: const EdgeInsets.only(bottom: 40),
              decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: deepSpaceSparkle)),
                  hoverColor: deepSpaceSparkle[200],
                  focusColor: deepSpaceSparkle[200],
                  contentPadding: const EdgeInsets.all(10),
                  labelStyle: const TextStyle(color: Colors.white),
                  labelText: 'Search Tags',
                  suffixIcon: Icon(
                    Icons.search,
                    color: deepSpaceSparkle[700],
                  )),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Container(
            padding: const EdgeInsets.all(3),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Wrap(
                children: allTags
                    .map((tag) => tagContainerUnAssignedTags(tag))
                    .toList(),
                // barcodeAndTagData.tags!.map((e) => tagContainer(e)).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> runFilter(String enteredKeyword) async {
    Box tagsBox = await Hive.openBox(tagsBoxName);

    Box<BarcodeTagEntry> currentTagsBox =
        await Hive.openBox(barcodeTagsBoxName);

    List<BarcodeTagEntry> barcodesAssignedTags = currentTagsBox.values.toList();

    List<String> assignedTags = [];
    for (BarcodeTagEntry barcodeTag in barcodesAssignedTags) {
      assignedTags.add(barcodeTag.tag);
    }

    //List of all barcodes and assigned Tags.
    List tagEntries = tagsBox.values.toList();
    //The DisplayList.
    List<String> results = [];

    for (String tagEntry in tagEntries) {
      if (!assignedTags.contains(tagEntry)) {
        results.add(tagEntry);
      }
    }

    if (enteredKeyword.isNotEmpty) {
      results = results
          .where((element) =>
              element.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      allTags = results;
    });
  }

  InkWell tagContainerUnAssignedTags(String tag) {
    return InkWell(
      onTap: () async {
        Box tagsBox = await Hive.openBox(tagsBoxName);
        tagsBox.delete(tag);

        setState(() {
          runFilter('');
        });
      },
      child: UnconstrainedBox(
        child: Container(
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.only(left: 10, right: 10),
          height: 35,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Center(
            child: Text(
              tag,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
