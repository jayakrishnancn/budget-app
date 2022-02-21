import 'package:budget/screens/accounts/list.dart';
import 'package:budget/screens/home_page.dart';
import 'package:flutter/widgets.dart';

enum Routes { homePage, accountsList, addAccount }

extension RouteExt on Routes {
  static final Map<String, Widget Function(BuildContext)> all = {
    'home_page': (ctx) => const HomePage(),
    'list_accounts': (ctx) => const ListAccountsScreen(),
    'add_account': (ctx) => const ListAccountsScreen()
  };

  Widget Function(BuildContext) get value =>
      all[this] ?? (ctx) => const HomePage();
}
