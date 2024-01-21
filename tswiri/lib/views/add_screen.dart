import 'package:flutter/material.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/views/abstract_page.dart';

class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends AbstractScreen<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
      ),
    );
  }
}
