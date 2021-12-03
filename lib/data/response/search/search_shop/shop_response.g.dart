// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopResponse _$ShopResponseFromJson(Map<String, dynamic> json) => ShopResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      thumbUrl: json['thumb_url'] as String?,
      star: (json['star'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ShopResponseToJson(ShopResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'thumb_url': instance.thumbUrl,
      'star': instance.star,
    };
