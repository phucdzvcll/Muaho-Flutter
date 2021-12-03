class Product {
  final int productId;
  final String productName;
  final double productPrice;
  final String price;
  final int groupId;
  final String thumbUrl;

//<editor-fold desc="Data Methods">

  const Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.price,
    required this.groupId,
    required this.thumbUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          productName == other.productName &&
          productPrice == other.productPrice &&
          price == other.price &&
          groupId == other.groupId &&
          thumbUrl == other.thumbUrl);

  @override
  int get hashCode =>
      productId.hashCode ^
      productName.hashCode ^
      productPrice.hashCode ^
      price.hashCode ^
      groupId.hashCode ^
      thumbUrl.hashCode;

  @override
  String toString() {
    return 'Product{' +
        ' productId: $productId,' +
        ' productName: $productName,' +
        ' productPrice: $productPrice,' +
        ' price: $price,' +
        ' groupId: $groupId,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

  Product copyWith({
    int? productId,
    String? productName,
    double? productPrice,
    String? price,
    int? groupId,
    String? thumbUrl,
  }) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      price: price ?? this.price,
      groupId: groupId ?? this.groupId,
      thumbUrl: thumbUrl ?? this.thumbUrl,
    );
  }

//</editor-fold>
}
