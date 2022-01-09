import 'package:muaho/common/extensions/bool.dart';
import 'package:muaho/common/extensions/list.dart';
import 'package:muaho/common/extensions/network.dart';
import 'package:muaho/common/extensions/number.dart';
import 'package:muaho/common/extensions/string.dart';
import 'package:muaho/data/remote/user/user_service.dart';
import 'package:muaho/data/response/voucherlist/voucher_list_response.dart';
import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/voucher/voucher.dart';
import 'package:muaho/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserService userService;

  @override
  Future<Either<Failure, List<VoucherListItem>>> getVoucherList() async {
    NetworkResult<List<VoucherListResponse>> result =
        await handleNetworkResult(userService.getVoucherList());
    if (result.isSuccess()) {
      return SuccessValue(result.response
              ?.map((e) => VoucherListItem(
                    id: e.id.defaultZero(),
                    code: e.code.defaultEmpty(),
                    description: e.description.defaultEmpty(),
                    value: e.value.defaultZero(),
                    type: _mapType(e.type),
                    minOrderTotal: e.minOrderTotal.defaultZero(),
                    isApplyForAllShop: e.isApplyForAllShop.defaultFalse(),
                    shops: e.shops.defaultEmpty(),
                    numSecondRemain: _mapNumSecondRemain(e.lastDate),
                  ))
              .toList() ??
          []);
    } else {
      return FailValue(
        ServerError(
          msg: result.error,
          errorCode: result.errorCode,
        ),
      );
    }
  }

  UserRepositoryImpl({
    required this.userService,
  });

  int _mapNumSecondRemain(DateTime? lastDate) {
    if (lastDate != null) {
      DateTime now = DateTime.now();
      DateTime lastDateLocal = lastDate.toLocal();

      Duration distance = lastDateLocal.difference(now);
      if (!distance.isNegative) {
        return distance.inSeconds;
      }
    }
    return 0;
  }

  VoucherType _mapType(String? type) {
    if (type == "percent") {
      return VoucherType.percent;
    }
    return VoucherType.discount;
  }
}
