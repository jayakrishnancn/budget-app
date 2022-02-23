import 'package:cloud_firestore/cloud_firestore.dart';
import '../../exceptions/service_expception.dart';
import '../../models/account.dart';
import '../account_repo.dart';

class AccountFirebaseRepo extends AccountRepo {
  final String userid = 'jayakrishnancn@gmail.com';

  CollectionReference<Map<String, dynamic>> get root =>
      FirebaseFirestore.instance.collection('users/$userid/accounts');

  @override
  Future<List<Account>> getAccounts() async {
    List<Account> accounts = [];

    final querySnapshot = await root.get();
    for (var map in querySnapshot.docs) {
      accounts.add(Account.fromMap(map.data(), map.id));
    }

    return accounts;
  }

  @override
  Future<Account> getAccount(String id) {
    return root.doc(id).get().then((value) {
      if (value.exists) {
        Account.fromMap(value.data()!, value.id);
      }
      throw ServiceException('can\'t find the account');
    });
  }

  @override
  Future<void> createAccount(Account account) {
    return root.add(account.toMap());
  }

  @override
  Future<void> updateAccount(Account account) {
    var docRef = root.doc(account.id);

    return docRef.get().then((doc) {
      if (doc.exists) {
        return docRef.set(account.toMap());
      }
      return Future.error('Account does not exist.');
    }).catchError((error) {
      throw ServiceException('Cant find account');
    });
  }

  @override
  Future<void> deleteAccount(String id) {
    return root.doc(id).delete();
  }
}
