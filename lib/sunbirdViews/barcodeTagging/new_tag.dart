import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:hive/hive.dart';
import 'package:simple_tags/simple_tags.dart';

class NewTagView extends StatefulWidget {
  NewTagView({Key? key}) : super(key: key);

  @override
  _NewTagViewState createState() => _NewTagViewState();
}

class _NewTagViewState extends State<NewTagView> {
  int currentBarcodeID = 0;
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepSpaceSparkle,
        title: Text('New Tag'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: myController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    contentPadding: EdgeInsets.all(5),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.deepOrange,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.deepOrange,
                    )),
                    labelText: 'Enter New Tag',
                    labelStyle: TextStyle(color: Colors.deepOrangeAccent)),
                cursorColor: Colors.orangeAccent,
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
                Box<String> allTags = await Hive.openBox(tagsBoxName);
                allTags.put(myController.text, myController.text);
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
