import 'package:budget/enums/transaction.dart';
import 'package:budget/models/transaction.dart';
import 'package:budget/services/transaction_service.dart';
import 'package:budget/utils/color.dart';
import 'package:flutter/material.dart';

class ListTransaction extends StatelessWidget {
  ListTransaction({Key? key}) : super(key: key);

  final Future<List<Transaction>> _future =
      TransactionService.getTransactions();

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
                    return ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.local_gas_station,
                          color: getAltColor(Colors.red),
                        ),
                      ),
                      title: Text(transaction.category),
                      subtitle: Text(
                        '${transaction.accountFrom}${transaction.note != null ? ("\n" + transaction.note!) : ""}',
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
