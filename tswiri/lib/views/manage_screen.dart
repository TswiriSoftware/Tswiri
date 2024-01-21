import 'package:flutter/material.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/routes.dart';
import 'package:tswiri/views/abstract_page.dart';
import 'package:tswiri/widgets/navigation_card.dart';

class ManageScreen extends ConsumerStatefulWidget {
  const ManageScreen({super.key});

  @override
  ConsumerState<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends AbstractScreen<ManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
        children: const [
          NavigationCard(
            label: 'QR Codes',
            target: Routes.qrCodes,
            icon: Icons.qr_code,
          ),
        ],
      ),
    );
  }
}
