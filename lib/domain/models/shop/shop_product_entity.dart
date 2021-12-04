class ShopProductEntity {
  final int shopId;
  final String shopName;
  final String shopAddress;
  final List<ProductGroupEntity> groups;
  final List<VoucherEntity> vouchers;
  final List<ProductEntity> products;

//<editor-fold desc="Data Methods">

  const ShopProductEntity({
    required this.shopId,
    required this.shopName,
    required this.shopAddress,
    required this.groups,
    required this.vouchers,
    required this.products,
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
          vouchers == other.vouchers &&
          products == other.products);

  @override
  int get hashCode =>
      shopId.hashCode ^
      shopName.hashCode ^
      shopAddress.hashCode ^
      groups.hashCode ^
      vouchers.hashCode ^
      products.hashCode;

  @override
  String toString() {
    return 'ShopProductEntity{' +
        ' shopId: $shopId,' +
        ' shopName: $shopName,' +
        ' shopAddress: $shopAddress,' +
        ' groups: $groups,' +
        ' vouchers: $vouchers,' +
        ' products: $products,' +
        '}';
  }

  ShopProductEntity copyWith({
    int? shopId,
    String? shopName,
    String? shopAddress,
    List<ProductGroupEntity>? groups,
    List<VoucherEntity>? vouchers,
    List<ProductEntity>? products,
  }) {
    return ShopProductEntity(
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      shopAddress: shopAddress ?? this.shopAddress,
      groups: groups ?? this.groups,
      vouchers: vouchers ?? this.vouchers,
      products: products ?? this.products,
    );
  }

//</editor-fold>
}

class ProductGroupEntity {
  final int groupId;
  final String groupName;

//<editor-fold desc="Data Methods">

  const ProductGroupEntity({
    required this.groupId,
    required this.groupName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductGroupEntity &&
          runtimeType == other.runtimeType &&
          groupId == other.groupId &&
          groupName == other.groupName);

  @override
  int get hashCode => groupId.hashCode ^ groupName.hashCode;

  @override
  String toString() {
    return 'ProductGroupEntity{' +
        ' groupId: $groupId,' +
        ' groupName: $groupName,' +
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
    );
  }

//</editor-fold>
}

class ProductEntity {
  final int productId;
  final String productName;
  final double productPrice;
  final int groupId;
  final String unit;
  final String thumbUrl;

//<editor-fold desc="Data Methods">

  const ProductEntity({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.groupId,
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
          productPrice == other.productPrice &&
          groupId == other.groupId &&
          unit == other.unit &&
          thumbUrl == other.thumbUrl);

  @override
  int get hashCode =>
      productId.hashCode ^
      productName.hashCode ^
      productPrice.hashCode ^
      groupId.hashCode ^
      unit.hashCode ^
      thumbUrl.hashCode;

  @override
  String toString() {
    return 'ProductEntity{' +
        ' productId: $productId,' +
        ' productName: $productName,' +
        ' productPrice: $productPrice,' +
        ' groupId: $groupId,' +
        ' unit: $unit,' +
        ' thumbUrl: $thumbUrl,' +
        '}';
  }

  ProductEntity copyWith({
    int? productId,
    String? productName,
    double? productPrice,
    int? groupId,
    String? unit,
    String? thumbUrl,
  }) {
    return ProductEntity(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      groupId: groupId ?? this.groupId,
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
