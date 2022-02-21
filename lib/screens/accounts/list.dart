import 'package:budget/constants/app_colors.dart';
import 'package:budget/constants/app_info.dart';
import 'package:budget/enums/routes.dart';
import 'package:budget/models/account.dart';
import 'package:flutter/material.dart';

class ListAccountsScreen extends StatelessWidget {
  const ListAccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String title = 'Accounts';
    List<Account> accounts = [
      Account(id: 1, name: "HDFC"),
      Account(id: 1, name: "SBI")
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: accounts.length + 1,
              itemBuilder: (ctx, index) {
                bool isInList = index < accounts.length;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.addAccount.name);
                    },
                    leading: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: isInList
                                ? Colors.black12
                                : AppColor.primaryColor,
                            width: 1),
                      ),
                      child: Icon(isInList ? Icons.house : Icons.add,
                          size: 30,
                          color: !isInList ? AppColor.primaryColor : null),
                    ),
                    title: Text(
                      isInList ? accounts[index].name : "Add Account",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isInList ? null : AppColor.primaryColor),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
