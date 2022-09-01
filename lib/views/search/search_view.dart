import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/containers/container_view/container_view.dart';
import 'package:sunbird/views/search/search_controller/search_controller.dart';
import 'package:sunbird/views/search/search_controller/search_results.dart';
import 'package:sunbird/views/search/search_widgets/search_widgets.dart';
import 'package:sunbird/views/search/shopping_cart/shopping_cart.dart';
import 'package:sunbird/views/search/shopping_cart/shopping_cart_view.dart';
import 'package:sunbird_base/widgets/sunbird_search_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    Key? key,
    required this.isSearching,
  }) : super(key: key);
  final void Function(bool) isSearching;

  @override
  State<SearchView> createState() => _SearchViewState();
}

///Search Filters.
List<String> searchFilters = [
  'Tags',
  'ML Labels',
  'Photo Labels',
  'Object Labels',
  'Name',
  'Description',
  'ML Text',
];

class _SearchViewState extends State<SearchView> {
  final SearchController _searchController =
      SearchController(filters: searchFilters);

  Map<String, String> filterTypes = {
    'Tags': 'Search by container tags',
    'ML Labels': 'Search by photo labels',
    'Photo Labels': 'Search by User Photo Labels',
    'Object Labels': 'Search by User Object Labels',
    'Name': 'Search by container Name',
    'Description': 'Search by container Description',
    'ML Text': 'Search by detected text',
  };

  bool isSearching = false;
  // bool shoppingCartEmpty = shoppingList.isEmpty;

  @override
  void initState() {
    _searchController.search();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching ? _searchBar() : _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Search',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ShoppingCartView(),
            ),
          );
        },
        icon: Provider.of<ShoppingCart>(context).shoppingList.isNotEmpty
            ? const Icon(Icons.shopping_cart_checkout_sharp)
            : const Icon(Icons.shopping_cart),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = true;
              widget.isSearching(isSearching);
            });
          },
          icon: const Icon(
            Icons.search_sharp,
          ),
        ),
      ],
    );
  }

  PreferredSize _searchBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 50),
      child: SearchBar(
        filters: searchFilters,
        filterTypes: filterTypes.entries.map((e) => e.key).toList(),
        onFilterChange: (enteredKeyWord) {
          setState(() {
            _searchController.search(enteredKeyword: enteredKeyWord);
          });
        },
        onCancel: () {
          setState(() {
            isSearching = false;
            widget.isSearching(isSearching);
            _searchController.search();
          });
        },
        onChanged: (value) {
          setState(() {
            _searchController.search(enteredKeyword: value);
          });
        },
        onSubmitted: (value) {
          setState(() {
            _searchController.search(enteredKeyword: value);
          });
        },
      ),
    );
  }

  Widget _body() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
      ),
      itemCount: _searchController.searchResults.length,
      itemBuilder: (context, index) {
        return _searchResultCard(_searchController.searchResults[index]);
      },
    );
  }

  Widget _searchResultCard(Result result) {
    CatalogedContainer catalogedContainer = isar!.catalogedContainers
        .filter()
        .containerUIDMatches(result.containerUID)
        .findFirstSync()!;

    return InkWell(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ContainerView(
              catalogedContainer: catalogedContainer,
              tagsExpanded: true,
              photosExpaned: true,
            ),
          ),
        );
        // setState(() {
        //   shoppingCartEmpty = shoppingList.isEmpty;
        // });
      },
      child: Builder(builder: (context) {
        switch (result.runtimeType) {
          case NameResult: //Name Result.
            return NameResultCard(nameResult: result as NameResult);

          case DescriptionResult: //Description Result.
            return DescriptionResultCard(
                descriptionResult: result as DescriptionResult);

          case ContainerTagResult: //ContainerTag Result.

            return ContainerTagResultCard(
                containerTagResult: result as ContainerTagResult);

          case PhotoLabelResult:
            return PhotoLabelResultCard(
                photoLabelResult: result as PhotoLabelResult);

          case ObjectLabelResult:
            return ObjectLabelResultCard(result: result as ObjectLabelResult);

          case MLPhotoLabelResult:
            return MLPhotoLabelResultCard(
                mlphotoLabelResult: result as MLPhotoLabelResult);

          case MLObjectLabelResult:
            return MLObjectLabelResultCard(
                result: result as MLObjectLabelResult);

          case MLTextResult:
            return MLTextElementResultCard(result: result as MLTextResult);

          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
