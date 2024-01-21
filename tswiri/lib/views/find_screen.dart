import 'package:flutter/material.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/views/abstract_page.dart';

class FindScreen extends ConsumerStatefulWidget {
  const FindScreen({super.key});

  @override
  ConsumerState<FindScreen> createState() => _FindScreenState();
}

class _FindScreenState extends AbstractScreen<FindScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find'),
      ),
    );
  }
}
