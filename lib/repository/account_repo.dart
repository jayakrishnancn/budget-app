import 'package:budget/models/account.dart';

abstract class AccountRepo {
  Future<List<Account>> getAccounts();
  Future<Account> getAccount(String id);
  Future<void> createAccount(Account account);
  Future<void> updateAccount(Account account);
  Future<void> deleteAccount(String id);
}
