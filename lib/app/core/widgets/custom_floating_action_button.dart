import 'package:flutter/material.dart';

FloatingActionButton buildFloatingActionMethod(
    BuildContext context, Function onPress) {
  return FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 128, 188, 189),
      child: Center(
        child: Icon(
          Icons.add,
        ),
      ),
      onPressed: onPress());
}
