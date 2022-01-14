import 'package:muaho/common/common.dart';
import 'package:muaho/data/remote/search/search_service.dart';
import 'package:muaho/domain/domain.dart';

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
  Future<Either<Failure, List<SearchShop>>> getListShop(String keyword) async {
    var requestGetShop = searchService.getShop(keyword);
    var result = await handleNetworkResult(requestGetShop);
    if (result.isSuccess()) {
      List<SearchShop> shops = [];
      result.response?.forEach((element) {
        var shop = SearchShop(
            id: element.id.defaultZero(),
            name: element.name.defaultEmpty(),
            address: element.address.defaultEmpty(),
            thumbUrl: element.thumb_url.defaultEmpty(),
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
}
