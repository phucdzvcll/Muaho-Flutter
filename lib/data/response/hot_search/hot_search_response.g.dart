// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotSearchResponse _$HotSearchResponseFromJson(Map<String, dynamic> json) =>
    HotSearchResponse(
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => HotKeywordResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      shops: (json['shops'] as List<dynamic>?)
          ?.map((e) => HotShopResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HotSearchResponseToJson(HotSearchResponse instance) =>
    <String, dynamic>{
      'keywords': instance.keywords,
      'shops': instance.shops,
    };

HotKeywordResponse _$HotKeywordResponseFromJson(Map<String, dynamic> json) =>
    HotKeywordResponse(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$HotKeywordResponseToJson(HotKeywordResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

HotShopResponse _$HotShopResponseFromJson(Map<String, dynamic> json) =>
    HotShopResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      thumbUrl: json['thumbUrl'] as String?,
    );

Map<String, dynamic> _$HotShopResponseToJson(HotShopResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'thumbUrl': instance.thumbUrl,
    };
