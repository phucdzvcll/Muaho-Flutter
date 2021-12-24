// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryDetailResponse _$OrderHistoryDetailResponseFromJson(
        Map<String, dynamic> json) =>
    OrderHistoryDetailResponse(
      orderId: json['orderId'] as int?,
      voucherCode: json['voucherCode'] as String?,
      totalBeforeDiscount: (json['totalBeforeDiscount'] as num?)?.toDouble(),
      voucherDiscount: (json['voucherDiscount'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      deliveryAddress: json['deliveryAddress'] as String?,
      deliveryPhoneNumber: json['deliveryPhone_number'] as String?,
      shopId: json['shopId'] as int?,
      shopName: json['shopName'] as String?,
      shopAddress: json['shopAddress'] as String?,
      status: json['status'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ProductDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderHistoryDetailResponseToJson(
        OrderHistoryDetailResponse instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'voucherCode': instance.voucherCode,
      'totalBeforeDiscount': instance.totalBeforeDiscount,
      'voucherDiscount': instance.voucherDiscount,
      'total': instance.total,
      'deliveryAddress': instance.deliveryAddress,
      'deliveryPhone_number': instance.deliveryPhoneNumber,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'shopAddress': instance.shopAddress,
      'status': instance.status,
      'products': instance.products,
    };

ProductDetailResponse _$ProductDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ProductDetailResponse(
      productId: json['productId'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      total: (json['total'] as num?)?.toDouble(),
      productName: json['productName'] as String?,
      productThumbUrl: json['productThumbUrl'] as String?,
    );

Map<String, dynamic> _$ProductDetailResponseToJson(
        ProductDetailResponse instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'price': instance.price,
      'quantity': instance.quantity,
      'total': instance.total,
      'productName': instance.productName,
      'productThumbUrl': instance.productThumbUrl,
    };
