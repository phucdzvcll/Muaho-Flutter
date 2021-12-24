import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'order_history_detail_response.g.dart';

@JsonSerializable()
class OrderHistoryDetailResponse {
  final int? orderId;
  final String? voucherCode;
  final double? totalBeforeDiscount;
  final double? voucherDiscount;
  final double? total;
  final String? deliveryAddress;
  @JsonKey(name: "deliveryPhone_number")
  final String? deliveryPhoneNumber;
  final int? shopId;
  final String? shopName;
  final String? shopAddress;
  final String? status;
  final List<ProductDetailResponse?>? products;

  factory OrderHistoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryDetailResponseToJson(this);

//<editor-fold desc="Data Methods">

  const OrderHistoryDetailResponse({
    this.orderId,
    this.voucherCode,
    this.totalBeforeDiscount,
    this.voucherDiscount,
    this.total,
    this.deliveryAddress,
    this.deliveryPhoneNumber,
    this.shopId,
    this.shopName,
    this.shopAddress,
    this.status,
    this.products,
  });
}

@JsonSerializable()
class ProductDetailResponse {
  final int? productId;
  final double? price;
  final int? quantity;
  final double? total;
  final String? productName;
  final String? productThumbUrl;

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailResponseToJson(this);

//<editor-fold desc="Data Methods">

  const ProductDetailResponse({
    this.productId,
    this.price,
    this.quantity,
    this.total,
    this.productName,
    this.productThumbUrl,
  });

  @override
  int get hashCode =>
      productId.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      total.hashCode ^
      productName.hashCode ^
      productThumbUrl.hashCode;

  @override
  String toString() {
    return 'ProductDetailResponse{' +
        ' productId: $productId,' +
        ' price: $price,' +
        ' quantity: $quantity,' +
        ' total: $total,' +
        ' productName: $productName,' +
        ' productThumbUrl: $productThumbUrl,' +
        '}';
  }

//</editor-fold>
}
