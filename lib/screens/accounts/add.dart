import 'package:budget/constants/app_colors.dart';
import 'package:budget/widgets/button.dart';
import 'package:budget/widgets/j_text_field.dart';
import 'package:flutter/material.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({Key? key}) : super(key: key);
  static final accountNameController = TextEditingController();
  static final initialAmountController = TextEditingController();
  static final accountNumberController = TextEditingController();

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  bool excludeFromStat = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Account"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              JTextField(
                label: 'Account Name',
                controller: AddAccountScreen.accountNameController,
              ),
              JTextField(
                label: 'Initial Amount',
                controller: AddAccountScreen.initialAmountController,
              ),
              JTextField(
                label: 'Account Number',
                controller: AddAccountScreen.accountNumberController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Exclude from stat?'),
                  Switch(
                    activeColor: AppColor.primaryColor,
                    value: excludeFromStat,
                    onChanged: (newValue) {
                      setState(() {
                        excludeFromStat = newValue;
                      });
                    },
                  )
                ],
              ),
              const Spacer(),
              const JButton(
                size: 200,
                text: "Add",
                color: AppColor.secondaryColor,
              )
            ],
          ),
        ));
  }
}
