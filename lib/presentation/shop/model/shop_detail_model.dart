import 'package:muaho/domain/domain.dart';
import 'package:muaho/presentation/shop/model/cart_model.dart';
import 'package:muaho/presentation/shop/model/product_model.dart';

class ShopDetailModel {
  final int currentGroupId;
  final String shopName;
  final String shopAddress;
  final List<ProductGroupEntity> groups;
  final List<Product> currentListProducts;
  final CartOverViewModel cartOverView;

//<editor-fold desc="Data Methods">

  const ShopDetailModel({
    required this.currentGroupId,
    required this.shopName,
    required this.shopAddress,
    required this.groups,
    required this.currentListProducts,
    required this.cartOverView,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopDetailModel &&
          runtimeType == other.runtimeType &&
          currentGroupId == other.currentGroupId &&
          shopName == other.shopName &&
          shopAddress == other.shopAddress &&
          groups == other.groups &&
          currentListProducts == other.currentListProducts &&
          cartOverView == other.cartOverView);

  @override
  int get hashCode =>
      currentGroupId.hashCode ^
      shopName.hashCode ^
      shopAddress.hashCode ^
      groups.hashCode ^
      currentListProducts.hashCode ^
      cartOverView.hashCode;

  @override
  String toString() {
    return 'ShopDetailModel{' +
        ' currentIndex: $currentGroupId,' +
        ' shopName: $shopName,' +
        ' shopAddress: $shopAddress,' +
        ' groups: $groups,' +
        ' currentListProducts: $currentListProducts,' +
        ' cartOverView: $cartOverView,' +
        '}';
  }

  ShopDetailModel copyWith({
    int? currentIndex,
    String? shopName,
    String? shopAddress,
    List<ProductGroupEntity>? groups,
    List<Product>? currentListProducts,
    CartOverViewModel? cartOverView,
  }) {
    return ShopDetailModel(
      currentGroupId: currentIndex ?? this.currentGroupId,
      shopName: shopName ?? this.shopName,
      shopAddress: shopAddress ?? this.shopAddress,
      groups: groups ?? this.groups,
      currentListProducts: currentListProducts ?? this.currentListProducts,
      cartOverView: cartOverView ?? this.cartOverView,
    );
  }

//</editor-fold>
}
