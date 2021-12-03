class Product {
  final int productId;
  final String productName;
  final double productPrice;
  final int groupId;
  final String unit;
  final String thumbUrl;
  int amount;

//<editor-fold desc="Data Methods">

  Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.groupId,
    required this.unit,
    required this.thumbUrl,
    this.amount = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          productName == other.productName &&
          productPrice == other.productPrice &&
          groupId == other.groupId &&
          unit == other.unit &&
          thumbUrl == other.thumbUrl &&
          amount == other.amount);

  @override
  int get hashCode =>
      productId.hashCode ^
      productName.hashCode ^
      productPrice.hashCode ^
      groupId.hashCode ^
      unit.hashCode ^
      thumbUrl.hashCode ^
      amount.hashCode;

  @override
  String toString() {
    return 'Product{' +
        ' productId: $productId,' +
        ' productName: $productName,' +
        ' productPrice: $productPrice,' +
        ' groupId: $groupId,' +
        ' unit: $unit,' +
        ' thumbUrl: $thumbUrl,' +
        ' amount: $amount,' +
        '}';
  }

  Product copyWith({
    int? productId,
    String? productName,
    double? productPrice,
    int? groupId,
    String? unit,
    String? thumbUrl,
    int? amount,
  }) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      groupId: groupId ?? this.groupId,
      unit: unit ?? this.unit,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      amount: amount ?? this.amount,
    );
  }

//</editor-fold>
}
