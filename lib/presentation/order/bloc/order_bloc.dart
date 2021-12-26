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

class _OrderSuccessEvent extends OrderEvent {}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetShopProductUseCase getShopProductUseCase;
  final CartUpdateBloc cartUpdateBloc;
  StreamSubscription<CartUpdateState>? _cartUpdateSubscription;

  OrderBloc({
    required this.getShopProductUseCase,
    required this.cartUpdateBloc,
  }) : super(OrderInitial()) {
    _cartUpdateSubscription =
        cartUpdateBloc.stream.asBroadcastStream().listen((event) {
      _handleCartUpdate();
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
  Future<void> close() {
    _cartUpdateSubscription?.cancel();
    return super.close();
  }

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
    } else if (event is _OrderSuccessEvent) {
      filterProductsByProductStore();
      yield (OrderSuccess(shopDetailModel: mapOrderDetailModel()));
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
          cartUpdateBloc.cartStore.findProductStore(product.productId);
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
        cartInfo: cartUpdateBloc.cartStore.getCartOverView());
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
    AddToCartResult addToCart = cartUpdateBloc.cartStore.addToCart(
        productStore: event.productStore,
        shopId: _shopID,
        shopAddress: _address,
        shopName: _shopName);
    switch (addToCart) {
      case AddToCartResult.Success:
        //nothing to do here
        break;
      case AddToCartResult.WarningChangeShop:
        yield WarningChangeShop(productStore: event.productStore);
        break;
    }
  }

  Stream<OrderState> _handleReducedProductEventEvent(
      ReducedProductEvent event) async* {
    ReducedResult reducedProduct =
        cartUpdateBloc.cartStore.reducedProduct(productID: event.productID);
    switch (reducedProduct) {
      case ReducedResult.Success:
        //nothing to do here
        break;
      case ReducedResult.WarningRemove:
        yield WarningRemoveProduct(productID: event.productID);
        break;
      case ReducedResult.NotFound:
        // todo Handle this case not found.
        break;
    }
  }

  Stream<OrderState> _handleRemoveProductEvent(
      RemoveProductEvent event) async* {
    cartUpdateBloc.cartStore.removeProduct(productID: event.productID);
  }

  Stream<OrderState> _handleChangeShopEvent(ChangeShopEvent event) async* {
    cartUpdateBloc.cartStore.changeShop(
        shopId: _shopID, shopAddress: _address, shopName: _shopName);
    cartUpdateBloc.cartStore.addToCart(
        productStore: event.productStore,
        shopName: _shopName,
        shopAddress: _address,
        shopId: _shopID);
  }

  void _handleCartUpdate() {
    this.add(_OrderSuccessEvent());
  }
}
