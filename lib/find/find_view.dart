import 'package:flutter/material.dart';
import 'package:tswiri_theme/widgets/cards/filled_card.dart';
import 'package:tswiri_theme/widgets/cards/text_field_card.dart';

class FindView extends StatefulWidget {
  const FindView({
    super.key,
  });

  @override
  State<FindView> createState() => _FindViewState();
}

class _FindViewState extends State<FindView> {
  bool isSearching = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _sliverAppBar(),
        _sliverGrid(),
      ],
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      floating: false,
      pinned: true,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFieldCard(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      focusNode: focusNode,
                      onTap: () {},
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverGrid _sliverGrid() {
    return SliverGrid.count(
      crossAxisCount: 2,
      children: [
        for (var i = 0; i < 25; i++)
          const FilledCard(
            child: Center(
              child: Text('data'),
            ),
          ),
      ],
    );
  }
}

// GridView.count(
//     crossAxisCount: 2,
//     children: [
// for (var i = 0; i < 25; i++)
//   FilledCard(
//     child: Text('data'),
//   ),
//     ],
//   );
