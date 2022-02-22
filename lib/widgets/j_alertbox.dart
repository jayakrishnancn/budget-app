import 'package:flutter/material.dart';

class JAlertBox extends StatelessWidget {
  final String confirmText;
  final String cancelText;
  final String title;
  final String? content;
  final void Function()? cancelPressed;
  final void Function()? confirmPressed;

  const JAlertBox({
    Key? key,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    required this.title,
    this.content,
    this.cancelPressed,
    this.confirmPressed,
  }) : super(key: key);

  static show(context, baseDialog) {
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  @override
  Widget build(BuildContext context) {
    Widget confirmButton = TextButton(
      child: Text(confirmText),
      onPressed: confirmPressed,
    );

    Widget cancelButton = TextButton(
      child: Text(cancelText),
      onPressed: cancelPressed,
    );

    return AlertDialog(
      title: Text(title),
      content: content == null ? null : Text(content!),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );
  }
}
