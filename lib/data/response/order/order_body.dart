import 'package:json_annotation/json_annotation.dart';

part 'order_body.g.dart';

@JsonSerializable()
class OrderBody {
  int? voucherId;
  final double totalBeforeDiscount;
  double? voucherDiscount;
  final double total;
  final int userId;
  final int deliveryAddressID;
  final int shopId;
  final List<OrderProduct> products;

  OrderBody(
      {required this.totalBeforeDiscount,
      required this.total,
      required this.userId,
      required this.deliveryAddressID,
      required this.shopId,
      required this.voucherDiscount,
      required this.voucherId,
      required this.products});

  factory OrderBody.fromJson(Map<String, dynamic> json) =>
      _$OrderBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBodyToJson(this);
}

@JsonSerializable()
class OrderProduct {
  final int productId;
  final double price;
  final int quantity;
  final double total;

  OrderProduct(this.productId, this.price, this.quantity, this.total);

  factory OrderProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderProductFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductToJson(this);
}
