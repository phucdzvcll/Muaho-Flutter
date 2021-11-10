import 'package:get_it/get_it.dart';
import 'package:muaho/common/common.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/data/remote/search/search_service.dart';
import 'package:muaho/domain/common/either.dart';
import 'package:muaho/domain/common/failure.dart';
import 'package:muaho/domain/models/search/hot_keyword.dart';
import 'package:muaho/domain/models/search/hot_shop.dart';
import 'package:muaho/domain/repository/search_page_repository.dart';
import 'package:muaho/domain/use_case/search/get_list_hot_search_use_case.dart';

class SearchRepositoryImpl implements SearchPageRepository {
  SearchService searchService = GetIt.instance.get();

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
      return FailValue(Failure());
    }
  }
}
