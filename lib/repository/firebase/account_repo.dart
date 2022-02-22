import '../../models/account.dart';
import '../account_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountFirebaseRepo extends AccountRepo {
  String userid = 'jayakrishnancn@gmail.com';

  @override
  Future<void> addAccount({required Account account}) {
    return FirebaseFirestore.instance
        .collection('users/$userid/accounts')
        .doc(account.name)
        .set(account.toJSON());
  }

  @override
  Future<List<Account>> getAccounts() async {
    List<Account> accounts = [];

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users/$userid/accounts')
        .get();
    for (var map in querySnapshot.docs) {
      accounts.add(Account.fromSnap(map.data()));
    }

    return accounts;
  }
}
