import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void showWarningDialog({
  required BuildContext context,
  required String message,
  String? okButtonText,
  String? cancelButtonText,
  VoidCallback? onOkPressed,
  VoidCallback? onCancelPressed,
}) {
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
            if (cancelButtonText != null)
              TextButton(
                onPressed: onCancelPressed ?? () => Navigator.pop(context),
                child: Text(
                  cancelButtonText,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              onPressed: onOkPressed ?? () => Navigator.pop(context),
              child: Text(
                okButtonText ?? 'موافق',
                style: const TextStyle(color: Colors.white),
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