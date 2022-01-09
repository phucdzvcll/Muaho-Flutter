extension ListNullUtils <T> on List<T>? {
  List<T> defaultEmpty() => defaultIfNull(<T>[]);

  List<T> defaultIfNull(List<T> defaultValue) => this ?? defaultValue;
}

extension ListExtension<T> on List<T> {
  T? getOrNull(int index) {
    if (index >= 0 && index < this.length) {
      return this[index];
    } else {
      return null;
    }
  }
}
