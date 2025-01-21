import 'package:flutter/material.dart';

Padding buildSearchBar(BuildContext context, Function(String) onSearch) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      onChanged: onSearch,
      onSubmitted: onSearch,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search), // Icon inside the border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none, // Remove the visible border
        ),

        hintText: '...بحث ',
        filled: true, // Enable background color
        fillColor: Colors.black12, // Set the background color
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 20), // Adjust padding
      ),
    ),
  );
}
