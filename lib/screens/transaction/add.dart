import 'package:budget/widgets/body_wrapper.dart';
import 'package:budget/widgets/j_text_field.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({Key? key}) : super(key: key);
  final String title = 'Add Transaction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: BodyWrapper(
          child: Column(
        children: const [JTextField(label: 'amount')],
      )),
    );
  }
}
