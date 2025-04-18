import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    fontFamily: "IBMPlexSansArabic",
    primaryColor: Color.fromARGB(255, 128, 188, 189),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 38,
        color: Color.fromARGB(255, 157, 199, 168),
      ),
      titleSmall: TextStyle(fontSize: 12, color: Colors.black45),
      titleMedium: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 157, 199, 168),
      ),
      bodyMedium: TextStyle(
        fontSize: 24,
        color: Color.fromARGB(255, 157, 199, 168),
      ),
    ));
