import 'package:flutter/material.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class CatalogedContainerScreen extends ConsumerStatefulWidget {
  final CatalogedContainer _container;

  const CatalogedContainerScreen({
    required CatalogedContainer container,
    super.key,
  }) : _container = container;

  @override
  ConsumerState<CatalogedContainerScreen> createState() => _CatalogedContainerScreenState();
}

class _CatalogedContainerScreenState extends ConsumerState<CatalogedContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
