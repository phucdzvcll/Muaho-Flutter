// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBody _$OrderBodyFromJson(Map<String, dynamic> json) => OrderBody(
      totalBeforeDiscount: (json['totalBeforeDiscount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      deliveryAddressID: json['deliveryAddressID'] as int,
      shopId: json['shopId'] as int,
      voucherDiscount: (json['voucherDiscount'] as num?)?.toDouble(),
      voucherId: json['voucherId'] as int?,
      products: (json['products'] as List<dynamic>)
          .map((e) => OrderProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderBodyToJson(OrderBody instance) => <String, dynamic>{
      'voucherId': instance.voucherId,
      'totalBeforeDiscount': instance.totalBeforeDiscount,
      'voucherDiscount': instance.voucherDiscount,
      'total': instance.total,
      'deliveryAddressID': instance.deliveryAddressID,
      'shopId': instance.shopId,
      'products': instance.products,
    };

OrderProduct _$OrderProductFromJson(Map<String, dynamic> json) => OrderProduct(
      json['productId'] as int,
      (json['price'] as num).toDouble(),
      json['quantity'] as int,
      (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderProductToJson(OrderProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'price': instance.price,
      'quantity': instance.quantity,
      'total': instance.total,
    };
