import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  String? id;
  String? note;
  String? accountTo;
  String accountFrom;
  String category;
  double amount;
  String transactionType;
  Timestamp timestamp;

  Transaction({
    this.id,
    this.note,
    this.accountTo,
    required this.accountFrom,
    required this.category,
    required this.amount,
    required this.transactionType,
    Timestamp? timestamp,
  }) : timestamp = timestamp ?? Timestamp.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'note': note,
      'accountTo': accountTo,
      'accountFrom': accountFrom,
      'category': category,
      'amount': amount,
      'transactionType': transactionType,
      'timestamp': timestamp
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map, [String? docId]) {
    Timestamp timestamp =
        (map['timestamp'] as Timestamp?) ?? Timestamp.fromDate(DateTime(2000));
    return Transaction(
      id: docId ?? map['id'],
      note: map['note'],
      accountTo: map['accountTo'],
      accountFrom: map['accountFrom'] ?? '',
      category: map['category'] ?? '',
      amount: map['amount'] ?? '',
      transactionType: map['transactionType'] ?? '',
      timestamp: timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));
}
