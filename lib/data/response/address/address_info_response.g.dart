// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressInfoResponse _$AddressInfoResponseFromJson(Map<String, dynamic> json) =>
    AddressInfoResponse(
      id: json['id'] as int?,
      contactPhoneNumber: json['contact_phone_number'] as String?,
      address: json['address'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
    );

Map<String, dynamic> _$AddressInfoResponseToJson(
        AddressInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contact_phone_number': instance.contactPhoneNumber,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'create_date': instance.createDate?.toIso8601String(),
    };
