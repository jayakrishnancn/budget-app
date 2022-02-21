import 'package:flutter/material.dart';

class AddAccountScreen extends StatelessWidget {
  const AddAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.add)],
        title: const Text("Add Account"),
      ),
      body: const Text("Add Account"),
    );
  }
}
