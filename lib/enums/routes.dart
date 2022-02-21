import 'package:budget/screens/accounts/add.dart';
import 'package:budget/screens/accounts/list.dart';
import 'package:budget/screens/home_page.dart';
import 'package:flutter/widgets.dart';

enum Routes { homePage, listAccounts, addAccount }

extension RouteExt on Routes {
  static final Map<String, Widget Function(BuildContext)> _routes = {
    Routes.homePage.name: (ctx) => const HomeScreen(),
    Routes.listAccounts.name: (ctx) => const ListAccountsScreen(),
    Routes.addAccount.name: (ctx) => const AddAccountScreen()
  };

  Widget Function(BuildContext) get value =>
      _routes[this] ?? (ctx) => const HomeScreen();

  get routes {
    return _routes;
  }
}