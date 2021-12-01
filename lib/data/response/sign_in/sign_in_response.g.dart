// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      jwtToken: json['jwtToken'] as String?,
      userName: json['userName'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'jwtToken': instance.jwtToken,
      'userName': instance.userName,
      'refreshToken': instance.refreshToken,
    };
