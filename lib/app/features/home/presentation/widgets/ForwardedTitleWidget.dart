import 'package:flutter/material.dart';

class ForwardedTitleWidget extends StatelessWidget {
  ForwardedTitleWidget({
    required this.title,
    super.key,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 157, 199, 168),
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18),
          )
        ],
      ),
    );
  }
}
