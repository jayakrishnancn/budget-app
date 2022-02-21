import 'package:budget/models/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountRepo {
  static Future<void> addAccount(
      {required String userid, required Account account}) {
    return FirebaseFirestore.instance
        .collection('users/320/accounts')
        .doc(account.name)
        .set(account.toJSON());
  }
}
