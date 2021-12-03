class ShopProductEntity {
  final int shopId;
  final String shopName;
  final String shopAddress;
  final List<ProductGroupEntity> groups;
  final List<VoucherEntity> vouchers;
//<editor-fold desc="Data Methods">

  const ShopProductEntity({
    required this.shopId,
    required this.shopName,
    required this.shopAddress,
    required this.groups,
    required this.vouchers,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopProductEntity &&
          runtimeType == other.runtimeType &&
          shopId == other.shopId &&
          shopName == other.shopName &&
          shopAddress == other.shopAddress &&
          groups == other.groups &&
          vouchers == other.vouchers);

  @override
  int get hashCode =>
      shopId.hashCode ^
      shopName.hashCode ^
      shopAddress.hashCode ^
      groups.hashCode ^
      vouchers.hashCode;

  @override
  String toString() {
    return 'ShopProductEntity{' +
        ' shopId: $shopId,' +
        ' shopName: $shopName,' +
        ' shopAddress: $shopAddress,' +
        ' groups: $groups,' +
        ' vouchers: $vouchers,' +
        '}';
  }

  ShopProductEntity copyWith({
    int? shopId,
    String? shopName,
    String? shopAddress,
    List<ProductGroupEntity>? groups,
    List<VoucherEntity>? vouchers,
  }) {
    return ShopProductEntity(
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      shopAddress: shopAddress ?? this.shopAddress,
      groups: groups ?? this.groups,
      vouchers: vouchers ?? this.vouchers,
    );
  }

//</editor-fold>
}

class ProductGroupEntity {
  final int groupId;
  final String groupName;
  final List<ProductEntity> products;

//<editor-fold desc="Data Methods">

  const ProductGroupEntity({
    required this.groupId,
    required this.groupName,
    required this.products,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductGroupEntity &&
          runtimeType == other.runtimeType &&
          groupId == other.groupId &&
          groupName == other.groupName &&
          products == other.products);

  @override
  int get hashCode => groupId.hashCode ^ groupName.hashCode ^ products.hashCode;

  @override
  String toString() {
    return 'ProductGroupEntity{' +
        ' groupId: $groupId,' +
        ' groupName: $groupName,' +
        ' products: $products,' +
        '}';
  }

  ProductGroupEntity copyWith({
    int? groupId,
    String? groupName,
    List<ProductEntity>? products,
  }) {
    return ProductGroupEntity(
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      products: products ?? this.products,
    );
  }

//</editor-fold>
}

class ProductEntity {
  final int productId;
  final String productName;
  final double produtPrice;
  final String unit;
  final String thumbUrl;

//<editor-fold desc="Data Methods">

  const ProductEntity({
    required this.productId,
    required this.productName,
    required this.produtPrice,
    required this.unit,
    required this.thumbUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductEntity &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          productName == other.productName &&
          produtPrice == other.produtPrice &&
          unit == other.unit &&
          thumbUrl == other.thumbUrl);

  @override
  int get hashCode =>
      productId.hashCode ^
      productName.hashCode ^
      produtPrice.hashCode ^
      unit.hashCode ^
      thumbUrl.hashCode;

  @override
  String toString() {
    return 'ProductEntity{' +
        ' productId: $productId,' +
        ' productName: $productName,' +
        ' produtPrice: $produtPrice,' +
        ' unit: $unit,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

  ProductEntity copyWith({
    int? productId,
    String? productName,
    double? produtPrice,
    String? unit,
    String? thumbUrl,
  }) {
    return ProductEntity(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      produtPrice: produtPrice ?? this.produtPrice,
      unit: unit ?? this.unit,
      thumbUrl: thumbUrl ?? this.thumbUrl,
    );
  }

//</editor-fold>
}

class VoucherEntity {
  final int id;
  final String code;
  final String description;

//<editor-fold desc="Data Methods">

  const VoucherEntity({
    required this.id,
    required this.code,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VoucherEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          code == other.code &&
          description == other.description);

  @override
  int get hashCode => id.hashCode ^ code.hashCode ^ description.hashCode;

  @override
  String toString() {
    return 'VoucherEntity{' +
        ' id: $id,' +
        ' code: $code,' +
        ' description: $description,' +
        '}';
  }

  VoucherEntity copyWith({
    int? id,
    String? code,
    String? description,
  }) {
    return VoucherEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
    );
  }

//</editor-fold>
}
