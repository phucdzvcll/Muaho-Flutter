class ProductCategoryHomeEntity {
  final int id;
  final String name;
  final String thumbUrl;

//<editor-fold desc="Data Methods">

  const ProductCategoryHomeEntity({
    required this.id,
    required this.name,
    required this.thumbUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCategoryHomeEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          thumbUrl == other.thumbUrl);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ thumbUrl.hashCode;

  @override
  String toString() {
    return 'ProductHomeCategory{' +
        ' id: $id,' +
        ' name: $name,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

  ProductCategoryHomeEntity copyWith({
    int? id,
    String? name,
    String? thumbUrl,
  }) {
    return ProductCategoryHomeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbUrl: thumbUrl ?? this.thumbUrl,
    );
  }

//</editor-fold>
}
