import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:muaho/features/address_info/domain/models/address_entity.dart';
import 'package:muaho/features/order/domain/models/shop_product_entity.dart';

class CartSummary extends Equatable {
  final double totalAmount;
  final int itemQuantity;
  final int unitQuantity;

  CartSummary(
      {required this.totalAmount,
      required this.itemQuantity,
      required this.unitQuantity});

  @override
  List<Object?> get props => [
        totalAmount,
        itemQuantity,
        unitQuantity,
      ];
}

class CartShopInfo extends Equatable {
  final int shopID;
  final String shopName;
  final String shopAddress;

  CartShopInfo({
    required this.shopID,
    required this.shopName,
    required this.shopAddress,
  });

  @override
  List<Object?> get props => [
        shopID,
        shopID,
        shopAddress,
      ];
}

class CartInfo extends Equatable {
  final CartShopInfo cartShopInfo;
  final CartSummary cartSummary;
  final List<ProductEntity> productStores;
  final AddressInfoEntity? addressInfo;

  CartInfo({
    required this.cartSummary,
    required this.productStores,
    required this.cartShopInfo,
    required this.addressInfo,
  });

  @override
  List<Object?> get props => [
        cartSummary,
        productStores,
        cartShopInfo,
        addressInfo,
      ];
}

class CartStore {
  int shopId = -1;
  String shopName = "";
  String shopAddress = "";
  List<ProductEntity> productStores = [];
  AddressInfoEntity? _addressInfo;
  Stream<CartInfo>? _updateCartBroadcastStream;
  final StreamController<CartInfo> _updateCartController =
      new StreamController();

  void _sendUpdateCartEvent() {
    this._updateCartController.add(getCartInfo());
  }

  void close() {
    this._updateCartController.close();
  }

  Stream<CartInfo>? get updateCartBroadcastStream {
    return this._updateCartBroadcastStream;
  }

  void increaseProduct({required int productId}) {
    ProductEntity? product = findProductStore(productId);
    if (product != null) {
      int index = getIndexOfProduct(productId);
      productStores[index] = product.copyWith(quantity: product.quantity + 1);
      _sendUpdateCartEvent();
    }
  }

  AddToCartResult addToCart(
      {required ProductEntity productStore,
      required int shopId,
      required String shopAddress,
      required String shopName}) {
    if (this.shopId == -1) {
      this.shopId = shopId;
      this.shopAddress = shopAddress;
      this.shopName = shopName;
    }
    if (shopId == this.shopId) {
      ProductEntity? product = findProductStore(productStore.productId);
      if (product != null) {
        int index = getIndexOfProduct(productStore.productId);
        productStores[index] =
            product.copyWith(quantity: productStore.quantity + 1);
      } else {
        this.productStores.add(productStore.copyWith(quantity: 1));
      }
      _sendUpdateCartEvent();

      return AddToCartResult.Success;
    } else {
      return AddToCartResult.WarningChangeShop;
    }
  }

  void deleteProduct({required int productID}) {
    ProductEntity? productStore = findProductStore(productID);
    if (productStore != null) {
      int index = getIndexOfProduct(productID);
      this.productStores.removeAt(index);
    }
    if (this.productStores.isEmpty) {
      _clearStore();
    }
    _sendUpdateCartEvent();
  }

  void removeProduct({required int productID}) {
    ProductEntity? productStore = findProductStore(productID);
    if (productStore != null) {
      int index = getIndexOfProduct(productID);
      if (productStore.quantity == 1) {
        this.productStores.removeAt(index);
      } else {
        productStores[index] =
            productStore.copyWith(quantity: productStore.quantity - 1);
      }
    }
    if (this.productStores.isEmpty) {
      _clearStore();
    }
    _sendUpdateCartEvent();
  }

  ReducedResult reducedProduct({required int productID}) {
    ProductEntity? productStore = findProductStore(productID);
    if (productStore != null) {
      int index = getIndexOfProduct(productID);
      if (productStore.quantity == 1) {
        return ReducedResult.WarningRemove;
      } else {
        productStores[index] =
            productStore.copyWith(quantity: productStore.quantity - 1);
        _sendUpdateCartEvent();
        return ReducedResult.Success;
      }
    } else {
      return ReducedResult.NotFound;
    }
  }

  updateAddressInfo(AddressInfoEntity addressInfo) {
    this._addressInfo = addressInfo;
    _sendUpdateCartEvent();
  }

  getAddressInfo() {
    return this._addressInfo;
  }

  CartInfo getCartInfo() {
    return CartInfo(
      cartSummary: getCartOverView(),
      productStores: this.productStores,
      cartShopInfo: CartShopInfo(
        shopID: shopId,
        shopName: shopName,
        shopAddress: shopAddress,
      ),
      addressInfo: _addressInfo,
    );
  }

  CartSummary getCartOverView() {
    int itemQuantity = 0;
    int unitQuantity = 0;
    double totalPrice = 0.0;

    if (this.productStores.isNotEmpty) {
      this.productStores.forEach((element) {
        if (element.quantity > 0) {
          itemQuantity += element.quantity;
          unitQuantity += 1;
          totalPrice += element.quantity * element.productPrice;
        }
      });
    }
    return CartSummary(
      totalAmount: totalPrice,
      itemQuantity: itemQuantity,
      unitQuantity: unitQuantity,
    );
  }

  void _clearStore() {
    this.shopId = -1;
    this.productStores.clear();
    this.shopName = "";
    this.shopAddress = "";
    _sendUpdateCartEvent();
  }

  void createOrderSuccess() {
    _clearStore();
  }

  void logout() {
    _clearStore();
    this._addressInfo = null;
    _sendUpdateCartEvent();
  }

  int getIndexOfProduct(int productID) {
    int index = -1;
    this.productStores.asMap().forEach((i, element) {
      if (element.productId == productID) {
        index = i;
      }
    });
    return index;
  }

  ProductEntity? findProductStore(int productID) {
    return this
        .productStores
        .firstWhereOrNull((element) => element.productId == productID);
  }

  CartStore() {
    _updateCartBroadcastStream =
        _updateCartController.stream.asBroadcastStream();
  }

  void changeShop(
      {required int shopId,
      required String shopAddress,
      required String shopName}) {
    _clearStore();
    this.shopId = shopId;
    this.shopAddress = shopAddress;
    this.shopName = shopName;
    _sendUpdateCartEvent();
  }
}

enum AddToCartResult {
  Success,
  WarningChangeShop,
}

enum ReducedResult {
  Success,
  WarningRemove,
  NotFound,
}
