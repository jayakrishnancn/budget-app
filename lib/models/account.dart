import 'package:budget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:budget/enums/account_type.dart';

class Account {
  String name;
  String? accountNumber;
  double initialAmount;
  Icon icon;
  Color color;
  AccountType accountType;
  bool excludeFromStat;
  List<String> label;

  Account({
    required this.name,
    this.accountNumber,
    this.initialAmount = 0,
    this.icon = const Icon(Icons.menu),
    this.color = AppColor.primaryColor,
    this.excludeFromStat = false,
    this.accountType = AccountType.bank,
    this.label = const [],
  });

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "accountNumber": accountNumber,
      "initialAmount": initialAmount,
      "color": color.value,
      "excludeFromStat": excludeFromStat,
      "accountType": accountType.value,
    };
  }
}
