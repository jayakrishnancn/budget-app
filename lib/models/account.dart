import 'package:flutter/material.dart';
import 'package:budget/constants/app_info.dart';
import 'package:budget/enums/account_type.dart';

class Account {
  int id;
  String name;
  String? description;
  double initialAmount;
  Icon icon;
  Color color;
  AccountType accountType;
  bool excludeFromStat;
  List<String> label;

  Account({
    required this.id,
    required this.name,
    this.description,
    this.initialAmount = 0,
    this.icon = const Icon(Icons.menu),
    this.color = AppInfo.defaultColor,
    this.excludeFromStat = false,
    this.accountType = AccountType.bank,
    this.label = const [],
  });
}
