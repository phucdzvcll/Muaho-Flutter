import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/search/domain/models/search_shop/seach_shop_by_keyword.dart';
import 'package:muaho/features/search/domain/models/search_shop/search_shop_by_category.dart';
import 'package:muaho/features/search/domain/use_case/get_list_hot_search_use_case.dart';

abstract class SearchRepository {
  Future<Either<Failure, HostSearchResult>> getListHotSearch();

  Future<Either<Failure, List<SearchShopByKeywordEntity>>> getListShopByKeyword(
      String keyword);

  Future<Either<Failure, SearchShopByCategoryEntity>> getListShopByCategory(
      int categoryID);
}
