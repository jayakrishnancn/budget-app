enum Currency { inRs, usd }

extension CurrencyExt on Currency {
  static const _values = {
    Currency.inRs: '₹',
    Currency.usd: "\$",
  };

  String get value => _values[this] ?? '\$';
}
