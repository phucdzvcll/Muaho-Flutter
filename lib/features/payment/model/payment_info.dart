import 'package:muaho/domain/domain.dart';

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
