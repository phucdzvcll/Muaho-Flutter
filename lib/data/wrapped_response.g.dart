// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrapped_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Header _$HeaderFromJson(Map<String, dynamic> json) => Header(
      isSuccessful: json['isSuccessful'] as bool?,
      resultCode: json['resultCode'] as int?,
      resultMessage: json['resultMessage'] as String?,
    );

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
      'isSuccessful': instance.isSuccessful,
      'resultCode': instance.resultCode,
      'resultMessage': instance.resultMessage,
    };
