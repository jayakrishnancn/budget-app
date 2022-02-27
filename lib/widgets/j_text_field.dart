import 'package:budget/constants/app_colors.dart';
import 'package:budget/constants/design_system.dart';
import 'package:flutter/material.dart';

class JTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool enabled;
  final TextInputType keyboardType;

  const JTextField({
    Key? key,
    this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Inset.l),
      child: TextField(
        enabled: enabled,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: AppColor.primaryColor),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.primaryColor, width: BorderWidth.r),
          ),
          labelText: label,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  width: BorderWidth.r, color: AppColor.borderColor)),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
