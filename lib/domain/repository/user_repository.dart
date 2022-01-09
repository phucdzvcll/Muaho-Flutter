import 'package:muaho/domain/domain.dart';
import 'package:muaho/domain/models/voucher/voucher.dart';

abstract class UserRepository {
  Future<Either<Failure, List<VoucherListItem>>> getVoucherList();
}
