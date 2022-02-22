import 'package:budget/constants/app_colors.dart';
import 'package:budget/models/account.dart';
import 'package:budget/services/account_service.dart';
import 'package:budget/utils/snackbar.dart';
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
  bool _excludeFromStat = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Account"),
        ),
        bottomNavigationBar: JButton(
            size: 200,
            text: "Add",
            borderRadius: 0,
            color: AppColor.secondaryColor,
            onPressed: () {
              try {
                Account accountDetails = Account(
                  name: AddAccountScreen.accountNameController.text,
                  initialAmount: double.parse(
                      AddAccountScreen.initialAmountController.text),
                  accountNumber: AddAccountScreen.accountNumberController.text,
                  excludeFromStat: _excludeFromStat,
                );

                AccountService.saveAccount(accountDetails).then((value) {
                  JSnack.show(context: context, message: 'Account Added');
                  Navigator.pop(context, true);
                }).catchError((onError) {
                  JSnack.show(
                      context: context,
                      message:
                          'An Error Occurred. can\'t create account. Please try again');
                }).whenComplete(() {
                  AddAccountScreen.accountNameController.clear();
                  AddAccountScreen.accountNumberController.clear();
                  AddAccountScreen.initialAmountController.clear();
                  setState(() {
                    _excludeFromStat = false;
                  });
                });
              } on Exception catch (e) {
                JSnack.error(context: context, message: e.toString());
              }
            }),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  JTextField(
                    label: 'Account Name',
                    controller: AddAccountScreen.accountNameController,
                  ),
                  JTextField(
                    label: 'Initial Amount',
                    keyboardType: TextInputType.number,
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
                        value: _excludeFromStat,
                        onChanged: (newValue) {
                          setState(() {
                            _excludeFromStat = newValue;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
