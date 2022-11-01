import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenNavigationTile extends StatefulWidget {
  const OpenNavigationTile(
      {super.key,
      required this.title,
      required this.iconData,
      required this.destination,
      this.animationDuration});
  final String title;
  final IconData iconData;
  final Widget destination;
  final Duration? animationDuration;
  @override
  State<OpenNavigationTile> createState() => _OpenNavigationTileState();
}

class _OpenNavigationTileState extends State<OpenNavigationTile> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      transitionDuration:
          widget.animationDuration ?? const Duration(milliseconds: 300),
      closedBuilder: (context, action) {
        return Card(
          elevation: 5,
          child: TextButton(
            onPressed: action,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraint) {
                      return Icon(
                        widget.iconData,
                        size: constraint.maxWidth / 3,
                        color: Theme.of(context).colorScheme.onBackground,
                      );
                    },
                  ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      openBuilder: (context, _) => widget.destination,
    );
  }
}
