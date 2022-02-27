import 'package:budget/enums/transaction.dart';
import 'package:budget/models/category.dart';
import 'package:budget/models/transaction.dart';
import 'package:budget/services/account_service.dart';
import 'package:budget/services/category_service.dart';
import 'package:budget/services/transaction_service.dart';
import 'package:budget/utils/color.dart';
import 'package:flutter/material.dart';

class ListTransaction extends StatelessWidget {
  ListTransaction({Key? key}) : super(key: key);

  static Future<List<Transaction>> getData() async {
    return AccountService.getAccounts()
        .then((_) => CategoryService.getCategories())
        .then((_) => TransactionService.getTransactions());
  }

  final Future<List<Transaction>> _future = getData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Transaction>? transactions = snapshot.data;

          if (snapshot.hasError || transactions == null) {
            return Text(snapshot.error.toString());
          }

          return Material(
              child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (ctx, index) {
                    Transaction transaction = transactions[index];

                    String? accountFrom = AccountService.getAccountFromCache(
                                transaction.accountFrom)
                            ?.name ??
                        '';

                    if (accountFrom.isNotEmpty) {
                      accountFrom = "$accountFrom\n";
                    }
                    Category? category = CategoryService.getCategoryFromCache(
                        transaction.category);
                    IconData categoryIconData =
                        category?.iconData ?? Icons.do_disturb;
                    Color iconColor = category?.color ?? Colors.black38;

                    return ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                        backgroundColor: iconColor,
                        child: Icon(
                          categoryIconData,
                          color: getAltColor(iconColor),
                        ),
                      ),
                      title: Text(category?.name ?? 'Unknown'),
                      subtitle: Text(
                        '$accountFrom ${transaction.note != null ? (transaction.note!) : ""}',
                        style: const TextStyle(color: Colors.black45),
                      ),
                      trailing: Text(
                        '${transaction.transactionType == TransactionType.income ? '+' : '-'} ${transaction.amount.toString()}',
                        style: TextStyle(
                          color: transaction.transactionType ==
                                  TransactionType.income
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }));
        });
  }
}
