import 'package:flutter/material.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class ContainerScreen extends ConsumerStatefulWidget {
  final CatalogedContainer _container;

  const ContainerScreen({
    required CatalogedContainer parent,
    super.key,
  }) : _container = parent;

  @override
  ConsumerState<ContainerScreen> createState() =>
      _CatalogedContainerScreenState();
}

class _CatalogedContainerScreenState extends ConsumerState<ContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
