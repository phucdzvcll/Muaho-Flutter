import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_history_detail_response.g.dart';

@JsonSerializable()
class OrderHistoryDetailResponse extends Equatable {
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

  OrderHistoryDetailResponse({
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

  Map<String, dynamic> toJson() => _$OrderHistoryDetailResponseToJson(this);

  @override
  List<Object?> get props => [
        orderId,
        voucherCode,
        totalBeforeDiscount,
        voucherDiscount,
        total,
        deliveryAddress,
        deliveryPhoneNumber,
        shopId,
        shopName,
        shopAddress,
        status,
        products,
      ];
}

@JsonSerializable()
class ProductDetailResponse extends Equatable {
  final int? productId;
  final double? price;
  final int? quantity;
  final double? total;
  final String? productName;
  final String? productThumbUrl;

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailResponseToJson(this);

  const ProductDetailResponse({
    this.productId,
    this.price,
    this.quantity,
    this.total,
    this.productName,
    this.productThumbUrl,
  });

  @override
  List<Object?> get props => [
        productId,
        price,
        quantity,
        total,
        productName,
        productThumbUrl,
      ];
}
