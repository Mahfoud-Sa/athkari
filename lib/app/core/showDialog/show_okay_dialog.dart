import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void showOkayAlert(BuildContext context, String message) {
    final size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: AlertDialog(
            title: const Text(
              'تنبيه',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: SizedBox(
              width: size.width * 0.8,
              child: Text(
                message,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 16),
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
                  'موافق',
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
