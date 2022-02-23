import 'package:budget/constants/app_colors.dart';
import 'package:budget/models/model.dart';
import 'package:flutter/material.dart';
import 'package:budget/enums/account_type.dart';

class Account extends Model {
  String name;
  String? id;
  String? accountNumber;
  double initialAmount;
  Icon icon;
  Color color;
  String accountType;
  bool excludeFromStat;
  List<String> label;

  Account({
    required this.name,
    this.id,
    this.accountNumber,
    this.initialAmount = 0,
    this.icon = const Icon(Icons.menu),
    this.color = AppColor.primaryColor,
    this.excludeFromStat = false,
    this.accountType = AccountType.bank,
    this.label = const [],
  });

  @override
  Map<String, dynamic> toJSON() => {
        "name": name,
        "id": id,
        "accountNumber": accountNumber,
        "initialAmount": initialAmount,
        "color": color.value,
        "excludeFromStat": excludeFromStat,
        "accountType": accountType,
      };

  static Account fromSnap(Map<String, dynamic> snapshotMap, {String? docId}) {
    return Account(
      name: snapshotMap['name'],
      id: docId ?? snapshotMap['id'],
      accountNumber: snapshotMap['accountNumber'],
      initialAmount: snapshotMap['initialAmount'],
      color: Color(snapshotMap['color']),
      excludeFromStat: snapshotMap['excludeFromStat'],
      accountType: snapshotMap['accountType'],
    );
  }
}
