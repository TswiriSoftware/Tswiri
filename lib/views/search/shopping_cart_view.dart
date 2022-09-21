import 'package:tswiri/views/ml_kit/navigator/navigator_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/models/search/search_result_models.dart';
import 'package:tswiri_database/models/search/shopping_cart.dart';

class ShoppingCartView extends StatefulWidget {
  const ShoppingCartView({Key? key}) : super(key: key);

  @override
  State<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  @override
  void initState() {
    Provider.of<ShoppingCart>(context, listen: false).getBaskets();
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
          for (var item in Provider.of<ShoppingCart>(context).containerBaskets)
            ContainerBasketWidget(item: item),
        ],
      ),
    );
  }
}

class ContainerBasketWidget extends StatefulWidget {
  const ContainerBasketWidget({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ContainerBasket item;

  @override
  State<ContainerBasketWidget> createState() => _ContainerBasketWidgetState();
}

class _ContainerBasketWidgetState extends State<ContainerBasketWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.catalogedContainer.name ??
                      widget.item.catalogedContainer.containerUID,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                  onPressed: () async {
                    CatalogedContainer catalogedContainer = isar!
                        .catalogedContainers
                        .getSync(widget.item.catalogedContainer.id)!;
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

                    bool? hasRetrivedEverthing =
                        await _showEndDialog(widget.item.items);
                    if (mounted &&
                        hasRetrivedEverthing != null &&
                        hasRetrivedEverthing == true) {
                      Provider.of<ShoppingCart>(context, listen: false)
                          .removeItems(
                              widget.item.catalogedContainer.containerUID);
                    }
                  },
                  icon: const Icon(Icons.navigation_rounded),
                ),
              ],
            ),
            const Divider(),
            for (var item in widget.item.items)
              ResultStringWidget(result: item),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showEndDialog(List<Result> items) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Find everything ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for (Result result in items) ResultStringWidget(result: result),
                const Divider(),
                Text(
                  'WIP (checklist)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('no'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}

class ResultStringWidget extends StatelessWidget {
  const ResultStringWidget({Key? key, required this.result}) : super(key: key);
  final Result result;
  @override
  Widget build(BuildContext context) {
    switch (result.runtimeType) {
      case NameResult:
        return Text(
          (result as NameResult).name,
        );
      case DescriptionResult:
        return Text(
          'Description',
          style: Theme.of(context).textTheme.bodySmall,
        );
      case ContainerTagResult:
        return Text((result as ContainerTagResult).tag);
      case PhotoLabelResult:
        return Text((result as PhotoLabelResult).photoLabel);
      case ObjectLabelResult:
        return Text((result as ObjectLabelResult).objectLabel);
      case MLPhotoLabelResult:
        return Text((result as MLPhotoLabelResult).mlPhotoLabel);
      case MLObjectLabelResult:
        return Text((result as MLObjectLabelResult).mlObjectLabel);
      case MLTextResult:
        return Text((result as MLTextResult).mlText);
      default:
        return Text('error');
    }
  }
}
