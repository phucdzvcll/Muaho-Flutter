// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryHomeResponse _$ProductCategoryHomeResponseFromJson(
        Map<String, dynamic> json) =>
    ProductCategoryHomeResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      thumbUrl: json['thumbUrl'] as String,
    );

Map<String, dynamic> _$ProductCategoryHomeResponseToJson(
        ProductCategoryHomeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbUrl': instance.thumbUrl,
    };
