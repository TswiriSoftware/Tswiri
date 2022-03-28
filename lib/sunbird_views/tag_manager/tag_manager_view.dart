import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/barcodeTools/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tag_manager/new_tag_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:isar/isar.dart';

class TagManagerView extends StatefulWidget {
  const TagManagerView({Key? key}) : super(key: key);

  @override
  State<TagManagerView> createState() => _TagManagerViewState();
}

class _TagManagerViewState extends State<TagManagerView> {
  String enteredKeyword = '';
  bool showFilter = false;
  bool addTag = false;
  List<Tag> allTags = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewTagView()),
          );
          setState(() {});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title:
            Text('Tag Manager', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _searchBar(),
            Builder(builder: (context) {
              allTags = isarDatabase!.tags
                  .filter()
                  .tagContains(enteredKeyword, caseSensitive: false)
                  .findAllSync();

              return Column(
                children: [],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget tagTile() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: DarkContainer(
        margin: 2.5,
        padding: 5,
        child: Text('data'),
      ),
    );
  }

  Widget _searchBar() {
    return CustomOutlineContainer(
      outlineColor: Colors.deepOrange,
      backgroundColor: Colors.black12,
      borderWidth: 1,
      margin: 0,
      padding: 5,
      child: Builder(
        builder: ((context) {
          if (showFilter) {
            return searchFilter();
          } else {
            return searchInput();
          }
        }),
      ),
    );
  }

  Widget searchFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Filter: ',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showFilter = !showFilter;
                      setState(() {});
                    },
                    icon: const Icon(Icons.filter_alt_outlined),
                  ),
                ],
              ),
              //TODO: implement filters for tags @049er
            ],
          ),
        ),
      ],
    );
  }

  Widget searchInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(fontSize: 18),
            onEditingComplete: (() => hideKeyboard(context)),
            onChanged: (value) {
              enteredKeyword = value;
              setState(() {});
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              icon: Icon(Icons.search),
              labelText: 'Search/New Tag',
              labelStyle: TextStyle(fontSize: 18),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            showFilter = !showFilter;
            setState(() {});
          },
          icon: const Icon(Icons.filter_alt_outlined),
        ),
      ],
    );
  }
}
