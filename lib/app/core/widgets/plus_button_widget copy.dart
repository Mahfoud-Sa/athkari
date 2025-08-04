import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlusButtonWidget extends StatelessWidget {
    PlusButtonWidget({
    super.key,
    required this.onPressMethod
  });
 VoidCallback onPressMethod;
  @override
  Widget build(BuildContext context) {
    return IconButton(
              onPressed: onPressMethod,
              icon: SvgPicture.asset('assets/svgs/add_button.svg'),
              padding: EdgeInsets.zero, // Remove default padding
              constraints: const BoxConstraints(), // Remove default constraints
              alignment: Alignment.center, // Center vertically
            );
  }

  
}
