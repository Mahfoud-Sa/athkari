import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({
    super.key,
    required this.onTap,
  });
  final GestureCancelCallback onTap;
  @override
  Widget build(BuildContext context) {
    var inkWell = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 128, 188, 189),
            borderRadius: BorderRadius.circular(30)),
        child: const Center(
          child: Text(
            'حذف',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
    return inkWell;
  }
}
