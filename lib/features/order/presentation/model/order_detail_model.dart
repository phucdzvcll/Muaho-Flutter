import 'package:muaho/common/common.dart';
import 'package:muaho/features/order/domain/models/shop_product_entity.dart';

class OrderDetailModel {
  final int currentGroupId;
  final String shopName;
  final String shopAddress;
  final int shopID;
  final List<ProductGroupEntity> groups;
  final List<ProductEntity> currentListProducts;
  final CartSummary cartInfo;

//<editor-fold desc="Data Methods">

  const OrderDetailModel({
    required this.shopID,
    required this.currentGroupId,
    required this.shopName,
    required this.shopAddress,
    required this.groups,
    required this.currentListProducts,
    required this.cartInfo,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderDetailModel &&
          runtimeType == other.runtimeType &&
          currentGroupId == other.currentGroupId &&
          shopName == other.shopName &&
          shopAddress == other.shopAddress &&
          groups == other.groups &&
          currentListProducts == other.currentListProducts &&
          cartInfo == other.cartInfo);

  @override
  int get hashCode =>
      currentGroupId.hashCode ^
      shopName.hashCode ^
      shopAddress.hashCode ^
      groups.hashCode ^
      currentListProducts.hashCode ^
      cartInfo.hashCode;

  @override
  String toString() {
    return 'ShopDetailModel{' +
        ' currentIndex: $currentGroupId,' +
        ' shopName: $shopName,' +
        ' shopAddress: $shopAddress,' +
        ' groups: $groups,' +
        ' currentListProducts: $currentListProducts,' +
        ' cartOverView: $cartInfo,' +
        ' shopID: $shopID,' +
        '}';
  }

  OrderDetailModel copyWith({
    int? currentIndex,
    String? shopName,
    String? shopAddress,
    List<ProductGroupEntity>? groups,
    List<ProductEntity>? currentListProducts,
    CartSummary? cartInfo,
    int? shopID,
  }) {
    return OrderDetailModel(
      shopID: shopID ?? this.shopID,
      currentGroupId: currentIndex ?? this.currentGroupId,
      shopName: shopName ?? this.shopName,
      shopAddress: shopAddress ?? this.shopAddress,
      groups: groups ?? this.groups,
      currentListProducts: currentListProducts ?? this.currentListProducts,
      cartInfo: cartInfo ?? this.cartInfo,
    );
  }

//</editor-fold>
}
