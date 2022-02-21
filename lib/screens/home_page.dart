import 'package:budget/constants/app_info.dart';
import 'package:budget/enums/currency.dart';
import 'package:budget/widgets/amount.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppInfo.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Amount(
              amount: 10,
              currency: Currency.inRs,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('accounts_list');
        },
        label: const Text("Add Account"),
      ),
    );
  }
}
