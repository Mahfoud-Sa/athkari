import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.settings,
          color: Color.fromARGB(255, 117, 192, 192),
        ),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "اسعد الله صباحكم بالخيرات",
          ),
        ),
      ),
      body: Center(child: Text('Hellow word')),
    );
  }
}
