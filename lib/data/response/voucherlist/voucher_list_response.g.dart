// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherListResponse _$VoucherListResponseFromJson(Map<String, dynamic> json) =>
    VoucherListResponse(
      id: json['id'] as int?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      type: json['type'] as String?,
      minOrderTotal: json['minOrderTotal'] as int?,
      isApplyForAllShop: json['isApplyForAllShop'] as bool?,
      shops: (json['shops'] as List<dynamic>?)?.map((e) => e as int).toList(),
      lastDate: json['lastDate'] == null
          ? null
          : DateTime.parse(json['lastDate'] as String),
    );

Map<String, dynamic> _$VoucherListResponseToJson(
        VoucherListResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'value': instance.value,
      'type': instance.type,
      'minOrderTotal': instance.minOrderTotal,
      'isApplyForAllShop': instance.isApplyForAllShop,
      'shops': instance.shops,
      'lastDate': instance.lastDate?.toIso8601String(),
    };
