import 'package:budget/constants/app_info.dart';
import 'package:flutter/material.dart';

class AddAccount extends StatelessWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.add)],
        title: const Text("Add Account"),
      ),
    );
  }
}
