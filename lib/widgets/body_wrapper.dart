import 'package:budget/constants/design_system.dart';
import 'package:flutter/material.dart';

class BodyWrapper extends StatelessWidget {
  final Widget child;
  final bool enableSingleChildScrollView;

  const BodyWrapper({
    Key? key,
    required this.child,
    this.enableSingleChildScrollView = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget padding = Padding(
      padding: const EdgeInsets.all(Inset.xl),
      child: child,
    );

    Widget singleChildScrollView = SingleChildScrollView(
      child: padding,
    );
    return SafeArea(
      child: enableSingleChildScrollView ? singleChildScrollView : padding,
    );
  }
}
