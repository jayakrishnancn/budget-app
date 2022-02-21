enum AccountType { bank, card, other }

extension CurrencyExt on AccountType {
  String get value => toString().split('.').last;
}
