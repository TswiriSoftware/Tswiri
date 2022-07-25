import 'package:sunbird_2/isar/isar_database.dart';

///Used to search containerEntries.
class ContainerSearchController {
  late List<CatalogedContainer> searchResults = [];

  late List<ContainerType> containerTypes =
      isar!.containerTypes.where().findAllSync();

  ///Filters container entries using [ContainerType] and enteredKeyWord [String].
  void filterContainerEntries({
    required String? enteredKeyWord,
    required List<String> containerFilters,
  }) {
    searchResults.clear();
    if (enteredKeyWord != null && enteredKeyWord.isNotEmpty) {
      searchResults.addAll(
        isar!.catalogedContainers
            .filter()
            .group(
              (q) => q.repeat(
                containerTypes,
                (q, ContainerType containerType) => q.optional(
                  containerFilters.contains(containerType.containerTypeName),
                  (q) => q.containerTypeIDEqualTo(containerType.id),
                ),
              ),
            )
            .and()
            .nameContains(enteredKeyWord, caseSensitive: false)
            .findAllSync(),
      );
    } else {
      for (var containerType in containerTypes) {
        if (containerFilters.contains(containerType.containerTypeName)) {
          searchResults.addAll(isar!.catalogedContainers
              .filter()
              .containerTypeIDEqualTo(containerType.id)
              .findAllSync());
        }
      }
    }
  }

  //Returns a list of container Search Types.
  List<String> filterTypes() {
    List<String> filterTypes =
        containerTypes.map((e) => e.containerTypeName).toList();

    return filterTypes;
  }
}
