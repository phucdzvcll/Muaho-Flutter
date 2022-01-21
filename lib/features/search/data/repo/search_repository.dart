import 'package:muaho/common/common.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/search/data/response/search_shop/shop_response_by_category.dart';
import 'package:muaho/features/search/data/services/search_service.dart';
import 'package:muaho/features/search/domain/models/hot_search/hot_keyword.dart';
import 'package:muaho/features/search/domain/models/hot_search/hot_shop.dart';
import 'package:muaho/features/search/domain/models/search_shop/seach_shop_by_keyword.dart';
import 'package:muaho/features/search/domain/models/search_shop/search_shop_by_category.dart';
import 'package:muaho/features/search/domain/repo/search_repository.dart';
import 'package:muaho/features/search/domain/use_case/get_list_hot_search_use_case.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchService searchService;

  SearchRepositoryImpl({required this.searchService});

  @override
  Future<Either<Failure, HostSearchResult>> getListHotSearch() async {
    var requestGetHotSearch = searchService.getHotSearch();
    var result = await handleNetworkResult(requestGetHotSearch);
    if (result.isSuccess()) {
      List<HotKeyword> keywords = [];
      List<HotShop> shops = [];

      result.response?.keywords?.forEach((element) {
        var keyword = HotKeyword(name: element.name.defaultEmpty());
        keywords.add(keyword);
      });

      result.response?.shops?.forEach((element) {
        var shop = HotShop(
            id: element.id.defaultZero(),
            name: element.name.defaultEmpty(),
            address: element.address.defaultEmpty(),
            thumbUrl: element.thumbUrl.defaultEmpty());
        shops.add(shop);
      });
      return SuccessValue(
          HostSearchResult(listHotKeywords: keywords, listHotShop: shops));
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }

  @override
  Future<Either<Failure, List<SearchShopByKeywordEntity>>> getListShopByKeyword(
      String keyword) async {
    var requestGetShop = searchService.getShop(keyword);
    var result = await handleNetworkResult(requestGetShop);
    if (result.isSuccess()) {
      List<SearchShopByKeywordEntity> shops = [];
      result.response?.forEach((element) {
        var shop = SearchShopByKeywordEntity(
            id: element.id.defaultZero(),
            name: element.name.defaultEmpty(),
            address: element.address.defaultEmpty(),
            thumbUrl: element.thumbUrl.defaultEmpty(),
            star: element.star.defaultZero());
        shops.add(shop);
      });
      return SuccessValue(shops);
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }

  @override
  Future<Either<Failure, SearchShopByCategoryEntity>> getListShopByCategory(
      int categoryID) async {
    NetworkResult<ShopCategoryResponse> result =
        await handleNetworkResult(searchService.getShopByCategory(categoryID));
    if (result.isSuccess()) {
      List<SearchShopByKeywordEntity> shops = [];

      result.response?.shops?.defaultEmpty().forEach((element) {
        var shop = SearchShopByKeywordEntity(
            id: element.id.defaultZero(),
            name: element.name.defaultEmpty(),
            address: element.address.defaultEmpty(),
            thumbUrl: element.thumbUrl.defaultEmpty(),
            star: element.star.defaultZero());
        shops.add(shop);
      });
      return SuccessValue(
        SearchShopByCategoryEntity(
            categoryId: (result.response?.categoryId).defaultZero(),
            category: (result.response?.category).defaultEmpty(),
            shops: shops),
      );
    } else {
      return FailValue(
        ServerError(msg: result.error, errorCode: result.errorCode),
      );
    }
  }
}
