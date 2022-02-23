import 'package:budget/models/transaction.dart';

abstract class TransactionRepo {
  Future<List<Transaction>> getTransactions();
  Future<Transaction> getTransaction(String id);
  Future<void> createTransaction(Transaction transaction);
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(String id);
}
