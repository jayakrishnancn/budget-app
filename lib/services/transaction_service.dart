import 'package:budget/exceptions/service_expception.dart';
import 'package:budget/models/transaction.dart';
import 'package:budget/repository/firebase/transaction_repo.dart';
import 'package:budget/repository/transaction_repo.dart';

class TransactionService {
  static TransactionRepo transactionRepo = TransactionFirebaseRepo();
  static Future<void> saveTransaction(Transaction transaction) {
    if (transaction.accountFrom.isEmpty) {
      throw ServiceException('Account From is mandatory');
    }
    return transactionRepo.createTransaction(transaction);
  }

  static Future<List<Transaction>> getTransaction() {
    return transactionRepo.getTransactions();
  }

  static Future<void> deleteTransaction(String id) {
    return transactionRepo.deleteTransaction(id);
  }

  static Future<void> updateTransaction(Transaction transaction) {
    return transactionRepo.updateTransaction(transaction);
  }
}
