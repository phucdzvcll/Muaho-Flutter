import 'package:intl/intl.dart';

final DateFormat _dayFormat = new DateFormat("dd/MM/yyyy");

extension StringUtils on String {
  DateTime parseDate(String format) => DateFormat(format).parse(this);

  DateTime parseDateApi(String format) => _dayFormat.parse(this);
}

extension StringNullUtils on String? {
  String defaultEmpty() => defaultIfNull("");
  String defaultIfNull(String defaultValue) => this ?? defaultValue;
}

