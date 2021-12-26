import 'dart:async';

import 'package:collection/collection.dart';

class CartInfo {
  final double totalAmount;
  final int itemQuantity;
  final int unitQuantity;
  CartInfo(
      {required this.totalAmount,
      required this.itemQuantity,
      required this.unitQuantity});
}

class CartStore {
  int shopId = -1;
  String shopName = "";
  String shopAddress = "";
  List<ProductStore> productStores = [];
  Stream<CartInfo>? _updateCartBroadcastStream;
  final StreamController<CartInfo> _updateCartController =
      new StreamController();

  void _sendUpdateCartEvent() {
    this._updateCartController.add(getCartOverView());
  }

  void close() {
    this._updateCartController.close();
  }

  Stream<CartInfo>? get updateCartBroadcastStream {
    return this._updateCartBroadcastStream;
  }

  void addToCart({required ProductStore productStore}) {
    ProductStore? product = findProductStore(productStore.productId);
    if (product != null) {
      int index = getIndexOfProduct(productStore.productId);
      productStores[index] =
          productStore.copyWith(quantity: productStore.quantity + 1);
    } else {
      this.productStores.add(productStore.copyWith(quantity: 1));
    }
    _sendUpdateCartEvent();
  }

  void removeToCart({required int productID}) {
    ProductStore? productStore = findProductStore(productID);
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
      clearStore();
    }
    _sendUpdateCartEvent();
  }

  CartInfo getCartOverView() {
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
    return CartInfo(
      totalAmount: totalPrice,
      itemQuantity: itemQuantity,
      unitQuantity: unitQuantity,
    );
  }

  void clearStore() {
    this.shopId = -1;
    this.productStores.clear();
    this.shopName = "";
    this.shopAddress = "";
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

  ProductStore? findProductStore(int productID) {
    return this
        .productStores
        .firstWhereOrNull((element) => element.productId == productID);
  }

//<editor-fold desc="Data Methods">

  CartStore() {
    _updateCartBroadcastStream =
        _updateCartController.stream.asBroadcastStream();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartStore &&
          runtimeType == other.runtimeType &&
          shopId == other.shopId &&
          shopName == other.shopName &&
          shopAddress == other.shopAddress &&
          productStores == other.productStores);

  @override
  int get hashCode =>
      shopId.hashCode ^
      shopName.hashCode ^
      shopAddress.hashCode ^
      productStores.hashCode;

  @override
  String toString() {
    return 'CartStore{' +
        ' shopId: $shopId,' +
        ' shopName: $shopName,' +
        ' shopAddress: $shopAddress,' +
        ' productStores: $productStores,' +
        '}';
  }

//</editor-fold>
}

class ProductStore {
  final int productId;
  final String productName;
  final double productPrice;
  final int groupId;
  final String unit;
  final String thumbUrl;
  final int quantity;

//<editor-fold desc="Data Methods">

  const ProductStore({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.groupId,
    required this.unit,
    required this.thumbUrl,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductStore &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          productName == other.productName &&
          productPrice == other.productPrice &&
          groupId == other.groupId &&
          unit == other.unit &&
          thumbUrl == other.thumbUrl &&
          quantity == other.quantity);

  @override
  int get hashCode =>
      productId.hashCode ^
      productName.hashCode ^
      productPrice.hashCode ^
      groupId.hashCode ^
      unit.hashCode ^
      thumbUrl.hashCode ^
      quantity.hashCode;

  @override
  String toString() {
    return 'ProductStore{' +
        ' productId: $productId,' +
        ' productName: $productName,' +
        ' productPrice: $productPrice,' +
        ' groupId: $groupId,' +
        ' unit: $unit,' +
        ' thumbUrl: $thumbUrl,' +
        ' quantity: $quantity,' +
        '}';
  }

  ProductStore copyWith({
    int? productId,
    String? productName,
    double? productPrice,
    int? groupId,
    String? unit,
    String? thumbUrl,
    int? quantity,
  }) {
    return ProductStore(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      groupId: groupId ?? this.groupId,
      unit: unit ?? this.unit,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      quantity: quantity ?? this.quantity,
    );
  }

//</editor-fold>
}
