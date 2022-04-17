import 'package:muaho/features/search/data/response/hot_search/hot_search_response.dart';
import 'package:muaho/features/search/data/response/search_shop/shop_response_by_category.dart';
import 'package:muaho/features/search/data/response/search_shop/shop_response_by_keyword.dart';
import 'package:muaho/features/search/data/services/search_service.dart';

class SearchServiceImpl implements SearchService {
  Future<HotSearchResponse>? _hotSearchResponse;
  Future<List<ShopResponse>>? _listShopResponse;
  Future<ShopCategoryResponse>? _shopCategoryResoponse;

  set hotSearchResponse(Future<HotSearchResponse> value) =>
      this._hotSearchResponse = value;

  set listShopResponse(Future<List<ShopResponse>> value) =>
      this._listShopResponse = value;

  set shopCategoryResoponse(Future<ShopCategoryResponse> value) =>
      this._shopCategoryResoponse = value;

  int _countCallGetHotSearch = 0;
  int _countCallGetShop = 0;
  int _countCallGetShopByCategory = 0;

  int get countCallGetHotSearch => this._countCallGetHotSearch;

  int get countCallGetShop => this._countCallGetShop;

  int get countCallGetShopByCategory => this._countCallGetShopByCategory;

  SearchServiceImpl();

  @override
  Future<HotSearchResponse> getHotSearch() {
    _countCallGetHotSearch++;
    var hotSearchResponse = _hotSearchResponse;
    if (hotSearchResponse != null) {
      return hotSearchResponse;
    }
    throw Exception();
  }

  @override
  Future<List<ShopResponse>> getShop(String keyword) {
    _countCallGetShop++;
    var listShopResponse = _listShopResponse;
    if (listShopResponse != null) {
      return listShopResponse;
    }
    throw Exception();
  }

  @override
  Future<ShopCategoryResponse> getShopByCategory(int categoryID) {
    _countCallGetShopByCategory++;
    var shopCategoryResoponse = _shopCategoryResoponse;
    if (shopCategoryResoponse != null) {
      return shopCategoryResoponse;
    }
    throw Exception();
  }
}
