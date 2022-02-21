import 'package:budget/constants/app_info.dart';
import 'package:budget/enums/routes.dart';
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
            primarySwatch: AppInfo.primarySwatch,
            primaryColor: AppInfo.primaryColor,
            appBarTheme: const AppBarTheme(
                elevation: 0, backgroundColor: AppInfo.primaryColor),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppInfo.primaryColor,
            )),
        home: const HomeScreen(),
        routes: Routes.listAccounts.routes);
  }
}
