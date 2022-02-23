import 'package:flutter/material.dart';

Color getAltColor(Color _color) {
  return _color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}
