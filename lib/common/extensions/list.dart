extension ListNullUtils on List? {
  List defaultEmpty() => defaultIfNull([]);

  List defaultIfNull(List defaultValue) => this ?? defaultValue;
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
