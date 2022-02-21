import 'package:budget/constants/app_info.dart';
import 'package:budget/screens/accounts_list_screen.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: const AccountsListScreen(),
    );
  }
}
