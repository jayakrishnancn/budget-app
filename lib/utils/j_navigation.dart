import 'package:flutter/widgets.dart';

void popUntil(BuildContext context, String name) {
  Navigator.popUntil(context, ModalRoute.withName(name));
}
