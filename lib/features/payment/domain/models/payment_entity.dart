import 'package:equatable/equatable.dart';
import 'package:muaho/features/order/domain/models/shop_product_entity.dart';

class PaymentEntity extends Equatable {
  final int shopID;
  final String shopAddress;
  final String shopName;
  final List<ProductEntity> productEntities;

  const PaymentEntity({
    required this.shopID,
    required this.shopAddress,
    required this.shopName,
    required this.productEntities,
  });

  @override
  List<Object?> get props => [
        shopID,
        shopAddress,
        shopName,
        productEntities,
      ];
}
