class OrderHistoryDeliveringModel {
  final int orderID;
  final String shopName;
  final String subText;
  final String totalPrice;

//<editor-fold desc="Data Methods">

  const OrderHistoryDeliveringModel({
    required this.orderID,
    required this.shopName,
    required this.subText,
    required this.totalPrice,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderHistoryDeliveringModel &&
          runtimeType == other.runtimeType &&
          orderID == other.orderID &&
          shopName == other.shopName &&
          subText == other.subText &&
          totalPrice == other.totalPrice);

  @override
  int get hashCode =>
      orderID.hashCode ^
      shopName.hashCode ^
      subText.hashCode ^
      totalPrice.hashCode;

  @override
  String toString() {
    return 'OrderHistoryDeliveringModel{' +
        ' orderID: $orderID,' +
        ' shopName: $shopName,' +
        ' subText: $subText,' +
        ' totalPrice: $totalPrice,' +
        '}';
  }

  OrderHistoryDeliveringModel copyWith({
    int? orderID,
    String? shopName,
    String? subText,
    String? totalPrice,
  }) {
    return OrderHistoryDeliveringModel(
      orderID: orderID ?? this.orderID,
      shopName: shopName ?? this.shopName,
      subText: subText ?? this.subText,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

//</editor-fold>
}
