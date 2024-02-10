import 'package:flutter/material.dart';

class NavigationCard extends StatelessWidget {
  const NavigationCard({
    super.key,
    required this.label,
    required this.target,
    required this.icon,
  });

  final String label;
  final String target;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(target);
        },
        child: Column(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 56,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
