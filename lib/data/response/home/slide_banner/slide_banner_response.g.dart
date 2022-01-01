// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide_banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlideBannerResponse _$SlideBannerResponseFromJson(Map<String, dynamic> json) =>
    SlideBannerResponse(
      id: json['id'] as int?,
      subject: json['subject'] as String?,
      description: json['description'] as String?,
      thumbUrl: json['thumbUrl'] as String?,
      deeplink: json['deeplink'] as String?,
    );

Map<String, dynamic> _$SlideBannerResponseToJson(
        SlideBannerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'description': instance.description,
      'thumbUrl': instance.thumbUrl,
      'deeplink': instance.deeplink,
    };
