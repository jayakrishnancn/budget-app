class Math {
  static num roundString(String number, {precision = 2}) {
    return double.parse(double.parse(number.trim()).toStringAsFixed(precision));
  }

  static num roundNum(num number, {precision = 2}) {
    return double.parse(number.toStringAsFixed(precision));
  }
}
