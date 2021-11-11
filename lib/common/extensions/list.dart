extension ListNullUtils on List<dynamic>? {
  List<dynamic> defaultEmpty() => defaultIfNull(List.empty());
  List<dynamic> defaultIfNull(List defaultValue) => this ?? defaultValue;
}
