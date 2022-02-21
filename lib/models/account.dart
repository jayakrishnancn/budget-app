import 'package:budget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:budget/enums/account_type.dart';

class Account {
  int id;
  String name;
  String? accountNumber;
  double initialAmount;
  Icon icon;
  Color color;
  AccountType accountType;
  bool excludeFromStat;
  List<String> label;

  Account({
    required this.id,
    required this.name,
    this.accountNumber,
    this.initialAmount = 0,
    this.icon = const Icon(Icons.menu),
    this.color = AppColor.primaryColor,
    this.excludeFromStat = false,
    this.accountType = AccountType.bank,
    this.label = const [],
  });
}
