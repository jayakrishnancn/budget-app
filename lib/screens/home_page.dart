import 'package:budget/constants/app_colors.dart';
import 'package:budget/constants/app_info.dart';
import 'package:budget/constants/design_system.dart';
import 'package:budget/enums/routes.dart';
import 'package:budget/widgets/j_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppInfo.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JButton(
              text: 'Add Account',
              style: JButtonStyle.outline,
              iconData: Icons.add,
              colorStyle: JButtonColorStyle.primary,
              onPressed: () {
                Navigator.pushNamed(context, Routes.listAccounts.name);
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Routes.addTransaction.name);
        },
        label: const Text("Add Transaction"),
      ),
    );
  }
}
