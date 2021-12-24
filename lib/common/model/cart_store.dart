class CartStore {
  int shopId;
  String shopName;
  String shopAddress;
  List<ProductStore> productStores;

  void editCart(ProductStore product) {
    if (productStores.length == 0) {
      productStores.add(product);
    } else {
      bool isExist = false;
      for (var productStore in productStores) {
        if (productStore.productId == product.productId) {
          if (product.quantity == 0) {
            productStores.removeAt(productStores.indexOf(productStore));
            if (productStores.isEmpty) {
              this.shopId = -1;
              this.shopAddress = "";
              this.shopName = "";
            }
            break;
          } else {
            productStores[productStores.indexOf(productStore)] = product;
            isExist = true;
            break;
          }
        }
      }
      if (!isExist && product.quantity != 0) {
        productStores.add(product);
      }
    }
  }

  void clearStore() {
    this.shopId = -1;
    this.productStores.clear();
    this.shopName = "";
    this.shopAddress = "";
  }

//<editor-fold desc="Data Methods">

  CartStore({
    required this.shopId,
    required this.shopName,
    required this.shopAddress,
    required this.productStores,
  });

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

  CartStore copyWith({
    int? shopId,
    String? shopName,
    String? shopAddress,
    List<ProductStore>? productStores,
  }) {
    return CartStore(
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      shopAddress: shopAddress ?? this.shopAddress,
      productStores: productStores ?? this.productStores,
    );
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
