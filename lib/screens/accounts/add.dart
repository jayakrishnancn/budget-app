import 'package:budget/constants/app_colors.dart';
import 'package:budget/constants/design_system.dart';
import 'package:budget/enums/routes.dart';
import 'package:budget/models/account.dart';
import 'package:budget/services/account_service.dart';
import 'package:budget/utils/math.dart';
import 'package:budget/utils/snackbar.dart';
import 'package:budget/widgets/button.dart';
import 'package:budget/widgets/j_alertbox.dart';
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
  Account? account;

  @override
  void didChangeDependencies() {
    Account? account = ModalRoute.of(context)!.settings.arguments as Account?;

    AddAccountScreen.accountNameController.text = account?.name ?? '';
    AddAccountScreen.accountNumberController.text =
        account?.accountNumber ?? '';
    AddAccountScreen.initialAmountController.text =
        account?.initialAmount.toString() ?? '0';
    setState(() {
      this.account = account;
      _excludeFromStat = account?.excludeFromStat ?? false;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isUpdate = account != null;
    return Scaffold(
        appBar: AppBar(
          title: Text("${isUpdate ? "Update" : "Add"} Account"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          actions: isUpdate
              ? [
                  Container(
                      margin: const EdgeInsets.only(right: Inset.lg),
                      child: IconButton(
                          onPressed: () {
                            JAlertBox.show(
                              context,
                              JAlertBox(
                                title: 'Delete Account?',
                                cancelPressed: () {
                                  Navigator.pop(context);
                                },
                                confirmPressed: () {
                                  if (account?.name != null) {
                                    AccountService.deleteAccount(account!.name)
                                        .then((e) {
                                      JSnack.show(
                                          context: context,
                                          message: 'Account Deleted');
                                      Navigator.popUntil(
                                          context,
                                          ModalRoute.withName(
                                              Routes.listAccounts.name));
                                    }).catchError((onError) {
                                      JSnack.error(
                                        context: context,
                                        message:
                                            'Cant delete account!. Try again.',
                                      );
                                    });
                                  }
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete)))
                ]
              : null,
        ),
        bottomNavigationBar: JButton(
            size: 200,
            text: isUpdate ? "Update" : "Add",
            borderRadius: 0,
            color: AppColor.secondaryColor,
            onPressed: () {
              try {
                Account accountDetails = Account(
                  name: AddAccountScreen.accountNameController.text,
                  initialAmount: Math.roundString(
                          AddAccountScreen.initialAmountController.text)
                      .toDouble(),
                  accountNumber: AddAccountScreen.accountNumberController.text,
                  excludeFromStat: _excludeFromStat,
                );

                AccountService.saveAccount(accountDetails).then((value) {
                  JSnack.show(
                      context: context,
                      message: 'Account ${isUpdate ? "Updated" : "Added"}');
                  Navigator.pop(context, false);
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
              padding: const EdgeInsets.all(Inset.lg),
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
