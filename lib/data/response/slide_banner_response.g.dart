// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide_banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlideBannerResponse _$SlideBannerResponseFromJson(Map<String, dynamic> json) =>
    SlideBannerResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..header = json['header'] == null
        ? null
        : Header.fromJson(json['header'] as Map<String, dynamic>);

Map<String, dynamic> _$SlideBannerResponseToJson(
        SlideBannerResponse instance) =>
    <String, dynamic>{
      'header': instance.header,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int?,
      subject: json['subject'] as String?,
      description: json['description'] as String?,
      thumbUrl: json['thumbUrl'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'description': instance.description,
      'thumbUrl': instance.thumbUrl,
    };
