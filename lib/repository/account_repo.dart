import 'package:budget/models/account.dart';

abstract class AccountRepo {
  Future<void> addAccount({required String userid, required Account account});
}
