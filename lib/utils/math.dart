class Math {
  static num? roundString(String number, {precision = 2}) {
    try {
      return double.parse(
          double.parse(number.trim()).toStringAsFixed(precision));
    } catch (_) {
      return null;
    }
  }

  static num roundNum(num number, {precision = 2}) {
    return double.parse(number.toStringAsFixed(precision));
  }
}
