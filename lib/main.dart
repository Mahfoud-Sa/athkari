import 'package:flutter/material.dart';
import 'app/features/on_bording/presentation/pages/on_bording.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athkari',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: "IBMPlexSansArabic"),
      home: Onbording(),
    );
  }
}
