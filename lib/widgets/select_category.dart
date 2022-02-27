import 'package:budget/enums/routes.dart';
import 'package:budget/models/category.dart';
import 'package:budget/widgets/j_text_field.dart';
import 'package:flutter/material.dart';

class JSelectCategory extends StatelessWidget {
  final _controller = TextEditingController();
  final Category? value;
  final Function(Category?) onSelect;

  JSelectCategory({Key? key, required this.onSelect, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.text = value?.name ?? '';
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.listCategory.name, arguments: true)
            .then((value) {
          if (value != null && value is Category) {
            onSelect(value);
          }
        });
      },
      child: JTextField(
        label: 'Category',
        enabled: false,
        controller: _controller,
      ),
    );
  }
}
