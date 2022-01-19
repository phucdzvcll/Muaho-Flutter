import 'package:equatable/equatable.dart';
import 'package:muaho/features/search/domain/models/search_shop/seach_shop_by_keyword.dart';

class SearchShopByCategoryEntity extends Equatable {
  final int categoryId;
  final String category;
  final List<SearchShopByKeywordEntity> shops;

  const SearchShopByCategoryEntity({
    required this.categoryId,
    required this.category,
    required this.shops,
  });

  @override
  List<Object?> get props => [categoryId, category, shops];
}
