import '../../repository/transaction_repo.dart';
import '../../models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import '../../exceptions/service_expception.dart';

class TransactionFirebaseRepo extends TransactionRepo {
  final String userid = 'jayakrishnancn@gmail.com';

  CollectionReference<Map<String, dynamic>> get root =>
      FirebaseFirestore.instance.collection('users/$userid/transaction');

  @override
  Future<List<Transaction>> getTransactions() async {
    List<Transaction> transactions = [];

    final querySnapshot = await root.get();
    for (var map in querySnapshot.docs) {
      transactions.add(Transaction.fromMap(map.data(), map.id));
    }

    return transactions;
  }

  @override
  Future<Transaction> getTransaction(String id) {
    return root.doc(id).get().then((value) {
      if (value.exists) {
        Transaction.fromMap(value.data()!, value.id);
      }
      throw ServiceException('can\'t find the transaction');
    });
  }

  @override
  Future<void> createTransaction(Transaction transaction) {
    return root.add(transaction.toMap());
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {
    var docRef = root.doc(transaction.id);

    return docRef.get().then((doc) {
      if (doc.exists) {
        return docRef.set(transaction.toMap());
      }
      return Future.error('Transaction does not exist.');
    }).catchError((error) {
      throw ServiceException('Cant find transaction');
    });
  }

  @override
  Future<void> deleteTransaction(String id) {
    return root.doc(id).delete();
  }
}
