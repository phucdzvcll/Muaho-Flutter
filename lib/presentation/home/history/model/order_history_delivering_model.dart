class OrderHistoryDeliveringModel {
  final String shopName;
  final String subText;
  final String totalPrice;

//<editor-fold desc="Data Methods">

  const OrderHistoryDeliveringModel({
    required this.shopName,
    required this.subText,
    required this.totalPrice,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderHistoryDeliveringModel &&
          runtimeType == other.runtimeType &&
          shopName == other.shopName &&
          subText == other.subText &&
          totalPrice == other.totalPrice);

  @override
  int get hashCode =>
      shopName.hashCode ^ subText.hashCode ^ totalPrice.hashCode;

  @override
  String toString() {
    return 'OrderHistoryDeliveringModel{' +
        ' shopName: $shopName,' +
        ' subText: $subText,' +
        ' totalPrice: $totalPrice,' +
        '}';
  }

  OrderHistoryDeliveringModel copyWith({
    String? shopName,
    String? subText,
    String? totalPrice,
  }) {
    return OrderHistoryDeliveringModel(
      shopName: shopName ?? this.shopName,
      subText: subText ?? this.subText,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
//</editor-fold>
}
