import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/model/cart_store.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/presentation/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/presentation/order/model/order_detail_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetShopProductUseCase getShopProductUseCase;
  final CartStore cartStore;
  final CartUpdateBloc cartUpdateBloc;
  StreamSubscription<CartInfo>? _updateCartStreamSubscription;

  OrderBloc({
    required this.getShopProductUseCase,
    required this.cartStore,
    required this.cartUpdateBloc,
  }) : super(OrderInitial()) {
    this._updateCartStreamSubscription =
        cartStore.updateCartBroadcastStream?.listen((event) {
      cartUpdateBloc.add(UpdateCartEvent(cartInfo: event));
    });
  }

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
    } else if (event is ReducedProductEvent) {
      yield* _handleReducedProductEventEvent(event);
    } else if (event is RemoveProductEvent) {
      yield* _handleRemoveProductEvent(event);
    } else if (event is ChangeShopEvent) {
      yield* _handleChangeShopEvent(event);
    }
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
      ProductStore? productStore =
          cartStore.findProductStore(product.productId);
      if (productStore != null) {
        if (product.productId == productStore.productId) {
          _currentProducts[index] = productStore;
        } else if (product.quantity > 0) {
          _currentProducts[index] = product.copyWith(quantity: 0);
        }
      } else {
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
        cartInfo: cartStore.getCartOverView());
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

  Stream<OrderState> _handleAddToCartEvent(AddToCartEvent event) async* {
    if (cartStore.shopId == -1) {
      cartStore.shopId = _shopID;
      cartStore.shopAddress = _address;
      cartStore.shopName = _shopName;
    }
    if (event.shopID == cartStore.shopId) {
      cartStore.addToCart(productStore: event.productStore);
      filterProductsByProductStore();
      yield OrderSuccess(shopDetailModel: mapOrderDetailModel());
    } else {
      yield WarningChangeShop(productStore: event.productStore);
    }
  }

  Stream<OrderState> _handleReducedProductEventEvent(
      ReducedProductEvent event) async* {
    if (event.productQuantity > 1) {
      cartStore.removeToCart(productID: event.productID);
      filterProductsByProductStore();
      yield OrderSuccess(shopDetailModel: mapOrderDetailModel());
    } else {
      yield WarningRemoveProduct(productID: event.productID);
    }
  }

  Stream<OrderState> _handleRemoveProductEvent(
      RemoveProductEvent event) async* {
    cartStore.removeToCart(productID: event.productID);
    filterProductsByProductStore();
    yield OrderSuccess(shopDetailModel: mapOrderDetailModel());
  }

  Stream<OrderState> _handleChangeShopEvent(ChangeShopEvent event) async* {
    cartStore.clearStore();
    cartStore.addToCart(productStore: event.productStore);
    cartStore.shopId = _shopID;
    cartStore.shopAddress = _address;
    cartStore.shopName = _shopName;
    filterProductsByProductStore();
    yield OrderSuccess(shopDetailModel: mapOrderDetailModel());
  }

  @override
  Future<void> close() {
    _updateCartStreamSubscription?.cancel();
    return super.close();
  }
}
