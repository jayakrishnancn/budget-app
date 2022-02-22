import 'package:budget/constants/app_colors.dart';
import 'package:budget/models/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:budget/enums/account_type.dart';

class Account extends Model {
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

  Map<String, dynamic> toJSON() => {
        "name": name,
        "accountNumber": accountNumber,
        "initialAmount": initialAmount,
        "color": color.value,
        "excludeFromStat": excludeFromStat,
        "accountType": accountType.value,
      };

  static Account fromSnap(Map<String, dynamic> snapshotMap) {
    return Account(
      name: snapshotMap['name'],
      accountNumber: snapshotMap['accountNumber'],
      initialAmount: snapshotMap['initialAmount'],
      color: Color(snapshotMap['color']),
      excludeFromStat: snapshotMap['excludeFromStat'],
      accountType: getEnum(snapshotMap['accountType']),
    );
  }
}
