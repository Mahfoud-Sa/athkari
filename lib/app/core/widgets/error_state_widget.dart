import 'package:athkari/app/features/categories/presentation/cubit/category_cubit_state.dart';
import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final ErrorCategoryState state;
  final VoidCallback? onTap; // Custom onTap (optional)
  const ErrorStateWidget({
    super.key,
    required this.state,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(state.message.toString()),
      ),
    );
  }
}
