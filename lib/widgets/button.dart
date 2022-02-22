import 'package:budget/constants/app_colors.dart';
import 'package:budget/constants/design_system.dart';
import 'package:flutter/material.dart';

class JButton extends StatelessWidget {
  final String text;
  final int size;
  final double height;
  final double width;
  final Color color;
  final double borderRadius;
  final void Function()? onPressed;
  const JButton(
      {Key? key,
      required this.text,
      this.size = 100,
      this.height = 50,
      this.width = double.infinity,
      this.color = AppColor.primaryColor,
      this.onPressed,
      this.borderRadius = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: Size(width, height),
        primary: color,
        elevation: 0,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        padding: const EdgeInsets.only(left: Inset.xlg, right: Inset.xlg),
      ),
      onPressed: onPressed,
      child: Text(text.toUpperCase()),
    );
  }
}
