import 'package:budget/constants/app_colors.dart';
import 'package:flutter/material.dart';

class JDropdownButton<T> extends StatelessWidget {
  final T? value;

  final void Function(T?) onChanged;

  final List<T> items;
  final Widget Function(T) getChild;
  final String hint;

  const JDropdownButton({
    Key? key,
    this.value,
    required this.onChanged,
    required this.items,
    required this.getChild,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      hint: Text(hint),
      underline: Container(
        height: 2,
        color: AppColor.borderColor,
      ),
      elevation: 12,
      value: value,
      onChanged: onChanged,
      items: items
          .map((T item) => DropdownMenuItem(
                value: item,
                child: getChild(item),
              ))
          .toList(),
    );
  }
}
