import 'package:flutter/material.dart';
import 'package:sunbird_v2/globals/globals_export.dart';

///Used to add a photo
class NewPhotoCard extends StatelessWidget {
  const NewPhotoCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: sunbirdOrange,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '+',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '(add photo)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
