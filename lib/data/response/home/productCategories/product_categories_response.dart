import 'package:json_annotation/json_annotation.dart';

part 'product_categories_response.g.dart';

@JsonSerializable()
class ProductCategoryHomeResponse {
  final int? id;
  final String? name;
  final String? thumbUrl;

  factory ProductCategoryHomeResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryHomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryHomeResponseToJson(this);

//<editor-fold desc="Data Methods">

  const ProductCategoryHomeResponse({
    required this.id,
    required this.name,
    required this.thumbUrl,
  });

  @override
  String toString() {
    return 'ProductCategoryHomeResponse{' +
        ' id: $id,' +
        ' name: $name,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

//</editor-fold>
}
