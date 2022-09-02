import 'package:flutter/material.dart';

class NavigatorCard extends StatelessWidget {
  ///Default Navigator Card.
  ///
  /// - ```label```     =  Displayed Text.
  /// - ```icon```      =  Displayed Icon.
  /// - ```viewPage```  => Page to Navigate too.
  const NavigatorCard({
    Key? key,
    required this.label,
    required this.icon,
    required this.viewPage,
  }) : super(key: key);

  final String label;
  final Widget viewPage;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => viewPage));
      },
    );
  }
}
