import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenListTile extends StatefulWidget {
  const OpenListTile({
    super.key,
    required this.title,
    required this.trailingIconData,
    this.leadingIconData,
    required this.destination,
    this.animationDuration,
  });
  final String title;
  final IconData trailingIconData;
  final IconData? leadingIconData;
  final Widget destination;
  final Duration? animationDuration;

  @override
  State<OpenListTile> createState() => _OpenListTileState();
}

class _OpenListTileState extends State<OpenListTile> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      transitionDuration:
          widget.animationDuration ?? const Duration(milliseconds: 300),
      closedBuilder: (context, action) => Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            title: Text(widget.title),
            trailing: Icon(widget.trailingIconData),
            leading: widget.leadingIconData == null
                ? null
                : Icon(widget.leadingIconData),
          ),
        ),
      ),
      openBuilder: (context, action) => widget.destination,
    );
  }
}
