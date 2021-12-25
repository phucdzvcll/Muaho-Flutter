import 'package:collection/collection.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/presentation/components/model/cart_over_view_model.dart';

class CartStore {
  int shopId = -1;
  String shopName = "";
  String shopAddress = "";
  List<ProductStore> productStores = [];

  void addToCart({required ProductStore productStore}) {
    ProductStore? product = findProductStore(productStore.productId);
    if (product != null) {
      int index = getIndexOfProduct(productStore.productId);
      productStores[index] =
          productStore.copyWith(quantity: productStore.quantity + 1);
    } else {
      this.productStores.add(productStore.copyWith(quantity: 1));
    }
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
  }

  CartOverViewModel getCartOverView() {
    int amount = 0;
    int totalItem = 0;
    double totalPrice = 0.0;

    if (this.productStores.isNotEmpty) {
      this.productStores.forEach((element) {
        if (element.quantity > 0) {
          amount += element.quantity;
          totalItem += 1;
          totalPrice += element.quantity * element.productPrice;
        }
      });
    }

    return CartOverViewModel(
        amount: "$amount đơn vị - $totalItem sản phầm",
        totalPrice: totalPrice.formatDouble() + " VNĐ");
  }

  void clearStore() {
    this.shopId = -1;
    this.productStores.clear();
    this.shopName = "";
    this.shopAddress = "";
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

  CartStore();

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
