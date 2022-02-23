import 'package:flutter/material.dart';

class JSnack {
  static void show({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.black87,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Text(message),
    ));
  }

  static void error({
    required BuildContext context,
    required String message,
  }) {
    show(context: context, message: message, backgroundColor: Colors.red);
  }
}
