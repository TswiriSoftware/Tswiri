import 'package:flutter/widgets.dart';
import 'package:sunbird/isar/isar_database.dart';

class ShoppingCart extends ChangeNotifier {
  ///The list of selected items.
  final List<ShoppingCartItem> shoppingList = [];

  void modifyShoppingCart(ShoppingCartItem item) {
    if (shoppingList.any((element) =>
        element.catalogedContainer.containerUID ==
        item.catalogedContainer.containerUID)) {
      //Remove item.
      shoppingList.removeWhere((element) =>
          element.catalogedContainer.containerUID ==
          item.catalogedContainer.containerUID);
    } else {
      //add item.
      shoppingList.add(item);
    }
    notifyListeners();
  }

  void modifyShoppingCartContainerUID(String containerUID, String item) {
    if (shoppingList.any(
        (element) => element.catalogedContainer.containerUID == containerUID)) {
      //Remove item.
      shoppingList.removeWhere(
          (element) => element.catalogedContainer.containerUID == containerUID);
    } else {
      //add item.
      shoppingList.add(
        ShoppingCartItem(
            catalogedContainer: isar!.catalogedContainers
                .filter()
                .containerUIDMatches(containerUID)
                .findFirstSync()!,
            selectedItem: item),
      );
    }
    notifyListeners();
  }

  bool exists(ShoppingCartItem item) {
    if (shoppingList.any((element) =>
        element.catalogedContainer.containerUID ==
        item.catalogedContainer.containerUID)) {
      return true;
    }
    return false;
  }

  bool isInShoppingCart(String containerUID) {
    if (shoppingList.any(
        (element) => element.catalogedContainer.containerUID == containerUID)) {
      return true;
    }

    return false;
  }
}

class ShoppingCartItem {
  ShoppingCartItem({
    required this.catalogedContainer,
    required this.selectedItem,
  });

  ///The Cataloged Container.
  CatalogedContainer catalogedContainer;

  ///Posibly add the photo/text of the selected item...

  String? selectedItem;
}
