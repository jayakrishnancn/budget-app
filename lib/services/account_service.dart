import 'package:budget/models/account.dart';
import 'package:budget/repository/account_repo.dart';

class AccountService {
  static Future<void> saveAccount(Account account) {
    return AccountRepo.addAccount(userid: '100', account: account);
  }
}
