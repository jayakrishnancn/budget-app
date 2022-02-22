import '../../models/account.dart';
import '../account_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountFirebaseRepo extends AccountRepo {
  String userid = 'jayakrishnancn@gmail.com';

  @override
  Future<void> createAccount(Account account) {
    return FirebaseFirestore.instance
        .collection('users/$userid/accounts')
        .add(account.toJSON());
  }

  @override
  Future<void> updateAccount(Account account) {
    var docRef = FirebaseFirestore.instance
        .collection('users/$userid/accounts')
        .doc(account.id);
    return docRef.get().then((doc) {
      if (doc.exists) {
        return docRef.set(account.toJSON());
      }
      return Future.error('Account does not exist.');
    });
  }

  @override
  Future<List<Account>> getAccounts() async {
    List<Account> accounts = [];

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users/$userid/accounts')
        .get();
    for (var map in querySnapshot.docs) {
      accounts.add(Account.fromSnap(map.data(), docId: map.id));
    }

    return accounts;
  }

  @override
  Future<void> deleteAccount(String id) {
    print(id);
    return FirebaseFirestore.instance
        .collection('users/$userid/accounts')
        .doc(id)
        .delete();
  }
}
