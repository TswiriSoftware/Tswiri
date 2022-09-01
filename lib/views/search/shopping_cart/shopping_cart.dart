import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/search/search_controller/search_results.dart';

class ShoppingCart extends ChangeNotifier {
  ///The list of selected items.
  final List<Result> itemList = [];
  List<ContainerBasket> containerBaskets = [];

  void addItem(Result item) {
    if (!itemList.any((element) => element.uid == item.uid)) {
      itemList.add(item);
    }
    containerBaskets = getBaskets();
    notifyListeners();
  }

  void removeItem(Result item) {
    if (itemList.any((element) => element.uid == item.uid)) {
      itemList.removeWhere((element) => element.uid == item.uid);
    }
    containerBaskets = getBaskets();
    notifyListeners();
  }

  void removeItems(String containerUID) {
    itemList.removeWhere((element) => element.containerUID == containerUID);
    containerBaskets.removeWhere(
        (element) => element.catalogedContainer.containerUID == containerUID);
    notifyListeners();
  }

  bool isInShoppingCart(Result item) {
    if (itemList.contains(item)) {
      return true;
    }
    return false;
  }

  List<ContainerBasket> getBaskets() {
    Set<String> containers = itemList.map((e) => e.containerUID).toSet();
    log(containers.toString());

    return containers
        .map(
          (e) => ContainerBasket(
            catalogedContainer: isar!.catalogedContainers
                .filter()
                .containerUIDMatches(e)
                .findFirstSync()!,
            items:
                itemList.where((element) => element.containerUID == e).toList(),
          ),
        )
        .toList();
  }
}

class ContainerBasket {
  ContainerBasket({
    required this.catalogedContainer,
    required this.items,
  });
  CatalogedContainer catalogedContainer;
  List<Result> items;
}
