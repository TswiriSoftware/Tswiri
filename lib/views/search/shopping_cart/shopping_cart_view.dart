import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/ml_kit_views/navigator/navigator_view.dart';
import 'package:sunbird/views/search/shopping_cart/shopping_cart.dart';

class ShoppingCartView extends StatefulWidget {
  const ShoppingCartView({Key? key}) : super(key: key);

  @override
  State<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Shopping Cart',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var item in Provider.of<ShoppingCart>(context).shoppingList)
            ShoppingCartItemWidget(item: item),
        ],
      ),
    );
  }
}

class ShoppingCartItemWidget extends StatelessWidget {
  const ShoppingCartItemWidget({Key? key, required this.item})
      : super(key: key);
  final ShoppingCartItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.shopping_cart_checkout_sharp),
        title: Text(item.catalogedContainer.name ??
            item.catalogedContainer.containerUID),
        subtitle: Text(item.selectedItem.toString()),
        trailing: IconButton(
          onPressed: () async {
            CatalogedContainer catalogedContainer =
                isar!.catalogedContainers.getSync(item.catalogedContainer.id)!;
            CatalogedCoordinate? catalogedCoordiante = isar!
                .catalogedCoordinates
                .filter()
                .barcodeUIDMatches(catalogedContainer.barcodeUID!)
                .findFirstSync();

            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavigatorView(
                    catalogedContainer: catalogedContainer,
                    gridUID: catalogedCoordiante!.gridUID),
              ),
            );

            Provider.of<ShoppingCart>(context, listen: false)
                .modifyShoppingCart(item);
          },
          icon: const Icon(Icons.navigation_rounded),
        ),
      ),
    );
  }
}
