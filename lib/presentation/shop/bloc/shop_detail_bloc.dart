import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/shop/get_shop_product_use_case.dart';
import 'package:muaho/presentation/shop/model/product_model.dart';
import 'package:muaho/presentation/shop/model/shop_detail_model.dart';

part 'shop_detail_event.dart';
part 'shop_detail_state.dart';

class ShopDetailBloc extends Bloc<ShopDetailEvent, ShopDetailState> {
  GetShopProductUseCase _useCase = GetIt.instance.get();

  ShopDetailBloc() : super(ShopDetailInitial());

  List<Product> _products = [];
  List<Product> _currentProducts = [];

  List<ProductGroupEntity> _groups = [];

  String _shopName = "";
  String _address = "";

  @override
  Stream<ShopDetailState> mapEventToState(ShopDetailEvent event) async* {
    if (event is GetShopDetailEvent) {
      yield* _handleRequestEvent(event);
    } else if (event is FilterProductEvent) {
      yield* _handleFilterEvent(event);
    }
  }

  Stream<ShopDetailState> _handleRequestEvent(GetShopDetailEvent event) async* {
    Either<Failure, ShopProductEntity> result =
        await _useCase.execute(ShopProductParam(shopID: event.shopID));
    yield ShopDetailLoading();
    if (result.isSuccess) {
      _products.addAll(result.success.products.map((e) => mapProduct(e)));
      _shopName = result.success.shopName;
      _address = result.success.shopAddress;
      _groups.addAll(result.success.groups);

      yield ShopDetailSuccess(
          shopDetailModel: ShopDetailModel(
              currentIndex: -1,
              shopName: _shopName,
              shopAddress: _address,
              groups: _groups,
              currentListProducts: _products));
    } else {
      yield ShopDetailError();
    }
  }

  Product mapProduct(ProductEntity productEntity) {
    return Product(
      productId: productEntity.productId,
      productName: productEntity.productName,
      productPrice: productEntity.productPrice,
      groupId: productEntity.groupId,
      thumbUrl: productEntity.thumbUrl,
      price: productEntity.productPrice.formatDouble() +
          "k/${productEntity.unit.toLowerCase()}",
    );
  }

  Stream<ShopDetailState> _handleFilterEvent(FilterProductEvent event) async* {
    filterProducts(event.groupID);
    yield ShopDetailSuccess(
        shopDetailModel: ShopDetailModel(
            currentIndex: event.groupID,
            shopName: _shopName,
            shopAddress: _address,
            groups: _groups,
            currentListProducts: _currentProducts));
  }

  void filterProducts(int groupID) {
    if (groupID == -1) {
      _currentProducts.clear();
      _currentProducts.addAll(_products);
    } else if (_products.isNotEmpty) {
      _currentProducts.clear();
      _currentProducts
          .addAll(_products.where((element) => element.groupId == groupID));
    } else {
      _currentProducts.clear();
    }
  }
}
