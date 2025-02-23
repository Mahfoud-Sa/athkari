import 'package:flutter/material.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({
    super.key,
    required this.formKey,
    required this.esnadValue,
    this.onTap,
    this.buttonText = 'اضافة', // Default text
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController esnadValue;
  final VoidCallback? onTap; // Custom onTap (optional)
  final String buttonText; // Customizable button text

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 128, 188, 189),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            buttonText, // Use the provided button text
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
