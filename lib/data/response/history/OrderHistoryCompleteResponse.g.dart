// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderHistoryCompleteResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryCompleteResponse _$OrderHistoryCompleteResponseFromJson(
        Map<String, dynamic> json) =>
    OrderHistoryCompleteResponse(
      orderId: json['orderId'] as int?,
      orderCode: json['orderCode'] as String?,
      shopName: json['shopName'] as String?,
      itemCount: json['itemCount'] as int?,
      total: (json['total'] as num?)?.toDouble(),
      status: json['status'] as String?,
      thumbUrl: json['thumbUrl'] as String?,
    );

Map<String, dynamic> _$OrderHistoryCompleteResponseToJson(
        OrderHistoryCompleteResponse instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderCode': instance.orderCode,
      'shopName': instance.shopName,
      'itemCount': instance.itemCount,
      'total': instance.total,
      'status': instance.status,
      'thumbUrl': instance.thumbUrl,
    };
