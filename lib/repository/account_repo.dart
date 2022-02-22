import 'package:budget/models/account.dart';

abstract class AccountRepo {
  Future<void> addAccount({required Account account});
  Future<List<Account>> getAccounts();
}
