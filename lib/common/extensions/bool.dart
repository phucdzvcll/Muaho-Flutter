extension BoolNullUtils on bool? {
  bool defaultFalse() => defaultIfNull(false);

  bool defaultIfNull(bool defaultValue) => this ?? defaultValue;
}
