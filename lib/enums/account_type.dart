enum AccountType { bank, card, other }

extension CurrencyExt on AccountType {
  String get value => toString().split('.').last;
}

AccountType getEnum(String str) {
  return AccountType.values.firstWhere((s) => s.value == str);
}
