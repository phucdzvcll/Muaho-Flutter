import 'package:muaho/domain/domain.dart';
import 'package:muaho/presentation/shop/model/product_model.dart';

class ShopDetailModel {
  final int currentIndex;
  final String shopName;
  final String shopAddress;
  final List<ProductGroupEntity> groups;
  final List<Product> currentListProducts;

//<editor-fold desc="Data Methods">

  const ShopDetailModel({
    required this.currentIndex,
    required this.shopName,
    required this.shopAddress,
    required this.groups,
    required this.currentListProducts,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopDetailModel &&
          runtimeType == other.runtimeType &&
          currentIndex == other.currentIndex &&
          shopName == other.shopName &&
          shopAddress == other.shopAddress &&
          groups == other.groups &&
          currentListProducts == other.currentListProducts);

  @override
  int get hashCode =>
      currentIndex.hashCode ^
      shopName.hashCode ^
      shopAddress.hashCode ^
      groups.hashCode ^
      currentListProducts.hashCode;

  @override
  String toString() {
    return 'ShopDetailModel{' +
        ' currentIndex: $currentIndex,' +
        ' shopName: $shopName,' +
        ' shopAddress: $shopAddress,' +
        ' groups: $groups,' +
        ' currentListProducts: $currentListProducts,' +
        '}';
  }

  ShopDetailModel copyWith({
    int? currentIndex,
    String? shopName,
    String? shopAddress,
    List<ProductGroupEntity>? groups,
    List<Product>? currentListProducts,
  }) {
    return ShopDetailModel(
      currentIndex: currentIndex ?? this.currentIndex,
      shopName: shopName ?? this.shopName,
      shopAddress: shopAddress ?? this.shopAddress,
      groups: groups ?? this.groups,
      currentListProducts: currentListProducts ?? this.currentListProducts,
    );
  }

//</editor-fold>
}
