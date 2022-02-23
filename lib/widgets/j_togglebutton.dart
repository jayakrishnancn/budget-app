import 'package:flutter/material.dart';

import 'package:budget/constants/app_colors.dart';
import 'package:budget/constants/design_system.dart';
import 'package:budget/utils/color.dart';

class JToggleButton extends StatelessWidget {
  final List<String> textChildren;
  final void Function(int) onPressed;
  final int selectedIndex;
  final Color color;

  const JToggleButton(
      {Key? key,
      required this.textChildren,
      required this.onPressed,
      required this.selectedIndex,
      this.color = AppColor.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primary = color;
    Color altPrimary = getAltColor(primary);
    return ToggleButtons(
      borderColor: primary,
      selectedBorderColor: primary,
      selectedColor: altPrimary,
      color: primary,
      fillColor: primary,
      borderRadius: const BorderRadius.all(
        Radius.circular(BorderRad.r),
      ),
      disabledColor: altPrimary,
      children: textChildren
          .map((text) => Padding(
                padding: const EdgeInsets.all(Inset.l),
                child: Text(text),
              ))
          .toList(),
      isSelected:
          List.generate(textChildren.length, (index) => selectedIndex == index),
      onPressed: onPressed,
    );
  }
}
