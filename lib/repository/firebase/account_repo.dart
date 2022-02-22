import '../../models/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../account_repo.dart';

class AccountFirebaseRepo extends AccountRepo {
  @override
  Future<void> addAccount({required String userid, required Account account}) {
    return FirebaseFirestore.instance
        .collection('users/320/accounts')
        .doc(account.name)
        .set(account.toJSON());
  }
}
