import 'package:budget/exceptions/service_expception.dart';
import 'package:budget/models/account.dart';
import 'package:budget/repository/account_repo.dart';
import 'package:budget/repository/firebase/account_repo.dart';

class AccountService {
  static AccountRepo accountRepo = AccountFirebaseRepo();
  static List<Account> accounts = [];

  static Future<void> saveAccount(Account account) {
    if (account.name.isEmpty) {
      throw ServiceException('Account Name is mandatory');
    }
    return accountRepo.createAccount(account);
  }

  static Future<List<Account>> getAccounts() {
    return accountRepo.getAccounts().then((_accounts) {
      accounts = _accounts;
      return accounts;
    });
  }

  static Account? getAccountFromCache(id) {
    List<Account> account =
        accounts.where((element) => element.id == id).toList();
    return account.isEmpty ? null : account.first;
  }

  static Future<void> deleteAccount(String id) {
    return accountRepo.deleteAccount(id).then((_) => getAccounts());
  }

  static Future<void> updateAccount(Account account) {
    return accountRepo.updateAccount(account).then((_) => getAccounts());
  }
}
