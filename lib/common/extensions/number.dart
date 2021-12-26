import 'package:intl/intl.dart';

final NumberFormat moneyNumberFormat = NumberFormat("#,##0.##", "en_US");

extension IntNullUtils on int? {
  int defaultZero() => defaultIfNull(0);

  int defaultIfNull(int defaultNumber) => this ?? defaultNumber;

  String format() {
    return moneyNumberFormat.format(this);
  }
}

extension DoubleNullUtils on double? {
  double defaultZero() => defaultIfNull(0.0);

  double defaultIfNull(double defaultNumber) => this ?? defaultNumber;

  String format() {
    return moneyNumberFormat.format(this);
  }
}
