import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlusButtonWidget extends StatelessWidget {
  const PlusButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
              onPressed: () {
                // If popMethod is null, call Navigator.pop(context)
               // (popMethod ?? () => Navigator.pop(context))();
              },
              icon: SvgPicture.asset('assets/svgs/add_button.svg'),
              padding: EdgeInsets.zero, // Remove default padding
              constraints: const BoxConstraints(), // Remove default constraints
              alignment: Alignment.center, // Center vertically
            );
  }
}
