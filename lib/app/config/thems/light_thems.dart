import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    fontFamily: "IBMPlexSansArabic",
    primaryColor: Colors.lightBlue[800],
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 38,
        color: Color.fromARGB(255, 157, 199, 168),
      ),
      titleSmall: TextStyle(fontSize: 16, color: Colors.black45),
    ));
