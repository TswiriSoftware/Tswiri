import 'package:flutter/material.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class ContainerScreen extends ConsumerStatefulWidget {
  final CatalogedContainer _container;

  const ContainerScreen({
    required CatalogedContainer container,
    super.key,
  }) : _container = container;

  @override
  AbstractScreen<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends AbstractScreen<ContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
