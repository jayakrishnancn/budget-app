import 'dart:convert';

import '../../models/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../account_repo.dart';

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
    querySnapshot.docs.forEach((map) {
      accounts.add(Account.fromSnap(map.data()));
    });

    return accounts;
  }
}
