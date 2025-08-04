import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MinusButtonWidget extends StatelessWidget {
   MinusButtonWidget({
    super.key,
  required this.onPressMethod
  });
 VoidCallback onPressMethod;
  @override
  Widget build(BuildContext context) {
    return IconButton(
              onPressed: onPressMethod,
              icon: SvgPicture.asset('assets/svgs/minus_button.svg'),
              padding: EdgeInsets.zero, // Remove default padding
              constraints: const BoxConstraints(), // Remove default constraints
              alignment: Alignment.center, // Center vertically
            );
  }
}
