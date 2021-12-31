// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_address_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAddressBody _$CreateAddressBodyFromJson(Map<String, dynamic> json) =>
    CreateAddressBody(
      address: json['address'] as String,
      phoneNumber: json['contact_phone_number'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$CreateAddressBodyToJson(CreateAddressBody instance) =>
    <String, dynamic>{
      'address': instance.address,
      'contact_phone_number': instance.phoneNumber,
      'lat': instance.lat,
      'lng': instance.lng,
    };
