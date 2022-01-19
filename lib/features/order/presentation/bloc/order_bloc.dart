import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/model/cart_store.dart';
import 'package:muaho/features/cart_update_bloc/cart_update_bloc.dart';
import 'package:muaho/features/order/domain/models/shop_product_entity.dart';
import 'package:muaho/features/order/domain/use_case/get_shop_product_use_case.dart';
import 'package:muaho/features/order/presentation/model/order_detail_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class _OrderSuccessEvent extends OrderEvent {
  @override
  List<Object?> get props => [];
}

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

    on<GetShopDetailEvent>((event, emit) async {
      await _handleRequestEvent(event, emit);
    });

    on<FilterProductEvent>((event, emit) async {
      await _handleFilterEvent(event, emit);
    });

    on<AddToCartEvent>((event, emit) async {
      await _handleAddToCartEvent(event, emit);
    });

    on<ReducedProductEvent>((event, emit) async {
      await _handleReducedProductEventEvent(event, emit);
    });

    on<RemoveProductEvent>((event, emit) async {
      await _handleRemoveProductEvent(event, emit);
    });

    on<ChangeShopEvent>((event, emit) async {
      await _handleChangeShopEvent(event, emit);
    });

    on<_OrderSuccessEvent>((event, emit) async {
      filterProductsByProductStore();
      emit(OrderSuccess(shopDetailModel: mapOrderDetailModel()));
    });
  }

  List<ProductEntity> _totalProducts = [];
  List<ProductEntity> _currentProducts = [];

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

  Future _handleRequestEvent(
      GetShopDetailEvent event, Emitter<OrderState> emit) async {
    Either<Failure, ShopProductEntity> result = await getShopProductUseCase
        .execute(ShopProductParam(shopID: event.shopID));
    emit(OrderLoading());
    if (result.isSuccess) {
      _totalProducts.clear();
      _totalProducts.addAll(result.success.products);
      _shopName = result.success.shopName;
      _address = result.success.shopAddress;
      _groups.clear();
      _groups.addAll(result.success.groups);
      _shopID = event.shopID;
      filterProductsByGroup(-1);
      filterProductsByProductStore();
      emit(OrderSuccess(shopDetailModel: mapOrderDetailModel()));
    } else {
      emit(OrderError());
    }
  }

  Future _handleFilterEvent(
      FilterProductEvent event, Emitter<OrderState> emit) async {
    filterProductsByGroup(event.groupID);
    filterProductsByProductStore();
    _currentGroupId = event.groupID;
    emit(OrderSuccess(shopDetailModel: mapOrderDetailModel()));
  }

  void filterProductsByProductStore() {
    _currentProducts.asMap().forEach((index, product) {
      ProductEntity? productStore =
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

  Future _handleAddToCartEvent(
      AddToCartEvent event, Emitter<OrderState> emit) async {
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
        emit(WarningChangeShop(productStore: event.productStore));
        break;
    }
  }

  Future _handleReducedProductEventEvent(
      ReducedProductEvent event, Emitter<OrderState> emit) async {
    ReducedResult reducedProduct =
        cartUpdateBloc.cartStore.reducedProduct(productID: event.productID);
    switch (reducedProduct) {
      case ReducedResult.Success:
        //nothing to do here
        break;
      case ReducedResult.WarningRemove:
        emit(WarningRemoveProduct(productID: event.productID));
        break;
      case ReducedResult.NotFound:
        // todo Handle this case not found.
        break;
    }
  }

  Future _handleRemoveProductEvent(
      RemoveProductEvent event, Emitter<OrderState> emit) async {
    cartUpdateBloc.cartStore.removeProduct(productID: event.productID);
  }

  Future _handleChangeShopEvent(
      ChangeShopEvent event, Emitter<OrderState> emit) async {
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
