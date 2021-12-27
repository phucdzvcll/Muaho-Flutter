import 'package:muaho/domain/domain.dart';

class PaymentEntity {
  final int shopID;
  final String shopAddress;
  final String shopName;
  final List<ProductEntity> productEntities;

//<editor-fold desc="Data Methods">

  const PaymentEntity({
    required this.shopID,
    required this.shopAddress,
    required this.shopName,
    required this.productEntities,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentEntity &&
          runtimeType == other.runtimeType &&
          shopID == other.shopID &&
          shopAddress == other.shopAddress &&
          shopName == other.shopName &&
          productEntities == other.productEntities);

  @override
  int get hashCode =>
      shopID.hashCode ^
      shopAddress.hashCode ^
      shopName.hashCode ^
      productEntities.hashCode;

  @override
  String toString() {
    return 'PaymentEntity{' +
        ' shopID: $shopID,' +
        ' shopAddress: $shopAddress,' +
        ' shopName: $shopName,' +
        ' productEntities: $productEntities,' +
        '}';
  }

  PaymentEntity copyWith({
    int? shopID,
    String? shopAddress,
    String? shopName,
    List<ProductEntity>? productEntities,
  }) {
    return PaymentEntity(
      shopID: shopID ?? this.shopID,
      shopAddress: shopAddress ?? this.shopAddress,
      shopName: shopName ?? this.shopName,
      productEntities: productEntities ?? this.productEntities,
    );
  }

//</editor-fold>
}
