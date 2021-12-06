class OrderHistoryComplete {
  final int orderId;
  final String orderCode;
  final String shopName;
  final int itemCount;
  final double total;
  final String status;
  final String thumbUrl;

//<editor-fold desc="Data Methods">

  const OrderHistoryComplete({
    required this.orderId,
    required this.orderCode,
    required this.shopName,
    required this.itemCount,
    required this.total,
    required this.status,
    required this.thumbUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderHistoryComplete &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          orderCode == other.orderCode &&
          shopName == other.shopName &&
          itemCount == other.itemCount &&
          total == other.total &&
          status == other.status &&
          thumbUrl == other.thumbUrl);

  @override
  int get hashCode =>
      orderId.hashCode ^
      orderCode.hashCode ^
      shopName.hashCode ^
      itemCount.hashCode ^
      total.hashCode ^
      status.hashCode ^
      thumbUrl.hashCode;

  @override
  String toString() {
    return 'OrderHistoryComplete{' +
        ' orderId: $orderId,' +
        ' orderCode: $orderCode,' +
        ' shopName: $shopName,' +
        ' itemCount: $itemCount,' +
        ' total: $total,' +
        ' status: $status,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

  OrderHistoryComplete copyWith({
    int? orderId,
    String? orderCode,
    String? shopName,
    int? itemCount,
    double? total,
    String? status,
    String? thumbUrl,
  }) {
    return OrderHistoryComplete(
      orderId: orderId ?? this.orderId,
      orderCode: orderCode ?? this.orderCode,
      shopName: shopName ?? this.shopName,
      itemCount: itemCount ?? this.itemCount,
      total: total ?? this.total,
      status: status ?? this.status,
      thumbUrl: thumbUrl ?? this.thumbUrl,
    );
  }

//</editor-fold>
}
