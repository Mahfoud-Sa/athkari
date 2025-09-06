import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
// import 'package:fluttertoast/fluttertoast.dart';

void errorToastMessage(BuildContext context, String message) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  
  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Container(
        height: 100,
        alignment: Alignment.center,
        child: Container(
          width: 322,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
           border: GradientBoxBorder(
          width: 1,
          gradient: LinearGradient(colors: [
            const Color(0xffcc3a3a),
            Color.fromARGB(255, 178, 231, 93),
          ]),
        ),
            color: Colors.white.withOpacity(0.7), // Adjust transparency here
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    color:const Color(0xffcc3a3a),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  "assets/svgs/error_icon.svg",
                  width: 28, // Slightly smaller icon for better proportion
                  height: 28,
                 
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.4,
      ),
      padding: EdgeInsets.zero,
    ),
  );
}