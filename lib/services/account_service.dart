import 'package:budget/models/account.dart';
import 'package:budget/repository/account_repo.dart';
import 'package:budget/repository/firebase/account_repo.dart';

class AccountService {
  static AccountRepo accountRepo = AccountFirebaseRepo();
  static Future<void> saveAccount(Account account) {
    return accountRepo.addAccount(userid: '100', account: account);
  }
}
