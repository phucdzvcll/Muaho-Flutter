import 'package:equatable/equatable.dart';

class OrderHistoryDelivering extends Equatable {
  final int orderId;
  final String orderCode;
  final String shopName;
  final int itemCount;
  final double total;
  final String status;
  final String thumbUrl;

  const OrderHistoryDelivering({
    required this.orderId,
    required this.orderCode,
    required this.shopName,
    required this.itemCount,
    required this.total,
    required this.status,
    required this.thumbUrl,
  });

  @override
  List<Object?> get props => [
        orderId,
        orderCode,
        shopName,
        itemCount,
        total,
        status,
        thumbUrl,
      ];
}
