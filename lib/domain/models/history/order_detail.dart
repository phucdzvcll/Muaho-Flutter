class OrderDetailEntity {
  final int orderId;
  final String voucherCode;
  final double totalBeforeDiscount;
  final double voucherDiscount;
  final double total;
  final String deliveryAddress;
  final String deliveryPhoneNumber;
  final int shopId;
  final String shopName;
  final String shopAddress;
  final String status;
  final List<Product> products;

//<editor-fold desc="Data Methods">

  const OrderDetailEntity({
    required this.orderId,
    required this.voucherCode,
    required this.totalBeforeDiscount,
    required this.voucherDiscount,
    required this.total,
    required this.deliveryAddress,
    required this.deliveryPhoneNumber,
    required this.shopId,
    required this.shopName,
    required this.shopAddress,
    required this.status,
    required this.products,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderDetailEntity &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          voucherCode == other.voucherCode &&
          totalBeforeDiscount == other.totalBeforeDiscount &&
          voucherDiscount == other.voucherDiscount &&
          total == other.total &&
          deliveryAddress == other.deliveryAddress &&
          deliveryPhoneNumber == other.deliveryPhoneNumber &&
          shopId == other.shopId &&
          shopName == other.shopName &&
          shopAddress == other.shopAddress &&
          status == other.status &&
          products == other.products);

  @override
  int get hashCode =>
      orderId.hashCode ^
      voucherCode.hashCode ^
      totalBeforeDiscount.hashCode ^
      voucherDiscount.hashCode ^
      total.hashCode ^
      deliveryAddress.hashCode ^
      deliveryPhoneNumber.hashCode ^
      shopId.hashCode ^
      shopName.hashCode ^
      shopAddress.hashCode ^
      status.hashCode ^
      products.hashCode;

  @override
  String toString() {
    return 'OrderDetailEntity{' +
        ' orderId: $orderId,' +
        ' voucherCode: $voucherCode,' +
        ' totalBeforeDiscount: $totalBeforeDiscount,' +
        ' voucherDiscount: $voucherDiscount,' +
        ' total: $total,' +
        ' deliveryAddress: $deliveryAddress,' +
        ' deliveryPhoneNumber: $deliveryPhoneNumber,' +
        ' shopId: $shopId,' +
        ' shopName: $shopName,' +
        ' shopAddress: $shopAddress,' +
        ' status: $status,' +
        ' products: $products,' +
        '}';
  }

  OrderDetailEntity copyWith({
    int? orderId,
    String? voucherCode,
    double? totalBeforeDiscount,
    double? voucherDiscount,
    double? total,
    String? deliveryAddress,
    String? deliveryPhoneNumber,
    int? shopId,
    String? shopName,
    String? shopAddress,
    String? status,
    List<Product>? products,
  }) {
    return OrderDetailEntity(
      orderId: orderId ?? this.orderId,
      voucherCode: voucherCode ?? this.voucherCode,
      totalBeforeDiscount: totalBeforeDiscount ?? this.totalBeforeDiscount,
      voucherDiscount: voucherDiscount ?? this.voucherDiscount,
      total: total ?? this.total,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryPhoneNumber: deliveryPhoneNumber ?? this.deliveryPhoneNumber,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      shopAddress: shopAddress ?? this.shopAddress,
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

//</editor-fold>
}

class Product {
  final int productId;
  final double price;
  final int quantity;
  final double total;
  final String productName;
  final String thumbUrl;

//<editor-fold desc="Data Methods">

  const Product({
    required this.productId,
    required this.price,
    required this.quantity,
    required this.total,
    required this.productName,
    required this.thumbUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          price == other.price &&
          quantity == other.quantity &&
          total == other.total &&
          productName == other.productName &&
          thumbUrl == other.thumbUrl);

  @override
  int get hashCode =>
      productId.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      total.hashCode ^
      productName.hashCode ^
      thumbUrl.hashCode;

  @override
  String toString() {
    return 'Product{' +
        ' productId: $productId,' +
        ' price: $price,' +
        ' quantity: $quantity,' +
        ' total: $total,' +
        ' productName: $productName,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

  Product copyWith({
    int? productId,
    double? price,
    int? quantity,
    double? total,
    String? productName,
    String? thumbUrl,
  }) {
    return Product(
      productId: productId ?? this.productId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      productName: productName ?? this.productName,
      thumbUrl: thumbUrl ?? this.thumbUrl,
    );
  }

//</editor-fold>
}
