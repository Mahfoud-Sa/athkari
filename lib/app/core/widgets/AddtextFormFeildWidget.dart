import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({super.key, required this.value});
  final TextEditingController value;

  @override
  Widget build(BuildContext context) {
    //var textEditingController_12 = textEditingController_1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'لايمكن اضافة تصنيف فارغ';
          }
          if (value.length > 30) {
            return 'لا يجب ان يحتوي اسم تصنيف على اكثر من 20 حرف';
          }
          return null;
        },
        controller: value,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none, // Remove the visible border
          ),
          hintText: '...ادخل الاسم هنا',
          filled: true, // Enable background color
          fillColor:
              Color.fromARGB(255, 221, 221, 220), // Set the background color
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 20), // Adjust padding
        ),
      ),
    );
  }
}
