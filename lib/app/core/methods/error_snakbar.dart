import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void errorToastMessage(BuildContext context, String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,  // Slightly longer duration for errors
    backgroundColor: Colors.red[700],  // Darker red for better visibility
    textColor: Colors.white,
    fontSize: 16.0,
    webShowClose: true,  // Add close button for web
    webBgColor: "linear-gradient(to right, #d32f2f, #b71c1c)"  // Gradient for web
  );
}