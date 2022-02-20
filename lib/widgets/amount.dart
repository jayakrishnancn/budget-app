import 'package:budget/enums/currency.dart';
import 'package:flutter/cupertino.dart';

class Amount extends StatelessWidget {
  final num amount;
  final Currency currency;

  const Amount({Key? key, required this.amount, this.currency = Currency.inRs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('$amount $currency');
  }
}
