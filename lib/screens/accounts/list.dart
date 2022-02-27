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

  refresh() {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addCategory.name)
              .then((e) => refresh());
        },
        child: const Icon(Icons.add),
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
                    itemCount: accounts.length,
                    itemBuilder: (ctx, index) {
                      Account? account = accounts[index];
                      Color _textColor =
                          account.excludeFromStat ? Colors.grey : Colors.black;
                      return ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.addAccount.name,
                                  arguments: account)
                              .then((_) => refresh());
                        },
                        leading: Container(
                          padding: const EdgeInsets.fromLTRB(
                              Inset.r, Inset.s, Inset.r, Inset.s),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(BorderRad.r)),
                            border: Border.all(
                                style: BorderStyle.solid,
                                color: AppColor.borderColor,
                                width: 1),
                          ),
                          child: Icon(Icons.house, size: 30, color: _textColor),
                        ),
                        title: Text(
                          account.name,
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
