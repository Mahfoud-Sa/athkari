import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onTap; // Custom onTap (optional)
  const ErrorStateWidget({
    super.key,
    required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(message.toString()),
      ),
    );
  }
}
