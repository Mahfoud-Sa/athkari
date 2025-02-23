import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class CustomeContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  const CustomeContainer({super.key, this.child, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        border: GradientBoxBorder(
          width: 1,
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 90, 202, 165),
            Color.fromARGB(255, 178, 231, 93),
          ]),
        ),
      ),
      child: child,
    );
  }
}
