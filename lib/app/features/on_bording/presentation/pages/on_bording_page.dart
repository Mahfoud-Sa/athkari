import 'package:flutter/material.dart';

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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(imagePath),
        Text(
          title,
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 38,
            color: Color.fromARGB(255, 157, 199, 168),
          ),
        ),
        Text(
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 16, color: Colors.black45),
            description),
      ],
    );
  }
}
