class Product {
  final int productId;
  final String productName;
  final double productPrice;
  final String price;
  final int groupId;
  final int amount;
  final String thumbUrl;

//<editor-fold desc="Data Methods">

  const Product({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.price,
    required this.groupId,
    required this.amount,
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
          amount == other.amount &&
          thumbUrl == other.thumbUrl);

  @override
  int get hashCode =>
      productId.hashCode ^
      productName.hashCode ^
      productPrice.hashCode ^
      price.hashCode ^
      groupId.hashCode ^
      amount.hashCode ^
      thumbUrl.hashCode;

  @override
  String toString() {
    return 'Product{' +
        ' productId: $productId,' +
        ' productName: $productName,' +
        ' productPrice: $productPrice,' +
        ' price: $price,' +
        ' groupId: $groupId,' +
        ' amount: $amount,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

  Product copyWith({
    int? productId,
    String? productName,
    double? productPrice,
    String? price,
    int? groupId,
    int? amount,
    String? thumbUrl,
  }) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      price: price ?? this.price,
      groupId: groupId ?? this.groupId,
      amount: amount ?? this.amount,
      thumbUrl: thumbUrl ?? this.thumbUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'productName': this.productName,
      'productPrice': this.productPrice,
      'price': this.price,
      'groupId': this.groupId,
      'amount': this.amount,
      'thumbUrl': this.thumbUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'] as int,
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as double,
      price: map['price'] as String,
      groupId: map['groupId'] as int,
      amount: map['amount'] as int,
      thumbUrl: map['thumbUrl'] as String,
    );
  }

//</editor-fold>
}
