import 'package:budget/constants/app_colors.dart';
import 'package:budget/constants/design_system.dart';
import 'package:budget/enums/routes.dart';
import 'package:budget/models/account.dart';
import 'package:budget/services/account_service.dart';
import 'package:budget/widgets/body_wrapper.dart';
import 'package:flutter/material.dart';

class ListAccountsScreen extends StatefulWidget {
  const ListAccountsScreen({Key? key}) : super(key: key);

  @override
  State<ListAccountsScreen> createState() => _ListAccountsScreenState();
}

class _ListAccountsScreenState extends State<ListAccountsScreen> {
  late Future<List<Account>> accountsFuture;
  @override
  void initState() {
    super.initState();
    accountsFuture = AccountService.getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Accounts';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(title),
      ),
      body: BodyWrapper(
        enableSingleChildScrollView: false,
        child: FutureBuilder<List<Account>>(
            future: accountsFuture,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Text("${snapshot.error}");
              } else {
                List<Account> accounts = snapshot.data!;
                // sort on name
                accounts.sort((a, b) => a.name.compareTo(b.name));
                return ListView.builder(
                    itemCount: accounts.length + 1,
                    itemBuilder: (ctx, index) {
                      bool isInList = index < accounts.length;
                      Account? account = isInList ? accounts[index] : null;
                      Color _textColor = isInList
                          ? account!.excludeFromStat
                              ? Colors.grey
                              : Colors.black
                          : AppColor.primaryColor;
                      return ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.addAccount.name,
                                  arguments: isInList ? account : null)
                              .then((_) => setState(() {
                                    // reload on pop
                                    accountsFuture =
                                        AccountService.getAccounts();
                                  }));
                        },
                        leading: Container(
                          padding: const EdgeInsets.fromLTRB(
                              Inset.r, Inset.s, Inset.r, Inset.s),
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
                              size: 30, color: _textColor),
                        ),
                        title: Text(
                          isInList ? account!.name : "Add Account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _textColor,
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
