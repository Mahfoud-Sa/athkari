import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MinusButtonWidget extends StatelessWidget {
  const MinusButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
              onPressed: () {
                // If popMethod is null, call Navigator.pop(context)
               // (popMethod ?? () => Navigator.pop(context))();
              },
              icon: SvgPicture.asset('assets/svgs/minus_button.svg'),
              padding: EdgeInsets.zero, // Remove default padding
              constraints: const BoxConstraints(), // Remove default constraints
              alignment: Alignment.center, // Center vertically
            );
  }
}
