import 'package:muaho/common/common.dart';

class PaymentInfoModel {
  final UserInfo userInfo;
  final CartStore cartStore;
  final double total;
  PaymentInfoModel(
      {required this.userInfo, required this.cartStore, required this.total});
}

class UserInfo {
  final String phoneNumber;
  final String address;

  UserInfo({required this.phoneNumber, required this.address});
}
