import 'package:muaho/common/domain/either.dart';
import 'package:muaho/common/domain/failure.dart';
import 'package:muaho/common/domain/use_case.dart';
import 'package:muaho/features/voucher_list/domain/models/voucher.dart';
import 'package:muaho/features/voucher_list/domain/repo/user_repository.dart';

class GetVoucherListUseCase
    extends BaseUseCase<EmptyInput, List<VoucherListItem>> {
  final UserRepository userRepository;

  GetVoucherListUseCase({required this.userRepository});

  @override
  Future<Either<Failure, List<VoucherListItem>>> executeInternal(
      EmptyInput input) async {
    return await userRepository.getVoucherList();
  }
}
