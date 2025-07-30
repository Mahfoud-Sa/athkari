import 'package:flutter/material.dart';

class DrawerTitleWidet extends StatelessWidget {
  const DrawerTitleWidet({
    required this.title,
    super.key,
  });
  
  final String title;
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 22),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}