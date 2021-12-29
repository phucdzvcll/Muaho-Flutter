import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_body.g.dart';

@JsonSerializable()
class OrderBody extends Equatable {
  final int? voucherId;
  final double totalBeforeDiscount;
  final double? voucherDiscount;
  final double total;
  final int deliveryAddressID;
  final int shopId;
  final List<OrderProduct> products;

  OrderBody(
      {required this.totalBeforeDiscount,
      required this.total,
      required this.deliveryAddressID,
      required this.shopId,
      required this.voucherDiscount,
      required this.voucherId,
      required this.products});

  factory OrderBody.fromJson(Map<String, dynamic> json) =>
      _$OrderBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBodyToJson(this);

  @override
  List<Object?> get props => [
        totalBeforeDiscount,
        total,
        deliveryAddressID,
        shopId,
        voucherDiscount,
        voucherId,
        products
      ];
}

@JsonSerializable()
class OrderProduct extends Equatable {
  final int productId;
  final double price;
  final int quantity;
  final double total;

  OrderProduct(
    this.productId,
    this.price,
    this.quantity,
    this.total,
  );

  factory OrderProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderProductFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductToJson(this);

  @override
  List<Object?> get props => [
        productId,
        price,
        quantity,
        total,
      ];
}
