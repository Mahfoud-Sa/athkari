import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnbordingPage extends StatelessWidget {
  const OnbordingPage(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.description});
  final String imagePath;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Image.asset(
            imagePath,
            // width: 120,
          ),
        ),
        Text(title,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.titleLarge),
        Text(
            textAlign: TextAlign.end,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.black45),
            description),
      ],
    );
  }
}
