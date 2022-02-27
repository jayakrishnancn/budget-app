import 'package:budget/widgets/j_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future showColorPicker(BuildContext context, Function(Color) onChange) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      actions: [
        JButton(
          text: "Ok",
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      title: const Text('Pick a color!'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: Colors.black,
          onColorChanged: onChange,
        ),
      ),
    ),
  );
}
