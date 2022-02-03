import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(message),
      duration: const Duration(milliseconds: 900),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
