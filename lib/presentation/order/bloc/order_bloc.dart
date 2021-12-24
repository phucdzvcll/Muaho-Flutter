import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/model/cart_store.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/use_case/shop/get_shop_product_use_case.dart';
import 'package:muaho/presentation/order/model/order_detail_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetShopProductUseCase getShopProductUseCase;
  final CartStore cartStore;

  OrderBloc({required this.getShopProductUseCase, required this.cartStore})
      : super(OrderInitial());

  List<ProductStore> _totalProducts = [];
  List<ProductStore> _currentProducts = [];

  List<ProductGroupEntity> _groups = [];

  String _shopName = "";
  String _address = "";
  int _shopID = -1;
  int _currentGroupId = -1;

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is GetShopDetailEvent) {
      yield* _handleRequestEvent(event);
    } else if (event is FilterProductEvent) {
      yield* _handleFilterEvent(event);
    } else if (event is AddToCartEvent) {
      yield* _handleAddToCartEvent(event);
    } else if (event is ChangeShopEvent) {
      yield* _handleChangeShopEvent(event);
    }
  }

  Stream<OrderState> _handleChangeShopEvent(ChangeShopEvent event) async* {
    cartStore.shopId = _shopID;
    cartStore.shopAddress = _address;
    cartStore.shopName = _shopName;
    cartStore.productStores.clear();
    cartStore.editCart(event.product);
    filterProductsByProductStore();
    yield OrderSuccess(shopDetailModel: mapOrderDetailModel());
  }

  Stream<OrderState> _handleAddToCartEvent(AddToCartEvent event) async* {
    if (cartStore.shopId == -1) {
      cartStore.shopId = _shopID;
      cartStore.shopAddress = _address;
      cartStore.shopName = _shopName;
    }
    cartStore.editCart(event.product);
    filterProductsByProductStore();
    yield OrderSuccess(shopDetailModel: mapOrderDetailModel());
  }

  Stream<OrderState> _handleRequestEvent(GetShopDetailEvent event) async* {
    Either<Failure, ShopProductEntity> result = await getShopProductUseCase
        .execute(ShopProductParam(shopID: event.shopID));
    yield OrderLoading();
    if (result.isSuccess) {
      _totalProducts.clear();
      _totalProducts.addAll(result.success.products.map((e) => mapProduct(e)));
      _shopName = result.success.shopName;
      _address = result.success.shopAddress;
      _groups.clear();
      _groups.addAll(result.success.groups);
      _shopID = event.shopID;
      filterProductsByGroup(-1);
      filterProductsByProductStore();
      yield OrderSuccess(shopDetailModel: mapOrderDetailModel());
    } else {
      yield OrderError();
    }
  }

  Stream<OrderState> _handleFilterEvent(FilterProductEvent event) async* {
    filterProductsByGroup(event.groupID);
    filterProductsByProductStore();
    _currentGroupId = event.groupID;
    yield OrderSuccess(shopDetailModel: mapOrderDetailModel());
  }

  void filterProductsByProductStore() {
    _currentProducts.asMap().forEach((index, product) {
      ProductStore productStore =
          cartStore.getProductQuantity(product.productId);

      if (product.productId == productStore.productId) {
        _currentProducts[index] = productStore;
      } else if (product.quantity > 0) {
        _currentProducts[index] = product.copyWith(quantity: 0);
      }
    });
  }

  void filterProductsByGroup(int groupID) {
    _currentProducts.clear();
    if (groupID == -1) {
      _currentProducts.addAll(_totalProducts);
    } else {
      _currentProducts.addAll(
          _totalProducts.where((element) => element.groupId == groupID));
    }
  }

  OrderDetailModel mapOrderDetailModel() {
    return OrderDetailModel(
        shopID: _shopID,
        currentGroupId: _currentGroupId,
        shopName: _shopName,
        shopAddress: _address,
        groups: _groups,
        currentListProducts: _currentProducts,
        cartOverView: cartStore.getCartOverView());
  }

  ProductStore mapProduct(ProductEntity productEntity) {
    return ProductStore(
      productId: productEntity.productId,
      productName: productEntity.productName,
      productPrice: productEntity.productPrice,
      groupId: productEntity.groupId,
      thumbUrl: productEntity.thumbUrl,
      quantity: 0,
      unit: productEntity.unit,
    );
  }
}
