import 'package:budget/constants/app_colors.dart';
import 'package:budget/widgets/j_text_field.dart';
import 'package:flutter/material.dart';

class AddAccountScreen extends StatelessWidget {
  const AddAccountScreen({Key? key}) : super(key: key);
  static final accountNameController = TextEditingController();
  static final initialAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: const Icon(Icons.check),
            )
          ],
          title: const Text("Add Account"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const JTextField(label: 'Account Name'),
              const JTextField(label: 'Initial Amount'),
              const JTextField(label: 'Account Number'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Exclude from stat?'),
                  Switch(
                    activeColor: AppColor.primaryColor,
                    value: true,
                    onChanged: (newValue) {},
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
