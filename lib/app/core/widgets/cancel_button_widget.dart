import 'package:flutter/material.dart';

class CancelButtonWidget extends StatelessWidget {
  const CancelButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 128, 188, 189), width: 2),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            'الغاء',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
