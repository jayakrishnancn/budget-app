import 'package:budget/models/transaction.dart';
import 'package:budget/services/transaction_service.dart';
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
                      leading: const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.local_gas_station,
                        ),
                      ),
                      title: Text(transaction.category),
                      subtitle: transaction.note != null
                          ? Text(
                              transaction.note!,
                              style: const TextStyle(color: Colors.black45),
                            )
                          : null,
                      trailing: Text(
                        '${transaction.transactionType == 'income' ? '+' : '-'} ${transaction.amount.toString()}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }));
        });
  }
}