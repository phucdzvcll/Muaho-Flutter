import 'package:muaho/common/common.dart';
import 'package:muaho/domain/domain.dart';

import '../../components/model/cart_over_view_model.dart';

class OrderDetailModel {
  final int currentGroupId;
  final String shopName;
  final String shopAddress;
  final int shopID;
  final List<ProductGroupEntity> groups;
  final List<ProductStore> currentListProducts;
  final CartOverViewModel cartOverView;

//<editor-fold desc="Data Methods">

  const OrderDetailModel({
    required this.shopID,
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
      (other is OrderDetailModel &&
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
        ' shopID: $shopID,' +
        '}';
  }

  OrderDetailModel copyWith({
    int? currentIndex,
    String? shopName,
    String? shopAddress,
    List<ProductGroupEntity>? groups,
    List<ProductStore>? currentListProducts,
    CartOverViewModel? cartOverView,
    int? shopID,
  }) {
    return OrderDetailModel(
      shopID: shopID ?? this.shopID,
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
