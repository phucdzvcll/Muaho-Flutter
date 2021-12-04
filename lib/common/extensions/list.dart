extension ListNullUtils on List? {
  List defaultEmpty() => defaultIfNull([]);

  List defaultIfNull(List defaultValue) => this ?? defaultValue;
}
