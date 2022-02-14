import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:provider/provider.dart';

class BarcodeControlPanelView extends StatefulWidget {
  final BarcodeAndTagData barcodeAndTagData;
  const BarcodeControlPanelView({Key? key, required this.barcodeAndTagData})
      : super(key: key);

  @override
  State<BarcodeControlPanelView> createState() =>
      _BarcodeControlPanelViewState();
}

class _BarcodeControlPanelViewState extends State<BarcodeControlPanelView> {
  List<String> assignedTags = [];
  List<String> unassignedTags = [];

  @override
  void initState() {
    assignedTags = widget.barcodeAndTagData.tags ?? [];
    // ChangeNotifierProvider(
    //   create: (_) => Tags(['assignedTags']),
    //   child: AssignedTagsContainer(),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepSpaceSparkle,
        title: const Text(
          'Barcode',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: Column(
        children: [
          barcodeDataContainer(widget.barcodeAndTagData),
          ChangeNotifierProvider(
            create: (_) => Tags(assignedTags),
            child: AssignedTagsContainer(assignedTags: assignedTags),
          )

          // AssignedTagsContainer(
          //   assignedTags: assignedTags,
          // ),
        ],
      ),
    );
  }
}

class TagButton extends StatelessWidget {
  final String tag;
  const TagButton(
    this.tag, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Provider.of<Tags>(context, listen: false).deleteTag(tag);
          print('delete');
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

class Tags extends ChangeNotifier {
  Tags(this.tags);
  List<String> tags;

  void deleteTag(String tag) {
    tags.remove(tag);
    notifyListeners();
  }
}

class AssignedTagsContainer extends StatelessWidget {
  AssignedTagsContainer({Key? key, required this.assignedTags})
      : super(key: key);
  List<String> assignedTags;

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
          Wrap(
              children: Provider.of<Tags>(context)
                  .tags
                  .map((e) => TagButton(e))
                  .toList()
              // children: assignedTags.map((e) => TagButton(e)).toList(),
              ),
        ],
      ),
    );
  }
}

Container barcodeDataContainer(BarcodeAndTagData barcodeAndTagData) {
  return Container(
    width: double.infinity,
    height: 100,
    margin: const EdgeInsets.only(bottom: 5, top: 5),
    decoration: BoxDecoration(
      color: deepSpaceSparkle[200],
      border: Border.all(color: Colors.white60, width: 2),
      borderRadius: const BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5, left: 10),
          child: Text(
            'Barcode Data',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 10),
          child: Text('Barcode ID:  ' + barcodeAndTagData.barcodeID.toString()),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 10),
          child: Text(
              'Barcode Size:  ' + barcodeAndTagData.barcodeSize.toString()),
        )
      ],
    ),
  );
}
