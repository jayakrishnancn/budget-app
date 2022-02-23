import 'package:budget/constants/design_system.dart';
import 'package:budget/enums/transaction.dart';
import 'package:budget/models/account.dart';
import 'package:budget/models/transaction.dart';
import 'package:budget/services/account_service.dart';
import 'package:budget/utils/math.dart';
import 'package:budget/widgets/snackbar.dart';
import 'package:budget/widgets/body_wrapper.dart';
import 'package:budget/widgets/j_button.dart';
import 'package:budget/widgets/j_text_field.dart';
import 'package:budget/widgets/j_togglebutton.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  static const String title = 'Add Transaction';
  static const List<String> _transactionTypes = [
    TransactionType.income,
    TransactionType.expense,
    TransactionType.transfer
  ];
  int _transactionTypeIndex = 1;
  Account? _accountFrom;
  Account? _accountTo;
  double? get _amount => Math.roundString(_amountController.text)?.toDouble();
  String get _category => _categoryController.text;
  String get _note => _noteController.text;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool _isValidAddTransaction() {
    if (_transactionTypeIndex == 2 && _accountTo == null) {
      JSnack.show(
          context: context, message: 'Please Select account to transfer');
      return false;
    }
    print('[jk] $_amount');
    if (_accountFrom == null) {
      JSnack.show(context: context, message: 'Please Select account from');
      return false;
    }
    if (_amount == null) {
      JSnack.show(context: context, message: 'Amount field is required');
    }
    if (_category.isEmpty) {
      JSnack.show(context: context, message: 'Please enter category');
    }
    return true;
  }

  void _addTransaction() {
    if (_isValidAddTransaction()) {
      Transaction transaction = Transaction(
          note: _note,
          accountFrom: _accountFrom!.id!,
          amount: _amount ?? 0,
          category: _category,
          transactionType: _transactionTypes[_transactionTypeIndex],
          accountTo: _accountTo?.id);
    }
  }

  final Future<List<Account>> _future = AccountService.getAccounts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(Inset.l),
          child: JButton(
            onPressed: _addTransaction,
            text: 'Add',
          )),
      body: BodyWrapper(
        enableSingleChildScrollView: false,
        child: FutureBuilder<List<Account>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              List<Account> accounts = snapshot.data!;
              return Column(
                children: [
                  JToggleButton(
                    textChildren: const ['Income', 'Expense', 'Transfer'],
                    selectedIndex: _transactionTypeIndex,
                    onPressed: (index) {
                      setState(() {
                        _transactionTypeIndex = index;

                        if (index != 2) {
                          _accountTo = null;
                        }
                      });
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: Inset.r, bottom: Inset.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButton(
                            hint: const Text("Account From"),
                            items: accounts
                                .map((Account item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(item.name),
                                    ))
                                .toList(),
                            value: _accountFrom,
                            onChanged: (Account? newValue) {
                              setState(() {
                                _accountFrom = newValue;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: Inset.r),
                        if (_transactionTypeIndex == 2)
                          Expanded(
                            child: DropdownButton(
                              hint: const Text("Account To"),
                              items: accounts
                                  .map((Account item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(item.name),
                                      ))
                                  .toList(),
                              value: _accountTo,
                              onChanged: (Account? newValue) {
                                setState(() {
                                  _accountTo = newValue;
                                });
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                  JTextField(
                    label: 'Note',
                    controller: _noteController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: JTextField(
                        label: 'Amount',
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                      )),
                      const SizedBox(
                        width: Inset.r,
                      ),
                      Expanded(
                          child: JTextField(
                        label: 'Category',
                        controller: _categoryController,
                      )),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
