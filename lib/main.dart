import 'package:budget/constants/app_info.dart';
import 'package:budget/screens/accounts/list.dart';
import 'package:budget/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppInfo.title,
      theme: ThemeData(
        primaryColor: Colors.red,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
      routes: {
        'home_page': (ctx) => const HomePage(),
        'accounts_list': (ctx) => const ListAccountsScreen()
      },
    );
  }
}
