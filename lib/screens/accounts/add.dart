import '../../constants/app_colors.dart';
import '../../constants/design_system.dart';
import '../../enums/routes.dart';
import '../../models/account.dart';
import '../../services/account_service.dart';
import '../../utils/math.dart';
import '../../utils/snackbar.dart';
import '../../widgets/body_wrapper.dart';
import '../../widgets/j_button.dart';
import '../../widgets/j_alertbox.dart';
import '../../widgets/j_text_field.dart';
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

  void _gotoPreviousPage() {
    Navigator.popUntil(context, ModalRoute.withName(Routes.listAccounts.name));
  }

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
            onPressed: _gotoPreviousPage,
          ),
          actions: isUpdate
              ? [
                  Container(
                      margin: const EdgeInsets.only(right: Inset.l),
                      child: IconButton(
                          onPressed: () {
                            JAlertBox.show(
                              context,
                              JAlertBox(
                                title: 'Delete Account?',
                                cancelPressed: () => Navigator.pop(context),
                                confirmPressed: () {
                                  if (account?.id != null) {
                                    AccountService.deleteAccount(account!.id!)
                                        .then((e) {
                                      JSnack.show(
                                          context: context,
                                          message: 'Account Deleted');
                                      _gotoPreviousPage();
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(Inset.l),
          child: JButton(
              text: isUpdate ? "Update" : "Add",
              onPressed: () {
                try {
                  Account accountDetails = Account(
                    id: isUpdate ? account?.id : null,
                    name: AddAccountScreen.accountNameController.text,
                    initialAmount: Math.roundString(
                            AddAccountScreen.initialAmountController.text)
                        .toDouble(),
                    accountNumber:
                        AddAccountScreen.accountNumberController.text,
                    excludeFromStat: _excludeFromStat,
                  );
                  Future<void> service = isUpdate
                      ? AccountService.updateAccount(accountDetails)
                      : AccountService.saveAccount(accountDetails);
                  service.then((value) {
                    JSnack.show(
                        context: context,
                        message: 'Account ${isUpdate ? "Updated" : "Added"}');
                    _gotoPreviousPage();
                  }).then((e) {
                    AddAccountScreen.accountNameController.clear();
                    AddAccountScreen.accountNumberController.clear();
                    AddAccountScreen.initialAmountController.clear();
                    setState(() {
                      _excludeFromStat = false;
                    });
                  }).catchError((onError) {
                    JSnack.error(context: context, message: onError.toString());
                  });
                } on Exception catch (e) {
                  JSnack.error(context: context, message: e.toString());
                }
              }),
        ),
        body: BodyWrapper(
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
              SwitchListTile(
                title: const Text('Exclude from stat?'),
                activeColor: AppColor.primaryColor,
                value: _excludeFromStat,
                onChanged: (newValue) {
                  setState(() {
                    _excludeFromStat = newValue;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
