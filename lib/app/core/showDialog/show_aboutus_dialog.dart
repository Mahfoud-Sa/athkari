import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Future<dynamic> showAboutUsDialog(BuildContext context) {
  final size = MediaQuery.of(context).size;
  
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: ui.TextDirection.rtl,
        child: AlertDialog(
          title: const Text(
            'معلومات التواصل',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SizedBox(
            width: size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ساهم بدعم تطوير التطبيق,حيث يمكنك التواصل مع فريق التطوير أو المساهمة في تحسين التطبيق:',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                 
                  _buildContactItem('• م. محفوظ بن سباح'),

                  const SizedBox(height: 12),
                  _buildContactItem('البريد الإلكتروني: binsabbah2013@gmail.com'),
                  _buildContactItem('رقم الهاتف: 770266408'),
                 // _buildContactItem('linkedIn:https://www.linkedin.com/in/mahfoud-sa/'),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'إغلاق',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    },
  );
}

Widget _buildContactItem(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      textAlign: TextAlign.right,
      style: const TextStyle(fontSize: 16),
    ),
  );
}