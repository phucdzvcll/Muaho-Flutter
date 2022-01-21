import 'package:muaho/features/order/domain/models/shop_product_entity.dart';

class PaymentInfoModel {
  final List<ProductEntity> productEntities;
  final UserInfo userInfo;
  final double totalAmount;

  PaymentInfoModel({
    required this.userInfo,
    required this.totalAmount,
    required this.productEntities,
  });
}

class UserInfo {
  final String phoneNumber;
  final String address;

  UserInfo({required this.phoneNumber, required this.address});
}
