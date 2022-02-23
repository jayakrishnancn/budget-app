import 'package:budget/constants/app_colors.dart';
import 'package:budget/constants/design_system.dart';
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
  final String title = 'Add Transaction';
  int selectedIndex = 0;

  bool _isValidAddTransaction() {
    return false;
  }

  void _addTransaction() {
    if (_isValidAddTransaction()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
        child: Column(
          children: [
            JToggleButton(
              textChildren: const ['Income', 'Expense', 'Transfer'],
              selectedIndex: selectedIndex,
              onPressed: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButton(
                    items: [1, 2, 3]
                        .map((int items) => DropdownMenuItem(
                              value: items,
                              child: Text('$items'),
                            ))
                        .toList(),
                    value: 3,
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: DropdownButton(
                    items: [1, 2, 3]
                        .map((int items) => DropdownMenuItem(
                              value: items,
                              child: Text('$items'),
                            ))
                        .toList(),
                    elevation: 1,
                    value: 3,
                    onChanged: (value) {},
                  ),
                )
              ],
            ),
            const JTextField(label: 'Note'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                    child: JTextField(
                  label: 'Amount',
                  keyboardType: TextInputType.number,
                )),
                SizedBox(
                  width: Inset.r,
                ),
                Expanded(child: JTextField(label: 'Category')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
