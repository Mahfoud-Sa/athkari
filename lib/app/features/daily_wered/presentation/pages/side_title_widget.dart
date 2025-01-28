import 'package:flutter/material.dart';

class SideTitle extends StatelessWidget {
  const SideTitle({
    super.key,
    required this.count,
    required this.title,
  });
  final int count;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
          alignment: Alignment.centerRight, child: Text("${title} : ${count}")),
    );
  }
}
