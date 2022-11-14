import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tswiri/find/filter_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';

import 'package:tswiri_database_interface/models/find/find.dart';
import 'package:tswiri_database_interface/models/find/find_result_models.dart';

import 'package:tswiri_database_interface/widgets/search/find_widgets.dart';

import '../utilities/containers/container_view.dart';

class FindView extends StatefulWidget {
  const FindView({
    super.key,
  });

  @override
  State<FindView> createState() => _FindViewState();
}

class _FindViewState extends State<FindView> {
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  final TextEditingController _findController = TextEditingController();
  // late _findController.text

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (Provider.of<Find>(context).searchResults.isEmpty) {
    //     Provider.of<Find>(context, listen: false).search();
    //   }

    // });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _sliverAppBar(),
        _sliverGrid(),
      ],
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      title: TextField(
        focusNode: focusNode,
        controller: _findController,
        onChanged: (value) {
          Provider.of<Find>(context, listen: false)
              .search(enteredKeyword: value);
        },
        onSubmitted: (value) {
          Provider.of<Find>(context, listen: false)
              .search(enteredKeyword: value);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          fillColor: Colors.transparent,
          suffixIcon: _findController.text.isEmpty
              ? const Icon(Icons.search_rounded)
              : IconButton(
                  onPressed: _findController.clear,
                  icon: const Icon(Icons.close_rounded),
                ),
          prefixIcon: OpenContainer(
            openColor: Colors.transparent,
            closedColor: Colors.transparent,
            closedBuilder: (context, action) {
              return IconButton(
                onPressed: action,
                icon: const Icon(Icons.menu_rounded),
              );
            },
            openBuilder: (context, action) {
              return const FilterView();
            },
          ),
          hintText: 'Search',
        ),
      ),
    );
  }

  SliverGrid _sliverGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0,
        // mainAxisSpacing: 10.0,
        // crossAxisSpacing: 10.0,
        childAspectRatio: 1,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return _searchResult(Provider.of<Find>(context).searchResults[index]);
        },
        childCount: Provider.of<Find>(context).searchResults.length,
      ),
    );
  }

  Widget _searchResult(Result result) {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      closedBuilder: (context, action) {
        return Builder(builder: (context) {
          switch (result.runtimeType) {
            case NameResult: //Name Result.
              return NameResultCard(
                nameResult: result as NameResult,
              );

            case DescriptionResult: //Description Result.
              return DescriptionResultCard(
                descriptionResult: result as DescriptionResult,
              );

            case ContainerTagResult: //ContainerTag Result.

              return ContainerTagResultCard(
                containerTagResult: result as ContainerTagResult,
              );

            case PhotoLabelResult:
              return PhotoLabelResultCard(
                photoLabelResult: result as PhotoLabelResult,
              );

            case ObjectLabelResult:
              return ObjectLabelResultCard(
                result: result as ObjectLabelResult,
              );

            case MLPhotoLabelResult:
              return MLPhotoLabelResultCard(
                mlphotoLabelResult: result as MLPhotoLabelResult,
              );

            case MLObjectLabelResult:
              return MLObjectLabelResultCard(
                result: result as MLObjectLabelResult,
              );

            case MLTextResult:
              return MLTextElementResultCard(
                result: result as MLTextResult,
              );

            default:
              return const SizedBox.shrink();
          }
        });
      },
      openBuilder: (context, action) {
        return ContainerView(
            catalogedContainer:
                getCatalogedContainerSync(containerUID: result.containerUID)!
            // isar!.catalogedContainers
            //     .filter()
            //     .containerUIDMatches(result.containerUID)
            //     .findFirstSync()!,
            );
      },
    );
  }
}
