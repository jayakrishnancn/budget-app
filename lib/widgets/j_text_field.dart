import 'package:budget/constants/app_colors.dart';
import 'package:flutter/material.dart';

class JTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String label;

  const JTextField({Key? key, this.controller, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
          ),
          labelText: label,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12)),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
