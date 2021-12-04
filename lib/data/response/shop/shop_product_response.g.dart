// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopProductResponse _$ShopProductResponseFromJson(Map<String, dynamic> json) =>
    ShopProductResponse(
      shopId: json['shopId'] as int,
      shopName: json['shopName'] as String,
      shopAddress: json['shopAddress'] as String?,
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ProductGroupResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      vouchers: (json['vouchers'] as List<dynamic>?)
          ?.map((e) => ShopVoucherResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShopProductResponseToJson(
        ShopProductResponse instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'shopAddress': instance.shopAddress,
      'groups': instance.groups,
      'vouchers': instance.vouchers,
    };

ProductGroupResponse _$ProductGroupResponseFromJson(
        Map<String, dynamic> json) =>
    ProductGroupResponse(
      groupId: json['groupId'] as int,
      groupName: json['groupName'] as String,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductGroupResponseToJson(
        ProductGroupResponse instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'products': instance.products,
    };

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      productPrice: (json['produtPrice'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      thumbUrl: json['thumbUrl'] as String?,
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'produtPrice': instance.productPrice,
      'unit': instance.unit,
      'thumbUrl': instance.thumbUrl,
    };

ShopVoucherResponse _$ShopVoucherResponseFromJson(Map<String, dynamic> json) =>
    ShopVoucherResponse(
      id: json['id'] as int,
      code: json['code'] as String,
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$ShopVoucherResponseToJson(
        ShopVoucherResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
    };
