import 'package:budget/constants/app_colors.dart';
import 'package:budget/screens/transaction/list.dart';
import 'package:flutter/material.dart';

import '../constants/app_info.dart';
import '../enums/routes.dart';
import '../widgets/j_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppInfo.name),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          elevation: 0,
          color: AppColor.primaryColor,
          child: BottomNavigationBar(
            elevation: 0,
            unselectedItemColor: AppColor.primaryTextColor,
            selectedItemColor: AppColor.primaryTextColor,
            backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: AppColor.primaryTextColor,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.article,
                    color: AppColor.primaryTextColor,
                  ),
                  label: 'Edit')
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add new transaction",
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Routes.addTransaction.name)
              .then((value) {
            setState(() {});
          });
        },
      ),
      body: Center(
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                JButton(
                  text: 'Add Account',
                  style: JButtonStyle.solid,
                  iconData: Icons.add,
                  colorStyle: JButtonColorStyle.primary,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.listAccounts.name);
                  },
                ),
                JButton(
                  text: 'Add Category',
                  style: JButtonStyle.outline,
                  color: AppColor.primaryColor,
                  iconData: Icons.category,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.listCategory.name);
                  },
                ),
              ],
            ),
            Expanded(child: ListTransaction())
          ],
        ),
      ),
    );
  }
}
