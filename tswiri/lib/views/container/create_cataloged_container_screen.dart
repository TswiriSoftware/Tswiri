import 'package:flutter/material.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class CreateCatalogedContainerScreen extends ConsumerStatefulWidget {
  final CatalogedContainer _parentContainer;

  const CreateCatalogedContainerScreen({
    required CatalogedContainer parentContainer,
    super.key,
  }) : _parentContainer = parentContainer;

  @override
  ConsumerState<CreateCatalogedContainerScreen> createState() => _CreateCatalogedContainerScreenState();
}

class _CreateCatalogedContainerScreenState extends ConsumerState<CreateCatalogedContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
