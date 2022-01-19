import 'package:equatable/equatable.dart';
import 'package:muaho/common/object_parse_ext.dart';
import 'package:muaho/features/search/data/response/search_shop/shop_response_by_keyword.dart';

class ShopCategoryResponse extends Equatable {
  final int? categoryId;
  final String? category;
  final List<ShopResponse>? shops;

  const ShopCategoryResponse({
    this.categoryId,
    this.category,
    this.shops,
  });

  @override
  List<Object?> get props => [categoryId, category, shops];

  factory ShopCategoryResponse.fromJson(Map<String, dynamic> json) {
    return ShopCategoryResponse(
        categoryId: json.parseInt('id'),
        category: json.parseString('name'),
        shops: json.parseListObject("shopSearchs", ShopResponse.fromJson));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = categoryId;
    data['name'] = category;
    if (shops != null) {
      data['shopSearchs'] = shops?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
