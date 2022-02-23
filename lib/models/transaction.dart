import 'dart:convert';

class Transaction {
  String? id;
  String? note;
  String? accountTo;
  String accountFrom;
  String category;
  double amount;
  String transactionType;

  Transaction({
    this.id,
    this.note,
    this.accountTo,
    required this.accountFrom,
    required this.category,
    required this.amount,
    required this.transactionType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'note': note,
      'accountTo': accountTo,
      'accountFrom': accountFrom,
      'category': category,
      'amount': amount,
      'transactionType': transactionType,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map, [String? docId]) {
    return Transaction(
      id: docId ?? map['id'],
      note: map['note'],
      accountTo: map['accountTo'],
      accountFrom: map['accountFrom'] ?? '',
      category: map['category'] ?? '',
      amount: map['amount'] ?? '',
      transactionType: map['transactionType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));
}
