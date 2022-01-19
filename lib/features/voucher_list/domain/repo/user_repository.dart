import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/features/voucher_list/domain/models/voucher.dart';

abstract class UserRepository {
  Future<Either<Failure, List<VoucherListItem>>> getVoucherList();
}
