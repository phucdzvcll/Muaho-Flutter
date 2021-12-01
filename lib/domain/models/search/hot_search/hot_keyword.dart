class HotKeyword {
  final String name;

//<editor-fold desc="Data Methods">

  const HotKeyword({
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HotKeyword &&
          runtimeType == other.runtimeType &&
          name == other.name);

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'Keyword{' + ' name: $name,' + '}';
  }

  HotKeyword copyWith({
    String? name,
  }) {
    return HotKeyword(
      name: name ?? this.name,
    );
  }

//</editor-fold>
}
